#! /usr/bin/env bash

echo "|main class|config|"
echo "|:---------|------|"

EXPARCHIVEDIR=$1
EXECINFO=$EXPARCHIVEDIR/00execinfo.txt

MAINCLASS=`ssh fs cat $EXECINFO | grep "main class: " | sed 's/main class: //'`
CONFIGFILE=`ssh fs cat $EXECINFO | grep ".conf$"`

REPOURLROOT=`ssh fs cat $EXECINFO | grep "remote repository is" | sed 's/remote repository is git@//' | sed 's/bitbucket\.org:icslab/https:\/\/bitbucket\.org\/icslab/g' | sed 's/\.git/\//'`

MAINCLASSURL=`echo $MAINCLASS | sed 's/\./\//g'`

echo "|[$MAINCLASS]($REPOURLROOT"src/master/src/main/scala/"$MAINCLASSURL".scala")|[$CONFIGFILE]($REPOURLROOT"src/master/"$CONFIGFILE)|"

