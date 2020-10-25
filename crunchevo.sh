#!/bin/sh
#In quest’articolo vorrei spiegare come concatenare alla destra di una wordlist dei numeri generati dal programma Crunch
#Lo script legge ogni riga del file wordlist.txt, per ciascuna riga letta genera in successione su un nuovo file newwordlist.txt, tante righe quante sono le combinazioni risultati dalle istruzioni date.
#La prima linea di comandi passati a crunch esegue le combinazioni aggiungendo un solo carattere dal charset specificato tramite il parametro -f. Il secondo comando similmente ne aggiunge 2 alla volta. Il parametro -u evita di mandare in output informazioni statistiche sulla generazione dei dati che crunch sta per effettuare. Il parametro -t permette di specificare un pattern da seguire nelle regole di generazione della wordlist.

echo > newwordlist.txt

while read WORD
do
LEN=${#WORD}
LEN1=$((LEN+1))
LEN2=$((LEN+2))
crunch $LEN1 $LEN1 -f /usr/share/crunch/charset.lst numeric -u -t $WORD% >> newwordlist.txt
crunch $LEN2 $LEN2 -f /usr/share/crunch/charset.lst numeric -u -t $WORD%% >> newwordlist.txt
done < $1
