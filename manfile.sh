#!/bin/bash


for file in *.*      			# per ogni file nella cartella corrente
do
	echo "${file##*/}"      	# mostra solo il nome file senza estensione
	echo "${file##*.}"      	# mostra l'ultima estensione

done
wait

FILE="/home/vivek/lighttpd.tar.gz"
echo "${FILE#*.}"     # print tar.gz
echo "${FILE##*.}"    # print gz
ext="${FILE#*.}"      # store output in a shell variable 
echo "$FILE has $ext" # display it