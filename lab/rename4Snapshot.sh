#! /bin/bash

CURDIR=`pwd`
echo $CURDIR
if [ ! -e ${CURDIR}/snapshot ]; then
    mkdir ${CURDIR}/snapshot
fi

FILEDIRNAME=`dirname $1`
echo $FILEDIRNAME

FILENAME="${1##*/}"
echo $FILENAME

FILENAME_NOEXT="${FILENAME%.*}"
echo $FILENAME_NOEXT

TODAY=`date "+%Y%m%d"`
echo $TODAY

cd $FILEDIRNAME
COMMIT=`git rev-parse --short HEAD`
cd -

echo $COMMIT

cp $1 "${CURDIR}/snapshot/${FILENAME_NOEXT}_${TODAY}_${COMMIT}.pdf"
