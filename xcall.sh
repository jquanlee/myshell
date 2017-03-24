#!/bin/bash

#快捷的在hadoop集群的所有机器上执行参数所跟的命令
#前提是已经配置了免秘密登录，
#可用于给集群的机器分发配置文件，查看服务状态等
source /etc/profile
parma=${!#}
#echo $# $parma
#echo $#
if [ $# -gt 1 ]
then
	for((i=1;i<=($#-1);i++))
	do
		eval j=\$$i
		echo ========================$j:$parma============================
		ssh $j "source /etc/profile ; $parma"	
	done
else 
	for((i=1;i<=6;i++))
	do

		echo =======================os0$i:$parma==================================
		ssh os0$i  "source /etc/profile ; $parma"
	done
fi
