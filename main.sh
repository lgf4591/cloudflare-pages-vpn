#! /bin/sh
cd ./ChromeGo && sh get_all_proxies.sh

# wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_windows_amd64.exe -O ./warp/windows/wgcf.exe
wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_linux_amd64 -O ./warp/linux/wgcf
wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_darwin_amd64 -O ./warp/macos/wgcf
wget -c https://github.com/ViRb3/wgcf/releases/download/v2.2.19/wgcf_2.2.19_freebsd_amd64 -O ./warp/unix/wgcf-freebsd