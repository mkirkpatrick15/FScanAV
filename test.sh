#!/bin/bash

#Maxwell Kirkpatrick
#Antivirus Evasion Tester

GREEN='\e[0;32m' # '\e[1;32m' is too bright.
RED='\033[0;31m'
endColor='\e[1;37m'

#Echo the path provided by the user
echo -e "${GREEN}Scanning file: \e[5;32; ${endColor}" "$1"

printf "\n"

#ClamAV_____________________________________________________________________

if clamdscan $1 | grep -q  "Infected files: 1"; then
	printf "${RED}\tClamAV flagged malware${endColor}"
else
	printf "${GREEN}\tClamAV evaded!${endColor}"
fi
printf "\n"

#FProt______________________________________________________________________

if fpscan $1 | grep -q "Infected objects: 1"; then
	printf "${RED}\tF-Prot flagged malware${endColor}"
else 
	printf "${GREEN}\tF-Prot evaded!${endColor}"
fi
printf "\n"

#SOPHOS__________________________________________________________

if savscan $1 | grep -q "1 virus"; then
	printf "${RED}\tSOPHOS flagged malware${endColor}"
else
	printf "${GREEN}\tSOPHOS evaded!${endCOlor}"
fi
printf "\n"

#________________________________________________________



# (1) prompt user, and read command line argument
read -p "Would you like to attempt evasion techniques?(y or n)" answer
# (2) Read arguments that were given
while true
do
   case $answer in
      [yY]* )
         sh ./evade.sh "$1"
      break;;

      [nN]* ) exit;;
      * )	echo "enter y or n"; break ;;
   esac
done

