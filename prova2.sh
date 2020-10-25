#!/bin/bash

if [ $# -eq 0 ]
then
echo "ciao $USER!"
echo "
non ci sono argomenti"
else
echo "
ci sono argomenti"
fi
echo "
ecco l'ora e la data:"
date +%H:%M-%d-%m-%y
echo "Questo è `uname -s` che gira in un processore `uname -m`."
echo "
e questi sono gli utenti connessi:"
who
echo "
questo il tempo di esecuzione del sistema!"
uptime
echo "
il nome del programma è $0
il numero di argomenti è: $#"
if [[ -n $1 ]]
then
echo "
il primo argomento è $1,"
fi
if [[ -n $2 ]]
then
echo "
il secondo è $2,
ecc.." 
fi
echo "non c'è altro :-)
se non l'elenco degli argomenti: $@
"
echo "--------------------------------------"
if [[ $# -ge 1 ]]
then
i=1
echo "il primo argomento è $1,
"
else
echo "       * * *
non ci sono argomenti
       * * *"
fi

indice=1 # Reimposta il contatore.

# Cosa succede se vi dimenticate di farlo?

echo "Elenco degli argomenti con \"\$@\":"

for arg in "$@"

do

echo "Argomento nr.$indice = $arg"

let "indice+=1"

done
cat "/etc/hostname"
exit
