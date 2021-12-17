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
wget -k $1 -O "index.html"
sed -n 's/http/\n&/gp' index.html | sed -n 's/\"/\n/p' | grep "http" > $nomefile"scrape.txt"
wget -c -k -r -i $nomefile"scrape.txt"
