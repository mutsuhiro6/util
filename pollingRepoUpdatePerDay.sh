#!/opt/local/bin/bash
cd $1
SECONDS=0
while : 
	do
		if [ $SECONDS -ge 86400000 ] ; then
			git pull
			SECONDS=0
		fi
done
