#!/bin/bash

for os in os03 os04 os05
do
	ssh $os ln -s /soft/jdk/bin/jps /usr/local/bin/jps
	echo =========$os完成===========
done
