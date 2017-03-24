#!/bin/bash

#快捷的在hadoop集群的所有机器上执行参数所跟的命令
#前提是已经配置了免秘密登录，
#可用于给集群的机器分发配置文件，查看服务状态等
source /etc/profile
parma=$@
#echo $# $parma

for os in os01 os03 os04 os05 os06 os02
do
	echo ===========$os:$parma================
	ssh $os "source /etc/profile ; $parma"
done
