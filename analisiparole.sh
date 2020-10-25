#!/bin/bash
#  wf.sh: Un'analisi sommaria, su un file di testo, della 
#+ frequenza delle parole.
#  È una versione più efficiente dello script "wf2.sh".


# Verifica la presenza di un file di input passato da riga di comando.
ARG=1
E_ERR_ARG=65
E_NOFILE=66

if [ $# -ne "$ARG" ]  #  Il numero di argomenti passati allo script è corretto?
then
  echo "Utilizzo: `basename $0` nomefile"
  exit $E_ERR_ARG
fi

if [ ! -f "$1" ]      # Verifica se il file esiste.
then
  echo "Il file \"$1\" non esiste."
  exit $E_NOFILE
fi



###############################################################################
# main ()
sed -e 's/\.//g'  -e 's/\,//g' -e 's/ /\
/g' "$1" | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr
#                           =========================
#                           Frequenza delle occorrenze

#  Filtra i punti e le virgole, e cambia gli spazi tra le parole in
#+ linefeed, quindi trasforma tutti i caratteri in caratteri minuscoli ed
#+ infine premette il conteggio delle occorrenze e le ordina in base al numero.

#  Arun Giridhar suggerisce di modificare il precedente in:
#  . . . | sort | uniq -c | sort +1 [-f] | sort +0 -nr
#  In questo modo viene aggiunta una chiave di ordinamento secondaria, per cui
#+ nel caso di occorrenze uguali queste vengono ordinate alfabeticamente.
#  Ecco la spiegazione:
#  "In effeti si tratta di un ordinamento di radice, prima sulla
#+ colonna meno significativa
#+ (parola o stringa, opzionalmente senza distinzione minuscolo-maiuscolo)
#+ infine sulla colonna più significativa (frequenza)."
#
#  Frank Wang spiega che il precedente equivale a
#+       . . . | sort | uniq -c | sort +0 -nr
#+ così pure il seguente:
#+       . . . | sort | uniq -c | sort -k1nr -k
###############################################################################

exit 0

# Esercizi:
# ---------
# 1)  Aggiungete dei comandi a 'sed' per filtrare altri segni di
#   + punteggiatura, come i punti e virgola.
# 2)  Modificatelo per filtrare anche gli spazi multipli e gli altri
#   + caratteri di spaziatura.
