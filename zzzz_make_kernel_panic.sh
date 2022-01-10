#! /bin/sh

sudo sh -c 'echo 1 > /proc/sys/kernel/sysrq'
sudo sh -c 'echo c > /proc/sysrq-trigger'
