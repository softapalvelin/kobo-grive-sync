#!/bin/sh

i=0
pingValue=1
while [ $pingValue != 0 ] && [ $i -le 10 ]
do
	ping -c 1 -w 3 $1
	pingValue=$?
#        echo "loop $i"
	if [ $pingValue != 0 ]; then
#	      echo "sleep"
	      sleep 3
	fi
        i=`expr $i + 1`
done

if [ $pingValue != 0 ]; then
      exit 1;
fi
