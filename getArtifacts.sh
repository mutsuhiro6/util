#! /usr/local/bin/bash

urlbase="https://bit.ly/"

declare -A ID;

ID=(
  ["gps"]="2UHfM7j"
  ["desire"]="2G1tNmY"
  ["transit"]="2KnOC1y"
)

wget -q $urlbase${ID[$1]} -O ${ID[$1]}
tar czx ${ID[$1]}
rm ${ID[$1]}



