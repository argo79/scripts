#!/bin/bash
# Questo script verificherà se siamo o meno in un anno bisestile.
arg=$1
echo "
Senza alcun argomento calcola se l'anno corrente è bisestile, 
altrimenti si può specificare l'anno :-)
$0 -h richiama l'help
"
echo "Come ti chiami?"
read nome
echo "Ciao" $nome
echo "Inserisci l'anno:"
read anno
if [[ $arg == "-h" ]]
then
echo "Come usare:

$0 -> anno corrente.
$0 YYYY -> anno richiesto.
$0 -h -> questo comando"
exit
fi 
if [[ $1 -eq 0 ]]
then
echo "
Nessun anno inserito.
Calcolo anno corrente:
"
else
echo "L'anno inserito è "$1"
"
fi
if [[ -n $1 ]]
then
echo $arg
anno=$arg
else
anno=`date +%Y`
fi
echo "Siamo nel" $anno
if [ $[$anno % 400] -eq "0" ]; then
echo "Questo è un anno bisestile. Febbraio ha 29 giorni."
elif [ $[$anno % 4] -eq 0 ]; then
if [ $[$anno % 100] -ne 0 ]; then
echo "Questo è un anno bisestile. Febbraio ha 29 giorni."
else
echo "Questo non è un anno bisestile. Febbraio ha 28 giorni."
fi
else
echo "Questo non è un anno bisestile. Febbraio ha 28 giorni."
fi
echo ""
