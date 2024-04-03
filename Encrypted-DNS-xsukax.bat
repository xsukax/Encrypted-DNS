@TITLE Encrypted DNS by xsukax
@echo off
color 0A

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	goto CHECKDNSPROXY
:--------------------------------------    
:CHECKDNSPROXY

echo Checking If dnsproxy.exe Exists ...
IF EXIST "%~dp0\dnsproxy.exe" ( goto MENU ) ELSE ( goto DOWNDNSPROXY )

:DOWNDNSPROXY
::DNSProxy Project Link https://github.com/AdguardTeam/dnsproxy
echo Downloading dnsproxy.exe ...
curl https://raw.githubusercontent.com/xsukax/Encrypted-DNS/main/dnsproxy.exe -o dnsproxy.exe
GOTO CHECKDNSPROXY

:MENU
CLS
echo ---Note: Please Check the batch file before using it---
echo ---Note: Thanks for AdguardTeam for dnsproxy app---
echo ---Note: This is My Personal script, I Published it for public benefit---
echo ---Note: Modify and Fork the script as you see fit---
echo -----------------------
echo Encrypted DNS by xsukax
echo -----------------------
netsh interface show interface
SET /P "_interface=Enter Interface Name from the list below: "
echo 1 - Google (Non-filtering).
echo 2 - Quad9 (Malware Blocking).
echo 3 - Quad9 (Non-filtering).
echo 4 - AdGuard (Block ads).
echo 5 - AdGuard (Non-filtering).
echo 6 - AdGuard (Family protection).
echo 7 - Cloudflare (Non-filtering).
echo 8 - Cloudflare (Malware Blocking).
echo 9 - Cloudflare (Family protection).
echo.
SET /P choice=Enter your Choice:
IF %choice%==1 GOTO GDNSPROXY
IF %choice%==2 GOTO QMBDNSPROXY
IF %choice%==3 GOTO QNMBDNSPROXY
IF %choice%==4 GOTO AGDNSPROXY
IF %choice%==5 GOTO AGNDNSPROXY
IF %choice%==6 GOTO AGFDNSPROXY
IF %choice%==7 GOTO CFDNSPROXY
IF %choice%==8 GOTO CFMBDNSPROXY
IF %choice%==9 GOTO CFFDNSPROXY
IF NOT "%choice%"=="1,2,3,4,5,6,7,8,9" goto BADCHOICE


rem ------------ Google (Non-filtering) ------------
rem ------------ No Malware Blocking ------------
:GDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://dns.google/dns-query /b 1.1.1.1:53 /v /o Google.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ Quad9 (Malware Blocking) ------------
rem ------------ Malware Blocking, DNSSEC Validation ------------
:QMBDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://dns.quad9.net/dns-query /b 8.8.8.8:53 /v /o QMB.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ Quad9 (Non-filtering) ------------
rem ------------ No Malware Blocking, No DNSSEC Validation ------------
:QNMBDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://dns10.quad9.net/dns-query /b 8.8.8.8:53 /v /o QNMB.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ AdGuard (Block ads) ------------
rem ------------ AdGuard DNS will block ads and trackers ------------
:AGDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://dns.adguard-dns.com/dns-query /b 8.8.8.8:53 /v /o AG.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ AdGuard (Non-filtering) ------------
rem ------------ AdGuard DNS will not block ads, trackers, or any other DNS requests ------------
:AGNDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://unfiltered.adguard-dns.com/dns-query /b 8.8.8.8:53 /v /o AGN.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ AdGuard (Family protection) ------------
rem ------------ AdGuard DNS will block ads, trackers, adult content, and enable Safe Search and Safe Mode, where possible ------------
:AGFDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://family.adguard-dns.com/dns-query /b 8.8.8.8:53 /v /o AGF.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ Cloudflare (Non-filtering) ------------
rem ------------ No Malware Blocking ------------
:CFDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://cloudflare-dns.com/dns-query /b 8.8.8.8:53 /v /o CF.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ Cloudflare (Malware Blocking) ------------
rem ------------ Block malware ------------
:CFMBDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://security.cloudflare-dns.com/dns-query /b 8.8.8.8:53 /v /o CFMB.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ Cloudflare (Family protection) ------------
rem ------------ Block malware and adult content ------------
:CFFDNSPROXY
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://family.cloudflare-dns.com/dns-query /b 8.8.8.8:53 /v /o CFF.log & call Encrypted-DNS-xsukax.bat"
netsh interface ip set dns name="%_interface%" static 127.0.0.1
exit

rem ------------ Bad Choice ------------
:BADCHOICE
echo -----------
echo Bad Choice.
echo -----------
ping localhost -n 5 >nul
goto MENU
