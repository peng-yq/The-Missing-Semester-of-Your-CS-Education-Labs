#!/bin/bash

count=0

while true
do
	./test.sh &> out.txt
	count=$((count+1))
	if [[ $? -ne 0 ]];then
		echo "Failed after $count times"
		cat out.txt
		break
	fi
done
