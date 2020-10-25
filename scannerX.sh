#! /bin/bash
# This script is designed to find hosts with MySQL installed
echo "Nome scansione: "
read Name
echo "Primo indirizzo IP: "
read PrimoIP
echo "Ultimo indirizzo IP: "
read SecondoIP
echo "Porta da scannare: "
read Porta
nmap -sT $PrimoIP-$SecondoIP -p $Porta >/dev/null -oG MySQLscan
cat MySQLscan | grep open > MySQLscan$Name
cat MySQLscan$Name
