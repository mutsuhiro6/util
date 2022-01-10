#! /bin/sh

cd $(dirname $0)

. ./.config
IP_ADDRESS=`curl -s inet-ip.info`
curl -s -X POST -H 'Content-type: application/json' --data '{"text":"'"$IP_ADDRESS"'"}' $IPN_WEBHOOK_URL > /dev/null
