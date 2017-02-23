#!/bin/bash

source /etc/profile
parma=$@
#echo $# $parma

for os in  os03 os04 os05 os02
do
	echo ===========$os:$parma================
	ssh $os $parma	
done
