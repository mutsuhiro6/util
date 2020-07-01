#!/bin/sh

HEADER='/Volumes/fs/exp-archives/'
# change separator character

IFS='-'

#配列格納
ARGS=($1)

DATE=${ARGS[0]}
TIME=${ARGS[1]}
USERNAME=${ARGS[${#ARGS[@]}-4]}

YEAR=${DATE:0:4}
MONTH=${DATE:4:2}

# restore separator character
IFS=$' \t\n'

echo $YEAR
echo $MONTH
echo $USERNAME
echo $HEADER$YEAR'/'$USERNAME'/'$YEAR$MONTH'/'$1

open $HEADER$YEAR'/'$USERNAME'/'$YEAR$MONTH'/'$1
