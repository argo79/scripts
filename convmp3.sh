#!/bin/bash
echo "scrivi la cartella dove si trovano i file mp3"
read percorso
echo "nome base del file"
read nome
ffmpeg -i *.ape output.wav
bchunk -w *.wav *.cue $nome
rm output.wav
for audio in $percorso
do
lame $audio
done
rm *.wav
