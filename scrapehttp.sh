#!/bin/bash
# prende un file index.html e isola solo gli URL per passarli poi a wget.... 
home=$(/usr/bin/pwd)
# wget -k $1 -O "index.html"
echo "$home"
echo $1 > "nome.txt"
nomefile=$(sed -n 's/\(.*\)\//\n/p' nome.txt)
rm nome.txt
echo $nomefile"scrape.txt"
mkdir $nomefile"scrape"
cd $nomefile"scrape"
if [ -f index.html ]
then
echo "Il file esiste e lo cancello" 
rm index.html
fi
wget  $1 -O "index.html"
sed -n 's/https/\n&/gp' index.html | sed -n 's/\"/\n/p' | grep "https" > $nomefile"scrape.txt"
wget -c -k -r -w 0.5 -i $nomefile"scrape.txt"
