@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set /p key=请输入warp+的license_key:
set /p ip=请输入warp+的优选Ip:

echo create Cloudflare Warp account
if exist wgcf-account.toml del wgcf-account.toml 2>nul
@REM .\wgcf_2.2.19_windows_amd64.exe register
.\wgcf_2.2.19_windows_amd64.exe register --accept-tos yes

if exist temp.txt del temp.txt 2>nul
ren wgcf-account.toml temp.txt

@REM set /p m=请输入要删除的行
set m=3
for /f "tokens=*" %%i in (temp.txt) do (
set /a n+=1
if !n! neq %m% echo %%i>>wgcf-account.toml
)
if exist temp.txt del temp.txt 2>nul

echo license_key = '%key%' >> wgcf-account.toml

type wgcf-account.toml

echo update Cloudflare Warp account
if exist wgcf-profile.conf del wgcf-profile.conf 2>nul
.\wgcf_2.2.19_windows_amd64.exe update

echo generate WireGuard profile: wgcf-profile.conf
.\wgcf_2.2.19_windows_amd64.exe generate


@REM set "filename=wgcf-profile.conf"

set row=
for /F "delims=" %%j in (wgcf-profile.conf) do (
if defined row echo.!row!>> wgcf-profile.conf.new
set row=%%j
)

if exist wgcf-profile.conf del wgcf-profile.conf 2>nul
ren wgcf-profile.conf.new wgcf-profile.conf

@REM Endpoint = engage.cloudflareclient.com:2408
echo Endpoint = %ip% >> wgcf-profile.conf
type wgcf-profile.conf



echo 请使用 wireguad 客户端扫描下面的二维码进行翻墙!!!
@REM http://bbs.bathome.net/thread-63928-1-1.html
@REM set /a n=0
@REM for /f "tokens=*" %%a in (url.txt) do (
@REM 	set /a n+=1
@REM 	qr %%a !n!.png

endlocal
pause 