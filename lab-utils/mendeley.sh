#!/opt/local/bin/bash
# set as second
UPDATETIMEUNIT=1800
REFRESHTIME=3000
SECONDS=0

export MENDELEY_TOKEN=hoge

function refresh-mendeley-token () {

	unset DYLD_LIBRARY_PATH
	APPID=8038
	SECRET=Ez1DlkG7k9eOxdFw
	REFRESH_TOKEN=MSw1Mjg1MTE4NDEsODAzOCxhbGwsLCwsYjQ0OGMyOTgtNGM5Yy0zMDMzLTkxOTktMGQyYTYwOWQ2MGMwLG5vdC11c2VkLG5vdC11c2VkLDRjN2M0NzE3MTAwZTk3NGRmMjU4YWM2Mzk5OTUwNzQ3MDljOGd4cnFhLDE1ODcwMTA0MjM3NzYsckc0YUxfMGdjWTRBZ0h6aDA3ekk0ZHV5U3I4
	REDIRECT=http://localhost:8080
	token=`curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -u "$APPID:$SECRET" -d "grant_type=refresh_token&refresh_token=$REFRESH_TOKEN&redirect_uri=$REDIRECT" https://api.mendeley.com/oauth/token | jq '.access_token'`
	export	MENDELEY_TOKEN=$token
}

function send-to-slack () {

	unset DYLD_LIBRARY_PATH

	GROUPID=143c3207-e8e7-357c-b95f-38492dab6372 # miubiq
	DATE=`date -u -v-"$UPDATETIMEUNIT"S "+%Y-%m-%dT%H:%M:%S"`
	pairs=` curl --request GET "https://api.mendeley.com/files?added_since=$DATE&group_id=$GROUPID&include_trashed=false&limit=500" -H "Authorization: Bearer $MENDELEY_TOKEN"| jq -r '.[] | [.id , .document_id] | @csv' | sed 's/\"//g'`
	echo $pairs
	for i in ${pairs[@]}; do 
		fid=`awk -F "," '{print $1}' <<< "$i"`;
		did=`awk -F "," '{print $2}' <<< "$i"`;
		viewerurl="https://www.mendeley.com/viewer/?fileId=$fid&documentId=$did";
		docinfo=`curl --request GET "https://api.mendeley.com/documents/$did" -H "Authorization: Bearer $MENDELEY_TOKEN"`;title=`echo $docinfo | jq -r '.title'`;
		author=`echo $docinfo | jq '.authors[0].first_name'`;
		year=`echo $docinfo | jq -r '.year'`;
		doi=`echo $docinfo | jq -r '.identifiers.doi'`;
		authors=`echo $docinfo | jq -r '.authors[] | [.first_name, .last_name] | @csv' | sed 's/\"//g' | tr '\n' ' '`;
		source=`echo $docinfo | jq -r '.source'`;
 		data="\"<$viewerurl|$title>\n>$authors\n>($year) $source\n>[<https://www.doi.org/$doi|$doi>]\"";
		echo $data;
		# curl -X POST -H 'Content-type: application/json' --data "{\"text\":$data}" https://hooks.slack.com/services/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
		curl -X POST -H 'Authorization: Bearer xoxb-1067436810899-1091085206720-tkOVPFPGaJGNTPEPhKRyGFKs' -H 'Content-type: application/json' --data "{\"text\":$data}" https://hooks.slack.com/services/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
	done
}

refresh-mendeley-token
send-to-slack

while :
	do
		sleep $UPDATETIMEUNIT
		if [ $SECONDS -ge $REFRESHTIME ]; then
			refresh-mendeley-token
      echo "refresh"
			SECONDS=0
		fi
		send-to-slack
 done

