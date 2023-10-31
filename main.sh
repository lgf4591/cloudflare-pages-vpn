#! /bin/sh
cd ./ChromeGo && sh get_all_proxies.sh && cd ..

wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_windows_amd64.exe -O ./warp/windows/wgcf.exe
wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_linux_amd64 -O ./warp/linux/wgcf
wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_darwin_amd64 -O ./warp/macos/wgcf
wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_freebsd_amd64 -O ./warp/unix/wgcf-freebsd

python main.py

python markdown_to_html.py

cd ChromeGo_Merge
print("Install dependencies")
pip install -r requirements.txt
print("Run merge script")
python meta_merge.py 
print("Run shadowrocket merge script")
python merge.py 
print("finished!!!")