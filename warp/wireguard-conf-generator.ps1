
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# Install-Module -Name QRCodeGenerator
Import-Module QRCodeGenerator

# $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
# $PSDefaultParameterValues['*:Encoding'] = 'utf8'

$PSDefaultParameterValues = @{
    "default:endpoint"="engage.cloudflareclient.com:2408"
    "default:license_key"="cbX45J60-491Su7HZ-yz2st601"
}

$Endpoint = Read-Host -Prompt "Enter your endpoint(default:engage.cloudflareclient.com:2408)"
$license_key = Read-Host -Prompt "Enter your license_key(default:cbX45J60-491Su7HZ-yz2st601)"

# If($Endpoint)
# {
#     $PSDefaultParameterValues["default:endpoint"] = $Endpoint
# }
# If($license_key)
# {
#     $PSDefaultParameterValues["default:license_key"] = $license_key
# }

if ([String]::IsNullOrEmpty($Endpoint))
{
    $Endpoint = $PSDefaultParameterValues["default:endpoint"]
}
if ([String]::IsNullOrEmpty($license_key))
{
    $license_key = $PSDefaultParameterValues["default:license_key"]
}


$CONFIG_PATH="wgcf-account.toml"
$TRUE_FALSE=(Test-Path $CONFIG_PATH)
if($TRUE_FALSE -eq "True")
{
    Remove-Item -Recurse -Force $CONFIG_PATH
}

.\wgcf_2.2.19_windows_amd64.exe register --accept-tos yes

$wgcf_account = Get-Content wgcf-account.toml -Raw
# $wgcf_account -replace "(?m)^license_key.*","license_key = '$($PSDefaultParameterValues['default:license_key'])'"
$achive_wgcf_account  = $wgcf_account -replace "(?m)^license_key.*","license_key = '$license_key'"
# 文件保存格式有问题导致程序wgcf_2.2.19_windows_amd64.exe 读取文件的时候报错
# $achive_wgcf_account > conf\${license_key}_wgcf-account.toml   此格式为带有BOM的UTF16
# $achive_wgcf_account > wgcf-account.toml  此格式为带有BOM的UTF16
# Write-Output $achive_wgcf_account | Out-File -Encoding UTF8NoBOM conf\${license_key}_wgcf-account.toml  提示没有UTF8NoBOM会报红色错误，但是能运行
# Write-Output $achive_wgcf_account | Out-File -Encoding UTF8NoBOM  wgcf-account.toml  提示没有UTF8NoBOM会报红色错误，但是能运行
# Write-Output $achive_wgcf_account | Out-File -Encoding utf8  wgcf-account.toml  此格式为带有BOM的UTF8
# Write-Output $achive_wgcf_account | Out-File -Encoding ASCII conf\${license_key}_wgcf-account.toml
Write-Output $achive_wgcf_account | Out-File -Encoding ASCII  wgcf-account.toml 
Get-Content wgcf-account.toml


$CONFIG_PATH="wgcf-profile.conf"
$TRUE_FALSE=(Test-Path $CONFIG_PATH)
if($TRUE_FALSE -eq "True")
{
    Remove-Item -Recurse -Force $CONFIG_PATH
}

.\wgcf_2.2.19_windows_amd64.exe update
.\wgcf_2.2.19_windows_amd64.exe generate
Get-Content wgcf-profile.conf

if (Test-Path wgcf-profile.conf) {
    <# Action to perform if the condition is true #>
    $wgcf_profile = Get-Content wgcf-profile.conf -Raw
    $achive_wgcf_profile  = $wgcf_profile -replace "(?m)^Endpoint.*","Endpoint = $Endpoint"
    # $achive_wgcf_profile > conf\${license_key}_wgcf-profile.conf
    # $achive_wgcf_profile > wgcf-profile.conf
    # Write-Output $achive_wgcf_profile | Out-File -Encoding ASCII conf\${license_key}_wgcf-profile.conf
    Write-Output $achive_wgcf_profile | Out-File -Encoding ASCII wgcf-profile.conf
    Get-Content wgcf-profile.conf

    New-PSOneQRCodeText -Text $achive_wgcf_profile -Show
}

$connect_success_flag = Read-Host -Prompt "请测试扫描链接是否成功，若成功则将相关文件进行归档"
if ($connect_success_flag -eq "y") {
    <# Action to perform if the condition is true #>
    Write-Output "进行归档！！！"
    Write-Output $achive_wgcf_account | Out-File -Encoding ASCII conf\${license_key}_wgcf-account.toml
    Write-Output $achive_wgcf_profile | Out-File -Encoding ASCII conf\${license_key}_wgcf-profile.conf
    New-PSOneQRCodeText -Text $achive_wgcf_profile -OutPath qrcode\${license_key}_wgcf-qrcode.png
}


# $txtStr=@"
# [Interface]
# PrivateKey = +ORb0mHSwm3GgVf2yFLvQrG0R1VjpDPuvzPk+Lp2QFE=
# Address = 172.16.0.2/32
# Address = 2606:4700:110:8936:420e:cfd0:653b:6ca4/128
# DNS = 1.1.1.1
# MTU = 1280
# [Peer]
# PublicKey = bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=
# AllowedIPs = 0.0.0.0/0
# AllowedIPs = ::/0
# Endpoint = $Endpoint
# "@

# New-PSOneQRCodeText -Text $txtStr -Show


# Write-Output hello
pause
