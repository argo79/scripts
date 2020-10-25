#!/bin/bash
# converte i MOV in avi 

for f in *.MOV
do

    name=`echo "$f" | sed -e "s/.mp4$//g"`


mencoder "$f" -ovc lavc -lavcopts 'vcodec=mpeg4:vbitrate=1000:vhq:vqmin=2:autoaspect' -ffourcc DX50 -oac mp3lame -lameopts 'vbr=0:br=128' -o "name.2.avi"

done

