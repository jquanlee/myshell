#!/bin/bash

#@version 1.0
#此脚本用于在运行hdfs的机器上上传指定目录log_src_dir下的文件到hdfs上
#log_up_dir为中转目录
#在中转目录在文件名上加上时间信息，以免文件重名且能记录文件上传的时间


log_src_dir="/home/centos/logs/log"

log_up_dir="/home/centos/logs/upload"

date0=`date +%Y-%m-%d-%H-%M-%S`
ls $log_src_dir | while read line
do
	date=`date +%Y-%m-%d-%H-%M-%S`
	newname=$log_up_dir/click_log_${line}_"logfile"-$date
	mv  $log_src_dir/$line $newname
	#echo $log_src_dir/$line  $log_up_dir/$line-$date
	echo  $newname  >> $log_up_dir/"logdirfile-willdoing"-$date0
	#echo $log_up_dir/$line-$date >> $log_up_dir/"willdoing"
done


ls $log_up_dir | grep -v "logfile" |grep -v "_COPY_" | grep -v "_DONE_" | while read line
do
	mv $log_up_dir/$line $log_up_dir/$line"_COPY_"
	#echo $log_up_dir/$line $log_up_dir/$line"_COPY_"
	
	cat $log_up_dir/$line"_COPY_" | while read line
	do
		hdfs dfs -put $line  /log
		#echo  $line
	done
	mv  $log_up_dir/$line"_COPY_"  $log_up_dir/$line"_DONE_" 
done
