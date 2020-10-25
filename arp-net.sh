#!/bin/bash
echo -e "\e[1m\e[93mBenvenuto\e[0m su \e[41m\e[1m\e[93marp-net 1.1\e[0m"

FILENAME=$2
echo $FILENAME.txt
file=$FILENAME


while test -f $file.txt
  do
  echo -e "Il file \e[33m" $file.txt "\e[0m esiste già! Sovrascrivo?"
  echo -ne "(y)es-si-sì/\e[4m(n)o-NO\e[0m: "
  read -r VAR1

  if test -z $VAR1  || [ $VAR1 = "no" ] || [ $VAR1 = "NO" ] || [ $VAR1 = "n" ]
  then
    read -p "Nuovo nome: " VAR2
    while [[ -z "$VAR2" ]]
      do
      echo "Dare un nome file!"
      echo -ne "\e[93m\e[5mNuovo nome: \e[0m"$1.0.txt" \e[4m(p)redefinito\e[0m? "
      read -r VAR2
      if [[ $VAR2 == "p" ]]
      then
        VAR2=$1.0
      fi
    done
    file=$VAR2
#    echo -e "\e[42m\e[30m\e[1m"$file.txt"\e[0m" 

  elif [ $VAR1 = "si" ] || [ $VAR1 = "sì" ] || [ $VAR1 = "yes" ] || [ $VAR1 = "y" ]
  then
    echo -e "\e[93mOk, sovrascrivo!\e[0m"
    rm -R $file.txt
  fi 

done

echo -e "Nome file salvato \e[42m\e[30m\e[1m"$file.txt"\e[0m." 

for value in {1..254}
  do 
#  echo $value
#  echo $1.$value
    arp -a $1.$value >> $file.temp
  done

grep -w associato $file.temp > $file.txt
rm -R $file.temp
echo -e "Risultati su file" $file.txt
cat $file.txt
