#!/bin/bash

cd $1
git branch --merged | egrep -v '\*|develop|master' | xargs git branch -d
