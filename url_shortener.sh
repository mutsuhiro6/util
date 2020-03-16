#! /bin/bash
curl -H "Host: api-ssl.bitly.com
Authorization: Bearer 14ec0be35d1fdace8753bca119eb1fabc61be07c
Content-Type: application/json" --http1.1 -X POST -d '{"group_guid": "Bj61epXWImP", "domain": "bit.ly", "long_url": "'"$1"'"}' https://api-ssl.bitly.com/v4/shorten | jq -r '.link'
