
from subprocess import getoutput
import os
import time
import urllib.request
import json


def curl(url):
    try:
        response = urllib.request.urlopen(url)
        if response.status == 200:
            # 响应状态码为200表示请求成功
            data = response.read().decode('utf-8')
            # json_data = json.loads(data)
            # print(json_data)
            return data
        else:
            print(f'Error: {response.status} {response.reason}')
    except urllib.error.URLError as e:
        print(f'Error: {e.reason}')

# 使用curl函数发送GET请求并解析JSON数据
# curl('https://api.example.com/data')

# 使用curl函数发送POST请求并处理错误状态码
# data = {'key1': 'value1', 'key2': 'value2'}
# curl('https://api.example.com/data', data=data)
# xx=os.popen('curl www.baidu.com').readlines()  # BUG 中文乱码


# better_cf_ips = getoutput('curl https://raw.githubusercontent.com/Alvin9999/new-pac/master/CloudFlare%E4%BC%98%E8%B4%A8IP',encoding='utf-8')
# freefq_doc = getoutput('curl https://raw.githubusercontent.com/freefq/free/master/README.md',encoding='utf-8')

better_cf_ips = curl('https://raw.githubusercontent.com/Alvin9999/new-pac/master/CloudFlare%E4%BC%98%E8%B4%A8IP')
freefq_doc = curl('https://raw.githubusercontent.com/freefq/free/master/README.md')
vless_node = curl('https://vless-node.lgf4591.workers.dev/0d9163eb-b54f-4144-b7a2-96efda0f4ee7')

update_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())

hysteria1_urls = [
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/hysteria/1/config.json',
    'https://www.githubip.xyz/Alvin9999/pac2/master/hysteria/config.json',
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/hysteria/13/config.json',
    'https://www.githubip.xyz/Alvin9999/pac2/master/hysteria/2/config.json'
    ]
hysteria2_urls = [
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/hysteria2/1/config.json',
    'https://www.githubip.xyz/Alvin9999/pac2/master/hysteria2/config.json',
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/hysteria2/13/config.json',
    'https://www.githubip.xyz/Alvin9999/pac2/master/hysteria2/2/config.json'
]
naiveproxy_urls = [
    'https://www.gitlabip.xyz/Alvin9999/PAC/master/naiveproxy/1/config.json',
    'https://www.githubip.xyz/Alvin9999/PAC/master/naiveproxy/config.json'
]
singbox_urls = [
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/singbox/1/config.json',
    'https://www.githubip.xyz/Alvin9999/pac2/master/singbox/config.json'
]
xray_urls = [
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/xray/1/config.json',
    'https://www.githubip.xyz/Alvin9999/pac2/master/xray/config.json',
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/xray/3/config.json',
    'https://www.githubip.xyz/Alvin9999/pac2/master/xray/2/config.json'
]
clashMeta_urls = [
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/clash.meta/1/config.yaml',
    'https://www.githubip.xyz/Alvin9999/pac2/master/clash.meta/config.yaml',
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/clash.meta/13/config.yaml',
    'https://www.githubip.xyz/Alvin9999/pac2/master/clash.meta/2/config.yaml',
    'https://www.gitlabip.xyz/Alvin9999/pac2/master/clash.meta/15/config.yaml',
    'https://www.githubip.xyz/Alvin9999/pac2/master/clash.meta/3/config.yaml'
]
psiphon_urls = [
    ''
]


hysteria1_configs = list(map(curl, hysteria1_urls))
hysteria2_configs = list(map(curl, hysteria2_urls))
naiveproxy_configs = list(map(curl, naiveproxy_urls))
singbox_configs = list(map(curl, singbox_urls))
xray_configs = list(map(curl, xray_urls))
clashMeta_configs = list(map(curl, clashMeta_urls))

for (index,config) in enumerate(hysteria1_configs):
    with open(f"./ChromeGo/hysteria1/ip_{index}.json", "w",encoding="utf-8") as config_file:
        config_file.write(config)

for (index,config) in enumerate(hysteria2_configs):
    with open(f"./ChromeGo/hysteria2/ip_{index}.json", "w",encoding="utf-8") as config_file:
        config_file.write(config)

for (index,config) in enumerate(naiveproxy_configs):
    with open(f"./ChromeGo/naiveproxy/ip_{index}.json", "w",encoding="utf-8") as config_file:
        config_file.write(config)
        
for (index,config) in enumerate(singbox_configs):
    with open(f"./ChromeGo/singbox/ip_{index}.json", "w",encoding="utf-8") as config_file:
        config_file.write(config)      

for (index,config) in enumerate(xray_configs):
    with open(f"./ChromeGo/xray/ip_{index}.json", "w",encoding="utf-8") as config_file:
        config_file.write(config)   
        
for (index,config) in enumerate(clashMeta_configs):
    with open(f"./ChromeGo/clashMeta/ip_{index}.yaml", "w",encoding="utf-8") as config_file:
        config_file.write(config)   
              

readme_doc = """

================================= Last Update Time: {} =============================================

# cloudflare-pages-vpn

##### https://replit.com/@lgf4591/WarpKey
##### [wireguad-config-generator](https://github.com/lgf4591/wireguad-config-generator)
##### [fanqiang](https://github.com/bannedbook/fanqiang)
##### [chromego_merge](https://github.com/vveg26/chromego_merge)

```
need install packages:

sudo apt update && sudo apt upgrade -y
sudo apt install -y qrencode

cp -r /mnt/c/Users/lgf/.ssh ~
cd ~/.ssh
chmod 600 *id_rsa
chmod 644 *id_rsa.pub
ssh -T git@github.com

git clone git@github.com:lgf4591/cloudflare-pages-vpn.git
git config --global user.name "lgf4591"
git config --global user.email "lgf4591@outlook.com"
git pull origin main

```

## [cloudfare免费代理节点: v2ray-nodes](https://v2ray-nodes.lgf4591.workers.dev/b58a6cd1-43da-4506-aaec-308045412f2d)

## [cloudfare免费vless节点: vless-node](https://vless-node.lgf4591.workers.dev/0d9163eb-b54f-4144-b7a2-96efda0f4ee7)
```

{}

```


## 免费的ChormeGo节点汇总  (test)

### [clashmeta-全平台通用](https://github.com/vveg26/chromego_merge/tree/main#%E4%B8%8D%E5%A5%97warp%E7%89%88%E6%9C%ACclashmeta-%E5%85%A8%E5%B9%B3%E5%8F%B0%E9%80%9A%E7%94%A8-%E8%8A%82%E7%82%B9%E6%9C%80%E5%85%A8)

#### 所有ChromeGo代理节点订阅地址（不可以访问一些敏感资源）

```

https://cloudflare-pages-vpn.pages.dev/ChromeGo/all_merged_proxies.yaml
https://cloudflare-pages-vpn.pages.dev/chromego_merge/sub/merged_proxies_new.yaml (推荐用这个)

```

#### 套warp的所有ChromeGo代理节点订阅地址（可以访问一些敏感资源）

```

https://cloudflare-pages-vpn.pages.dev/ChromeGo/all_merged_proxies_with_warp.yaml
https://cloudflare-pages-vpn.pages.dev/chromego_merge/sub/merged_warp_proxies_new.yaml (推荐用这个)

```


### [通用链接 shadowrocket-nekoray](https://github.com/vveg26/chromego_merge/tree/main#%E9%80%9A%E7%94%A8%E9%93%BE%E6%8E%A5-shadowrocket-nekoray)

```

https://cloudflare-pages-vpn.pages.dev/ChromeGo/all_merged_proxies_shadowrocket_nekoray.txt
https://cloudflare-pages-vpn.pages.dev/chromego_merge/sub/shadowrocket_base64.txt (推荐用这个)

```

# CloudFlare优质IP
```
{}
```

# [freefq](https://github.com/freefq/free)

{}


# [ChromeGo Config](https://github.com/bannedbook/fanqiang/releases/tag/ChromeGo-latest)

## hysteria1 config json
### [hysteria1 ip_1]({})
```
{}
```

### [hysteria1 ip_2]({})
```
{}
```

### [hysteria1 ip_3]({})
```
{}
```

### [hysteria1 ip_4]({})
```
{}
```

## hysteria2 config json
### [hysteria2 ip_1]({})
```
{}
```

### [hysteria2 ip_2]({})
```
{}
```

### [hysteria2 ip_3]({})
```
{}
```

### [hysteria2 ip_4]({})
```
{}
```


## naiveproxy config json

### [naiveproxy ip_1]({})
```
{}
```

### [naiveproxy ip_2]({})
```
{}
```


## singbox config json

### [singbox ip_1]({})
```
{}
```

### [singbox ip_2]({})
```
{}
```


## xray config json

### [xray ip_1]({})
```
{}
```

### [xray ip_2]({})
```
{}
```



## clashMeta config yaml

### [clashMeta ip_1]({})
```
{}
```

### [clashMeta ip_2]({})
```
{}
```

### [clashMeta ip_3]({})
```
{}
```

### [clashMeta ip_4]({})
```
{}
```

### [clashMeta ip_5]({})
```
{}
```

### [clashMeta ip_6]({})
```
{}
```

"""

markdown_doc = readme_doc.format(update_time,vless_node,better_cf_ips,freefq_doc,hysteria1_urls[0],hysteria1_configs[0],hysteria1_urls[1],hysteria1_configs[1],hysteria1_urls[2],hysteria1_configs[2],hysteria1_urls[3],hysteria1_configs[3],hysteria2_urls[0],hysteria2_configs[0],hysteria2_urls[1],hysteria2_configs[1],hysteria2_urls[2],hysteria2_configs[2],hysteria2_urls[3],hysteria2_configs[3],naiveproxy_urls[0],naiveproxy_configs[0],naiveproxy_urls[1],naiveproxy_configs[1],singbox_urls[0],singbox_configs[0],singbox_urls[1],singbox_configs[1],xray_urls[0],xray_configs[0],xray_urls[1],xray_configs[1],clashMeta_urls[0],clashMeta_configs[0],clashMeta_urls[1],clashMeta_configs[1],clashMeta_urls[2],clashMeta_configs[2],clashMeta_urls[3],clashMeta_configs[3],clashMeta_urls[4],clashMeta_configs[4],clashMeta_urls[5],clashMeta_configs[5])

try:
    with open("./README.md", "w",encoding="utf-8") as readme_file:
        readme_file.write(markdown_doc)
        
    print("Content successfully encoded and written to README.md file.")
except Exception as e:
    print(f"Error encoding file content: {e}")

