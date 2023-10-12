#!/bin/sh

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

wgcf_exec="./wgcf-linux"

rm -f wgcf-account.toml wgcf-profile.conf
echo | ${wgcf_exec} register --accept-tos yes
chmod +x wgcf-account.toml

# clear
yellow "请选择需要使用的 WARP 账户类型"
echo ""
echo -e " ${GREEN}1.${PLAIN} WARP 免费账户 ${YELLOW}(默认)${PLAIN}"
echo -e " ${GREEN}2.${PLAIN} WARP+"
echo -e " ${GREEN}3.${PLAIN} WARP Teams"
echo ""
read -p "请输入选项 [1-3]: " account_type
if [[ $account_type == 2 ]]; then
  yellow "获取 CloudFlare WARP 账号密钥信息方法: "
  green "电脑: 下载并安装 CloudFlare WARP → 设置 → 偏好设置 → 账户 →复制密钥到脚本中"
  green "手机: 下载并安装 1.1.1.1 APP → 菜单 → 账户 → 复制密钥到脚本中"
  echo ""
  yellow "重要：请确保手机或电脑的 1.1.1.1 APP 的账户状态为WARP+！"
  echo ""
  read -rp "输入 WARP 账户许可证密钥 (26个字符): " warpkey
  until [[ $warpkey =~ ^[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}-[A-Z0-9a-z]{8}$ ]]; do
    red "WARP 账户许可证密钥格式输入错误，请重新输入！"
    read -rp "输入 WARP 账户许可证密钥 (26个字符): " warpkey
  done
  sed -i "s/license_key.*/license_key = \"$warpkey\"/g" wgcf-account.toml
  read -rp "请输入自定义设备名，如未输入则使用默认随机设备名: " devicename
  green "注册 WARP+ 账户中, 如下方显示: 400 Bad Request, 则使用 WARP 免费版账户"
  if [[ -n $devicename ]]; then
    ${wgcf_exec} update --name $(echo $devicename | sed s/[[:space:]]/_/g)
  else
    ${wgcf_exec} update
  fi
  ${wgcf_exec} generate
elif [[ $account_type == 3 ]]; then
  ${wgcf_exec} generate
  chmod +x wgcf-profile.conf
  
  yellow "请选择申请 WARP Teams 账户方式"
  echo ""
  echo -e " ${GREEN}1.${PLAIN} 使用 Teams TOKEN ${YELLOW}(默认)${PLAIN}"
  echo -e " ${GREEN}2.${PLAIN} 使用提取出来的 xml 配置文件"
  echo ""
  read -p "请输入选项 [1-2]: " team_type

  if [[ $team_type == 2 ]]; then
    yellow "获取 WARP Teams 账户 xml 配置文件方法：https://blog.misaka.rest/2023/02/11/wgcfteam-config/"
    yellow "请将提取到的 xml 配置文件上传至：https://gist.github.com"
    read -rp "请粘贴 WARP Teams 账户配置文件链接：" teamconfigurl
    if [[ -n $teamconfigurl ]]; then
      teams_config=$(curl -sSL "$teamconfigurl" | sed "s/\"/\&quot;/g")
      private_key=$(expr "$teams_config" : '.*private_key&quot;>\([^<]*\).*')
      private_v6=$(expr "$teams_config" : '.*v6&quot;:&quot;\([^[&]*\).*')
      sed -i "s#PrivateKey.*#PrivateKey = $private_key#g" wgcf-profile.conf;
      sed -i "s#Address.*128#Address = $private_v6/128#g" wgcf-profile.conf;
    else
      red "未提供WARP Teams 账户配置文件链接，脚本退出！"
      exit 1
    fi
  else
    # 询问用户 WARP Teams 账户 TOKEN，并提示获取方式
    yellow "请在此网站：https://web--public--warp-team-api--coia-mfs4.code.run/ 获取你的 WARP Teams 账户 TOKEN"
    read -rp "请输入 WARP Teams 账户的 TOKEN：" teams_token

    if [[ -n $teams_token ]]; then
      # 生成 WireGuard 公私钥及 WARP 设备 ID 和 FCM Token
      private_key=$(wg genkey)
      public_key=$(wg pubkey <<< "$private_key")
      install_id=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 22)
      fcm_token="${install_id}:APA91b$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 134)"

      # 使用 CloudFlare API 申请 Teams 配置信息
      team_result=$(curl --silent --location --tlsv1.3 --request POST 'https://api.cloudflareclient.com/v0a2158/reg' \
        --header 'User-Agent: okhttp/3.12.1' \
        --header 'CF-Client-Version: a-6.10-2158' \
        --header 'Content-Type: application/json' \
        --header "Cf-Access-Jwt-Assertion: ${team_token}" \
        --data '{"key":"'${public_key}'","install_id":"'${install_id}'","fcm_token":"'${fcm_token}'","tos":"'$(date +"%Y-%m-%dT%H:%M:%S.%3NZ")'","model":"Linux","serial_number":"'${install_id}'","locale":"zh_CN"}')

      # 提取 WARP IPv6 内网地址，用于替换 wgcf-profile.conf 文件中对应的内容
      private_v6=$(expr "$team_result" : '.*"v6":[ ]*"\([^"]*\).*')
      
      sed -i "s#PrivateKey.*#PrivateKey = $private_key#g" wgcf-profile.conf;
      sed -i "s#Address.*128#Address = $private_v6/128#g" wgcf-profile.conf;
    fi
  fi
else
  ${wgcf_exec} generate
fi

# clear
green "WGCF 的 WireGuard 配置文件已生成成功！"
yellow "下面是配置文件内容："
red "$(cat wgcf-profile.conf)"
echo ""
yellow "下面是配置文件分享二维码："
qrencode -t ansiutf8 < wgcf-profile.conf
echo ""
yellow "请在本地使用此方法：https://blog.misaka.rest/2023/03/12/cf-warp-yxip/ 优选可用的 Endpoint IP"