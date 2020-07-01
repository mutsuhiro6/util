#! /opt/local/bin/bash

declare -A FEE=(
  ["y2o"]=356
  ["o2y"]=356
  ["t2y"]=367
  ["y2t"]=367
  ["t2nad"]=398
  ["nad2t"]=398
  ["nad2o"]=356
  ["o2nad"]=356  
  ["nad2y"]=170
  ["y2nad"]=170
)
declare -A ROUTE=(
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

declare -A CAMPANY=(
  ["y"]="ヤフー株式会社"
  ["nad"]="日建設計株式会社"
)

if [ `echo $3 | grep 2t` ] || [ `echo $3 | grep t2` ]; then
  REMARK="定期券内(高津→二子玉川)"
else
  REMARK=""
fi

if [ $4 = "r" ]; then
  COEFF=2
  ROUND_TRIP="往復"
else
  COEFF=1
  ROUND_TRIP="片道"
fi

echo $1,${CAMPANY[$2]},,実世界情報処理に関する研究打合せ,${ROUTE[$3]},$ROUND_TRIP,IC,`expr $COEFF \* ${FEE[$3]}`,,$REMARK

