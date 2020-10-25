#!/bin/bash 
# MultiFS 1.1 detector and extractor by Nanni Bassetti - Blog: http://www.nannibassetti.com/dblog WEB Site: http://www.nannibassetti.com
# It can detect and extract hidden file systems and partitions from the mass memory support.
# It runs in this way e.g.: sh multifs.sh  fat disk.dd or multifs.sh fat /dev/sda 
# It works only on ntfs,fat12,fat16,fat32, ext2,ext3.
# Important things: 
# FATx: sector size; bytes 11-12 
# ext2/3: Block size (saved as the number of places to shift 1,024 to the left); bytes 24-27 
# NTFS: sector size bytes; from 11 to 12
# ReiserFs: sector size bytes; 12-13

echo "MultiFS 1.1 detector and extractor by Nanni Bassetti - Blog: http://www.nannibassetti.com/dblog WEB Site: http://www.nannibassetti.com"
echo " "
echo "Remember to run in this way: sh multifs.sh  fat disk.dd or multifs.sh fat /dev/sda "
echo "Press a button to continue or CTRL + C to stop"
read button
file=$2 # file or dev
fs=$1 # file system
date
# looking for the signatures
sigfind -t $fs $file > sigs.txt
# FAT case
if [ "$fs" = "fat" ] 
then
# taking only the sectors
for i in  $(cat sigs.txt | awk -F "Block:"  '{print $2}'|awk '{print $1}')
do
offset=$(( $i*512 ))
j=$(( j+1 )) 
# controlling the word "FAT" inside the target partition
fat_flag=$(xxd -s $offset -l 512 $file| grep -i FAT)
    if [ "$fat_flag" ]
    then
# looking for the sector size
	start_bs=$(echo $offset + 11 | bc)
	xxd -s $start_bs -l 2 $file  | awk -F ":"  '{print $2}' | xxd -p -r >bs.bin
	   #converting in big endian
         dd if=bs.bin of=b1 skip=1 count=1 bs=1c
         dd if=bs.bin of=b2 skip=0 count=1 bs=1c
         cat b1 b2 > bs.dat
		 rm b1
		 rm b2
		 rm bs.bin
		     #calculating the sector size length
         lenbs=$(cat bs.dat|xxd -p | tr [:lower:] [:upper:])
         # converting in decimal
         bs=$(echo "obase=10; ibase=16; $lenbs" | bc)
		 
# check if byte 32-35 are 0 then the fat type is fat12
start_byte_fat_len=$(echo $offset + 32 | bc)
check_fat12=$(xxd -s $start_byte_fat_len -l 4 $file  | awk -F ":"  '{print $2}' | xxd -p -r)
        if [ ! "$check_fat12" ]
        then
        echo "File System chosen: FAT12"
        start_byte_fat_len=$(echo $offset + 19 | bc)
        # extracting bytes 19-20 from FAT 
        xxd -s $start_byte_fat_len -l 2 $file  | awk -F ":"  '{print $2}' | xxd -p -r >lung.bin
        #converting in big endian
         dd if=lung.bin of=l1 skip=1 count=1 bs=1c
         dd if=lung.bin of=l2 skip=0 count=1 bs=1c
         cat l1 l2 > l.dat
         rm l1
         rm l2
         rm lung.bin
         #calculating the partition length
         len=$(cat l.dat|xxd -p | tr [:lower:] [:upper:])
         # converting in decimal
         len2=$(echo "obase=10; ibase=16; $len" | bc)
         dd if=$file of=hidden$j.dd skip=$i count=$len2 bs=$bs
          rm l.dat
          ls -l *.dd
        else
echo "File System chosen: $fs"
echo "Sector size: "$bs
start_byte_fat_len=$(echo $offset + 32 | bc)
# extracting bytes 32-35 from FAT 
xxd -s $start_byte_fat_len -l 4 $file  | awk -F ":"  '{print $2}' | xxd -p -r >lung.bin
#converting in big endian
 dd if=lung.bin of=l1 skip=3 count=1 bs=1c
 dd if=lung.bin of=l2 skip=2 count=1 bs=1c
 dd if=lung.bin of=l3 skip=1 count=1 bs=1c
 dd if=lung.bin of=l4 skip=0 count=1 bs=1c
 cat l1 l2 l3 l4 > l.dat
 rm l1
 rm l2
 rm l3
 rm l4
 rm lung.bin
 #calculating the partition length
 len=$(cat l.dat|xxd -p | tr [:lower:] [:upper:])
 # converting in decimal
 len2=$(echo "obase=10; ibase=16; $len" | bc)
 dd if=$file of=hidden$j.dd skip=$i count=$len2 bs=$bs
 rm l.dat
 ls -l *.dd
        fi # end check FAT12
    fi # end check if there is the FAT word
 done
 echo "File System chosen: $fs"
echo "Sector size: "$bs
fi # end check if fs is FAT type

 # NTFS CASE
if [ "$fs" = "ntfs" ]
then

# taking only the sectors
for i in  $(cat sigs.txt | awk -F "Block:"  '{print $2}'|awk '{print $1}')
do
offset=$(( $i*512 ))
j=$(( j+1 )) 

# controlling the word "NTFS" inside the target partition
fat_flag=$(xxd -s $offset -l 512 $file| grep -i ntfs)
if [ "$fat_flag" ]
then
# looking for the sector size
	start_bs=$(echo $offset + 11 | bc)
	xxd -s $start_bs -l 2 $file  | awk -F ":"  '{print $2}' | xxd -p -r >bs.bin
	   #converting in big endian
         dd if=bs.bin of=b1 skip=1 count=1 bs=1c
         dd if=bs.bin of=b2 skip=0 count=1 bs=1c
         cat b1 b2 > bs.dat
		 rm b1
		 rm b2
		 rm bs.bin
		     #calculating the sector size length
         lenbs=$(cat bs.dat|xxd -p | tr [:lower:] [:upper:])
         # converting in decimal
         bs=$(echo "obase=10; ibase=16; $lenbs" | bc)
echo "File System chosen: $fs"
echo "Sector size: "$bs		 
# extracting bytes 40-47 from the NTFS boot sector
start_byte_fat_len=$(echo $offset + 40 | bc)
xxd -s $start_byte_fat_len -l 8 $file  | awk -F ":"  '{print $2}' | xxd -p -r >lung.bin
#converting in big endian
 dd if=lung.bin of=l1 skip=7 count=1 bs=1c
 dd if=lung.bin of=l2 skip=6 count=1 bs=1c
 dd if=lung.bin of=l3 skip=5 count=1 bs=1c
 dd if=lung.bin of=l4 skip=4 count=1 bs=1c
 dd if=lung.bin of=l5 skip=3 count=1 bs=1c
 dd if=lung.bin of=l6 skip=2 count=1 bs=1c
 dd if=lung.bin of=l7 skip=1 count=1 bs=1c
 dd if=lung.bin of=l8 skip=0 count=1 bs=1c
 cat l1 l2 l3 l4 l5 l6 l7 l8> l.dat
 rm l1
 rm l2
 rm l3
 rm l4
 rm l5
 rm l6
 rm l7
 rm l8
 rm lung.bin
 #calculating the partition length
 len=$(cat l.dat|xxd -p | tr [:lower:] [:upper:])
 # converting in decimal
 len2=$(echo "obase=10; ibase=16; $len" | bc)
 dd if=$file of=hidden$j.dd skip=$i count=$len2 bs=$bs
 rm l.dat
 fi
 done
 ls -l *.dd
 echo "File System chosen: $fs"
echo "Sector size: "$bs		
fi

# ext2/3 case (please test it!)
if [ "$fs" = "ext2" ] || [ "$fs" = "ext3" ]
then
# taking only the sectors
for i in  $(cat sigs.txt | awk -F "Block:"  '{print $2}'|awk '{print $1}')
do
offset=$(( $i*512 ))
j=$(( j+1 )) 

# looking for the blocks size
	start_bs=$(echo $offset + 24 | bc)
	xxd -s $start_bs -l 4 $file  | awk -F ":"  '{print $2}' | xxd -p -r >bs.bin
	   #converting in big endian
         dd if=bs.bin of=b1 skip=3 count=1 bs=1c
         dd if=bs.bin of=b2 skip=2 count=1 bs=1c
		 dd if=bs.bin of=b3 skip=1 count=1 bs=1c
		 dd if=bs.bin of=b4 skip=0 count=1 bs=1c
         cat b1 b2 b3 b4 > bs.dat
		 rm b1
		 rm b2
		 rm b3
		 rm b4
		 rm bs.bin
		     #calculating the sector size length
         lenbs=$(cat bs.dat|xxd -p | tr [:lower:] [:upper:])
         # converting in decimal
         lenbs2=$(echo "obase=10; ibase=16; $lenbs" | bc)
		 #Block size (saved as the number of places to shift 1,024 to the left)
		 # "<<" is the left shift bitwise operator 
		bs=$[ "1024 << $lenbs2" ]
echo "File System chosen: $fs"
echo "Sector size: "$bs	
echo $start_byte_fat_len

# extracting bytes 4-7 from the EXT Superblock
start_byte_fat_len=$(echo $offset + 4 | bc)
xxd -s $start_byte_fat_len -l 4 $file  | awk -F ":"  '{print $2}' | xxd -p -r >lung.bin

 # converting in big endian

 dd if=lung.bin of=l1 skip=3 count=1 bs=1c 
 dd if=lung.bin of=l2 skip=2 count=1 bs=1c 
 dd if=lung.bin of=l3 skip=1 count=1 bs=1c 
 dd if=lung.bin of=l4 skip=0 count=1 bs=1c 

 cat l1 l2 l3 l4 > l.dat
 rm l1
 rm l2
 rm l3
 rm l4
 rm lung.bin
 #calculating the partition length
 len=$(cat l.dat|xxd -p | tr [:lower:] [:upper:])
 # converting in decimal
 len2=$(echo "obase=10; ibase=16; $len" | bc)
 # $(($i-2)) because it starts 2 sectors before the signature
 dd if=$file of=hidden$j.dd skip=$(($i-2)) count=$len2 bs=$bs
 rm l.dat
 rm bs.dat
done
 ls -l *.dd
echo "File System chosen: $fs"
echo "Sector size: "$bs	
fi
date 
exit