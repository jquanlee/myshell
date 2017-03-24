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
	echo "eg: xcallzk [host1 host2.....] start|stop|stauts"
elif [ $# -gt 1 ]
then
	for((i=1;i<$#;i++))
	do
		eval j=\$$i
		echo ========================$j:$parma================================
		ssh $j "source /etc/profile ; zkServer.sh $parma"
	done
else
	for os in os02 os03 os04
	do
		echo ===========$os:$parma================
		ssh $os "source /etc/profile ; zkServer.sh $parma"
	done
fi
