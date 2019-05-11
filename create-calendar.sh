#!/bin/bash

startdate="2019/06/13"
enddate="2019/08/20"

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

