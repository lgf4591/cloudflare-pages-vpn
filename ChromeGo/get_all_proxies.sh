#! /bin/sh
mkdir -p clash
mkdir -p wireguard

curl -L https://mareep.netlify.app/sub/merged_proxies_new.yaml -o all_merged_proxies.yaml
curl -L https://mareep.netlify.app/sub/merged_warp_proxies_new.yaml -o all_merged_proxies_with_warp.yaml
curl -L https://mareep.netlify.app/sub/shadowrocket_base64.txt -o all_merged_proxies_shadowrocket_nekoray.txt


