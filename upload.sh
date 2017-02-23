#!/bin/bash
source /etc/profile
log_src_dir="/home/centos/logs/log"

log_up_dir="/home/centos/logs/upload"

#把日志文件移动到待上传的目录upload
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
