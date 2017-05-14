#!/bin/bash

#快捷的在hadoop集群的所有机器上执行参数所跟的命令
#前提是已经配置了免秘密登录，
#可用于给集群的机器分发配置文件，查看服务状态等
source /etc/profile
parma=${!#}
#echo $# $parma
if [ $# == 0 ]
then
	echo "Error ,parameters must be given!!!"
	echo "eg: xcallkfk [host1 host2.....] start|stop"
elif [ $# -gt 1 ]
then
	for((i=1;i<$#;i++))
	do
		eval j=\$$i
		echo ---------------------------$os:$parma-----------------------------
		if [ $parma == "start" ]
			then
			ssh $j "source /etc/profile ;kafka-server-${parma}.sh -daemon /soft/kafka/config/server.properties "
		elif [ $parma == "stop" ]
		then
			ssh $j "source /etc/profile ;kafka-server-${parma}.sh"
		else
			echo "error :only start,stop can use"
		fi
	done
else
	for os in os01 os02 os05 os06
	do
		echo ---------------------------$os:$parma-----------------------------
		if [ $parma == "start" ]
		then
			ssh $os "source /etc/profile ;kafka-server-${parma}.sh -daemon /soft/kafka/config/server.properties "
		elif [  $parma == "stop" ]
		then
			ssh $os "source /etc/profile ;kafka-server-${parma}.sh "
		else
			 ssh $os "source /etc/profile ;$parma"
		fi
	done
fi
