#!/bin/bash

# execute `path/to/create-release-note.sh $version in the target repository


# require bitbucket user authentication
#	read -p "bitbucket user name: " usr
#	read -sp "password: " pw
#	echo
ver=`echo $1 | sed 's/\./\\\./g'`
usr=$2
pw=$3

echo $ver

repo=$(basename $(git remote -v |  awk '{print $2}') |  sed 's/\.git//g')
repourl="https://bitbucket.org/icslab/$repo"
logs=`git log --all --merges --pretty=format:'%ad,%D,%s' --date=short  --decorate-refs=tags |\
 grep "tag: " |\
 sed 's/\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\},\).*tag: \(.*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}M*[0-9]*,\).*#\([0-9]\{1,\}\).*/\2\1\3/' |\
 grep -E "$ver"`
	# log will be `$tag,$date,$PR-number`

	# if specified version is a release version (without "M")
if [ $# = 1 ] && [ "`echo $ver | grep -v "M"`" ]; then
    # remove inappropriate versions
    # remove logs of "0.0.30" if you specify "0.0.3"
    logs=`grep -Ev "$ver[0-9]\+" <<< $logs`
fi

for log in ${logs[@]}; do
    tag=`awk -F "," '{print $1}' <<< "$log"`;
    date=`awk -F "," '{print $2}' <<< "$log"`;
    id=`awk -F "," '{print $3}' <<< "$log"`;
    if [ "`echo $tag | grep "M"`" ]; then
	# parse JSON response of bitbucket api and take pull request title
	endpoint="https://api.bitbucket.org/2.0/repositories/icslab/$repo/pullrequests/$id"
	response=`curl -sL $endpoint -u $usr:$pw`
	if [ -z "$response" ]; then
	    echo "ERROR: Response from bitbucket.org is empty."
	    echo "You might type wrong username or password."
	    exit 1
	fi
	title=`echo $response | \
		sed 's/^\[{\(.*\)}]$/\1/' | \
		tr ',' '\n' | \
		grep '\"title\": \"' | \
		sed 's/^.*: //' | tr -d '"'`
	# format text for minor verssions
	echo -e "- [[**$tag**]($repourl/src/$tag)] (merged on $date, [pull request #$id]($repourl/pull-requests/$id))\n    - $title"
    else
	# format text for release versions
	echo -e "\n## [[**$tag**]($repourl/src/$tag)] (released on $date, [pull request #$id]($repourl/pull-requests/$id))\n"
    fi
done
