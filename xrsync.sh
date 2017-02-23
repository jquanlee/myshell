#!/bin/bash

file=$@

dname=`dirname $file`
bname=`basename $file`
#lpwd=`cd $dname;pwd -P`
cd $dname
lpwd=`pwd -P`
user=`whoami`

echo $file----$dname----$bname----$lpwd

for((i=3;i<=5;i++))
do
echo rsync -lr $bname $user@os0$i:${lpwd}/$bname
rsync -lr $bname $user@os0$i:$lpwd/$bname
done
