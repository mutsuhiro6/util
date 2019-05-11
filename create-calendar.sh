#!/bin/bash

# 引数にstartdateとenddateをとります．
# e.g. ./create-calendar.sh 2019/04/01 2019/05/18
startdate=$1
enddate=$2

startsec=$(date -j -f "%Y/%m/%d" $startdate "+%s")
endsec=$(date -j -f "%Y/%m/%d" $enddate "+%s")
onedaysec=60*60*24
daysintervalsec=$((endsec-startsec))
daysinterval=$((daysintervalsec/onedaysec))

for i in $(seq 0 $daysinterval); do
  thedaysec=$((startsec+$((onedaysec*i))))
  dayofweek=$(date -j -f "%s" $thedaysec "+%w")
  if [ $((dayofweek%6)) -gt 1 ] ; then
    echo $(date -j -f "%s" $thedaysec "+%Y/%m/%d,%a,NG,,NG,,")
  fi
done

