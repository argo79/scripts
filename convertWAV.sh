#!/bin/bash
for f in *.ogg
do
    name=`echo "$f" | sed -e "s/.ogg$//g"`
    sox "$f" "$name.wav"
done
