#!/bin/bash

for file in /home/chirone/Arduino/prototipi/*/*/*.*

do
	echo "${file}" >> elencoProve.txt
	cat "${file}" | grep "mygateway1-out/24/" >> elencoProve.txt

done
cat elencoProve.txt | grep -1 "mygateway1-out/24/" >> elencoProve2.txt
wait

