# Encrypted-DNS
Simple Batch Script Make Simple & Easy Encrypted DNS queries using dnsproxy commandline application with DNS-over-https DOH.

## Features
- Google (Non-filtering).
- Quad9 (Malware Blocking).
- Quad9 (Non-filtering).
- AdGuard (Block ads).
- AdGuard (Non-filtering).
- AdGuard (Family protection).
- Cloudflare (Non-filtering).
- Cloudflare (Malware Blocking).
- Cloudflare (Family protection).

## Screenshots
![App Screenshot](https://raw.githubusercontent.com/xsukax/Encrypted-DNS/main/Screenshot.png)

## Acknowledgements
 - [dnsproxy Project](https://github.com/AdguardTeam/dnsproxy)
 - [Google DNS](https://developers.google.com/speed/public-dns/docs/doh)
 - [Quad9 DNS](https://www.quad9.net/service/service-addresses-and-features)
 - [AdGuard DNS](https://adguard-dns.io/en/public-dns.html)
 - [Cloudflare DNS](https://developers.cloudflare.com/1.1.1.1/setup/)

## Authors
- [@xsukax](https://github.com/xsukax)
- [@AdguardTeam](https://github.com/AdguardTeam)

## Demo
- [Youtube Channel](https://www.youtube.com/channel/UCnjgUjaBmoYhBFnkTgwKeCA)

## FAQ
#### How This Batch Script Works?
- It Downloads dnsproxy.exe file to the script directory.
- It show list of your Network Interfaces and let you choose which one you like to use (Ethernet or Wifi).
- It let you choose the dns service provider.
- Once you choose the provider it uses dnsproxy application via commandline.
- For example:
```javascript
start /min cmd.exe @cmd /k "dnsproxy.exe /u https://dns.google/dns-query /b 1.1.1.1:53 /v /o Google.log & call Encrypted-DNS-xsukax.bat"
```
- Then it set dns ip to localhost ip via command:
```javascript
netsh interface ip set dns name="%_interface%" static 127.0.0.1
```
- You can set DNS to default configuration via Default-DHCP-DNS.bat
#### How can i check if DNS Service works fine?
- Check [DNS Leak Test](https://www.dnsleaktest.com)

## Badges
[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)






