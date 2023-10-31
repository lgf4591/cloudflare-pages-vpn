
from subprocess import getoutput
import os

# xx=os.popen('curl www.baidu.com').readlines()  # BUG 中文乱码
better_cf_ips = getoutput('curl https://raw.githubusercontent.com/Alvin9999/new-pac/master/CloudFlare%E4%BC%98%E8%B4%A8IP',encoding='utf-8')
freefq_doc = getoutput('curl https://raw.githubusercontent.com/freefq/free/master/README.md',encoding='utf-8')

readme_doc = """
# cloudflare-pages-vpn

https://replit.com/@lgf4591/WarpKey

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

## 免费的ChormeGo节点汇总  (test)

### [clashmeta-全平台通用](https://github.com/vveg26/chromego_merge/tree/main#%E4%B8%8D%E5%A5%97warp%E7%89%88%E6%9C%ACclashmeta-%E5%85%A8%E5%B9%B3%E5%8F%B0%E9%80%9A%E7%94%A8-%E8%8A%82%E7%82%B9%E6%9C%80%E5%85%A8)

#### 所有ChromeGo代理节点订阅地址（不可以访问一些敏感资源）

```
https://cloudflare-pages-vpn.pages.dev/ChromeGo/all_merged_proxies.yaml
```

#### 套warp的所有ChromeGo代理节点订阅地址（可以访问一些敏感资源）

```
https://cloudflare-pages-vpn.pages.dev/ChromeGo/all_merged_proxies_with_warp.yaml
```


### [通用链接 shadowrocket-nekoray](https://github.com/vveg26/chromego_merge/tree/main#%E9%80%9A%E7%94%A8%E9%93%BE%E6%8E%A5-shadowrocket-nekoray)

```
https://cloudflare-pages-vpn.pages.dev/ChromeGo/all_merged_proxies_shadowrocket_nekoray.txt
```

# CloudFlare优质IP
```
{}
```

# [freefq](https://github.com/freefq/free)

{}


"""

markdown_doc = readme_doc.format(better_cf_ips,freefq_doc)

try:
    with open("./README.md", "w",encoding="utf-8") as readme_file:
        readme_file.write(markdown_doc)
        
    print("Content successfully encoded and written to README.md file.")
except Exception as e:
    print(f"Error encoding file content: {e}")

