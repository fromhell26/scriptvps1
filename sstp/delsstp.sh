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
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/fromhell26/perizinan/main/ipvps.txt | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!"
echo -e "${NC}${LIGHT}Telegram : https://t.me/fromhell26"
exit 0
fi
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/fromhell26store/data-user-sstp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	echo ""
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^### " "/var/lib/fromhell26store/data-user-sstp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Pilih salah satu[1]: " CLIENT_NUMBER
		else
			read -rp "Pilih salah satu [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
Client=$(grep -E "^###" /var/lib/fromhell26store/data-user-sstp | cut -d ' ' -f 2-3 | sed -n "$CLIENT_NUMBER"p)
user=$(grep -E "^###" /var/lib/fromhell26store/data-user-sstp | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p)
exp=$(grep -E "^###" /var/lib/fromhell26store/data-user-sstp | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p)
sed -i "/^### $user $exp/d" /var/lib/fromhell26store/data-user-sstp
sed -i '/^'"$user"'/d' /home/sstp/sstp_account
clear
echo ""
echo "=========================="
echo "   SSTP Account Deleted   "
echo "=========================="
echo "Username  : $user"
echo "Expired   : $exp"
echo "=========================="
echo "Script By fromhell26"