#!/bin/bash

for((i=0;i<5;i++))
do
	touch $i.html
	echo "Hello World" > $i.html
done
