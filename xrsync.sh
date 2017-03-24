#!/bin/bash
source /etc/profile

file=${!#}
dname=`dirname $file`
bname=`basename $file`
cd $dname
lpwd=`pwd -P`
user=`whoami`

if [ $# == 1 ]
then
	echo $file----$dname----$bname----$lpwd

	echo rsync -lr $bname $user@os01:${lpwd}/
	rsync -lr $bname $user@os01:$lpwd/
	for((i=3;i<=6;i++))
	do
		echo rsync -lr $bname $user@os0$i:${lpwd}/
		rsync -lr $bname $user@os0$i:$lpwd/
	done

else
	echo $file----$dname----$bname----$lpwd
	for((i=1;i<=($#-1);i++))
	do
		eval j=\$$i
		echo rsync -lr $bname $user@$j:${lpwd}/
		rsync -lr $bname $user@$j:$lpwd/
	done

fi
