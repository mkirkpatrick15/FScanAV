#!/bin/bash

clear

printf "\t \t======= EVASION SUITE =======\n"
printf "\n \n \t \tUSING FILE: $1"
printf "\n \t \t Please Select from the options below to attempt evasion\n"
printf "\t \t (1) Scantime Crypter\n\n"
printf "\t \t (2) Splitter and Hex Editor\n\n"
printf "\t \t (3) PeCloak\n\n"

read -p "SELECTION: " selection
case $selection in
   1)
      printf "\n\t\tBeginning Scantime Crypter... \n\n"
      ;;
   2)
      printf "\n\t\tBeginning Splitter and Hex Editor... \n\n"
      bash /root/malware/splitter.sh $1
      ;;
   3)
      printf "\n\t\tBeginning PeCloak... \n\n"
      ;;
   *)
      printf "\n\t\tInvalid option chosen"
      ;;
esac

