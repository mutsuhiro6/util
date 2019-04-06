#!/opt/local/bin/bash

declare -A FEE;

FEE=(
  ["y2o"]=349
  ["o2y"]=349
  ["t2y"]=360
  ["y2t"]=360
  ["t2nad"]=390
  ["nad2t"]=390
  ["nad2o"]=349
  ["o2nad"]=349  
  ["nad2y"]=165
  ["y2nad"]=165
)
declare -A ROUTE;

ROUTE=(
  ["y2o"]="永田町→大岡山"
  ["o2y"]="大岡山→永田町"
  ["t2y"]="高津→永田町"
  ["y2t"]="永田町→高津"
  ["t2nad"]="高津→竹橋"
  ["nad2t"]="竹橋→高津"
  ["nad2o"]="竹橋→大岡山"
  ["o2nad"]="大岡山→竹橋"
  ["nad2y"]="竹橋→永田町"
  ["y2nad"]="永田町→竹橋"
)

declare -A CAMPANY;

CAMPANY=(
  ["y"]="ヤフー株式会社"
  ["nad"]="日建設計株式会社"
)

if [ `echo $3 | grep 2t` ] || [ `echo $3 | grep t2` ]; then
  REMARK="定期券内(高津→二子玉川)"
else
  REMARK=""
fi

if [ $4 = "r" ]; then
  ROUND_TRIP="往復"
else
  ROUND_TRIP="片道"
fi

echo $1,${CAMPANY[$2]},,実世界情報処理に関する研究打合せ,${ROUTE[$3]},$ROUND_TRIP,IC,${FEE[$3]},,$REMARK

