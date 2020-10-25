#!/bin/bash

if [ $# -eq 0 ]
then
echo "non ci sono argomenti"
else
echo "ci sono argomenti"
fi
echo "ecco l'ora e la data:"
date +%H:%M-%d-%m-%y
echo "e questi sono gli utenti connessi:"
who
echo "questo il tempo di esecuzione del sistema!"
uptime
echo "il numero di argomenti è: " $#
exit
