## 简介

**注意：clash内核无法使用这些节点，你要用clashmeta**

开启浏览器自带doh以及客户端tun模式也可绕过封锁，参考：https://blog.mareep.net/posts/9993/


## 注意事项
<details>
  <summary>点击展开/折叠</summary>
1. 套上warp可以突破封锁，可以访问一些机场主不让你访问的网站
  
2. 套上warp可以增强隐私性，防止机场主偷看你的隐私

3. 提取节点出来，方便在自己的客户端使用，第三方客户端并不能确保安全
</details>

## 如何修改为自己的warp节点

<details>
  <summary>点击展开/折叠</summary>
可以用warp+机器人和提取wg节点替换掉配置文件中的wg信息
[warp提取wireguard网站](https://replit.com/@misaka-blog/wgcf-profile-generator)
[warp+机器人](https://t.me/generatewarpplusbot)
</details>

## 订阅链接分享
### 不套warp版本（clashmeta）
**不含hysteria2节点**
```
https://mareep.netlify.app/sub/merged_proxies.yaml
```
**含hysteria2节点(节点最全）**
```
https://mareep.netlify.app/sub/merged_proxies_new.yaml
```
### 套warp版本（clashmeta)
**不含hysteria2节点**
```
https://mareep.netlify.app/sub/merged_warp_proxies.yaml
```
**含hysteria2节点(节点最全）**
```
https://mareep.netlify.app/sub/merged_warp_proxies_new.yaml
```
### 通用链接 （shadowrocket和nekoray）
```
https://mareep.netlify.app/sub/shadowrocket_base64.txt
```

### sing-box订阅链接

```
https://sing-box-subscribe.vercel.app/config/https:/mareep.netlify.app/sub/merged_proxies_new.yaml
```

## 客户端推荐
### Windows
- [clash verge](https://github.com/zzzgydi/clash-verge/releases) 需要更换内核为最新版本才能支持hysteria2
- [nekoray](https://github.com/MatsuriDayo/nekoray)
### android
- [nekobox](https://github.com/MatsuriDayo/NekoBoxForAndroid)
- [clashmeta for android](https://github.com/MetaCubeX/ClashMetaForAndroid/releases/tag/Prerelease-alpha) 预发行版
### ios
- shadowrockt

### macos
- [clashx.meta](https://github.com/MetaCubeX/ClashX.Meta/releases/tag/v1.3.6)
- shadowrocket
- clash verge


## 致谢
[Alvin9999](https://github.com/Alvin9999/pac2/tree/master)

## TODO
- 部分代码逻辑不够优雅
- sing-box节点的处理
- xray部分节点的处理
- 融合ss和ssr


