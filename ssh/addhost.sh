#!/bin/bash
# My Telegram : https://t.me/fromhell26
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/fromhell26/perizinan/main/ipvps.txt | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${LIGHT}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
echo -e "${NC}${LIGHT}Telegram : https://t.me/fromhell26"
exit 0
fi
clear
read -rp "Domain/Host : " -e domain
echo "IP=$domain" >>/var/lib/fromhell26store/ipvps.conf
echo $domain > /etc/xray/domain
echo start
systemctl stop xray@v2ray-tls
systemctl stop xray@v2ray-nontls
systemctl stop xray@vless-tls
systemctl stop xray@vless-nontls
systemctl stop xray@trojan
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray-mini.crt --keypath /etc/xray/xray.key --ecc
systemctl start xray@v2ray-tls
systemctl start xray@v2ray-nontls
systemctl start xray@vless-tls
systemctl start xray@vless-nontls
systemctl start xray@trojan
echo Done
sleep 1.5
clear
neofetch