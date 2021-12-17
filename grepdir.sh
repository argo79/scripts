#!/bin/bash

percorso=$(pwd)
for file in $percorso/*.*
do
	echo "${file}" >> elencoProve.txt
	cat "${file}" | grep "mygateway1-out/24/" >> elencoProve.txt
        percorso=$percorso"/*/"
	echo $percorso

done
cat elencoProve.txt | grep -1 "mygateway1-out/24/" >> elencoProve2.txt
wait

