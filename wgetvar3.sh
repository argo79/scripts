#!/bin/bash

URL1="https://archive.org/download/HackSpace0"
URL3="/HackSpace-0"
URL5=".pdf"


for (( c=1; c<=5; c++ ))
do
   echo "Welcome $c times"
   URLT="$URL1$c$URL3$c$URL5"
   wget -c $URLT

done

