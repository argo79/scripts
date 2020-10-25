#!/bin/bash
free |grep Mem
sync
echo "ora cancello...
lo faccio? (y/n)
"
read risp
if [[ $risp == "y" ]]
then
echo "cancello..."
echo 3 > /proc/sys/vm/drop_caches
free |grep Mem
else
echo "non cancello!"
exit
fi

