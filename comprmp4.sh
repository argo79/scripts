#!/bin/bash
# comprime gli mp4 

for f in *.mp4
do
    name=`echo "$f" | sed -e "s/.mp4$//g"`
    mencoder "$f" -oac mp3lame -ovc x264 -o "$name.2.mp4"
done

