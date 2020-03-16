function xvideos-first {
	curl -s https://www.xvideos.com | grep -o -m 1 '\/video[0-9]*\/' | grep -m 1 ".*" | sed -E 's/(\/video[0-9]*\/)/https:\/\/www.xvideos.com\1/' | xargs open -a "Google Chrome" --args --incognito
}

function xvideos-random {
	curl -s https://www.xvideos.com | grep -o '\/video[0-9]*\/' | sort -R | head -1 | sed -E 's/(\/video[0-9]*\/)/https:\/\/www.xvideos.com\1/' | xargs open
}

function xvideos-dl {
	curl -s https://www.xvideos.com | grep -o '\/video[0-9]\/' | sort -R | head -1 | sed -E 's/(\/video[0-9]*\/)/https:\/\/www.xvideos.com\1/' | xargs -IURL curl URL -O | grep 'html5player.setVideoUrlHigh' | grep -o "\'https\S*\'" | xargs -IURL curl URL -o av.mp4
}

function xvideos() {
	if [ $# -gt 1 ]; then
		echo "argument number must be less than 2"
	elif [ $# -eq 0 ]; then
		xvideos-random
	elif [ $1 = "-r" ]; then
		xvideos-random
	elif [ $1 = "-f" ]; then
		xvideos-first
	elif [ $1 = "-h" ]; then
		echo -e "You can open xvideos.com with 'xvideos [-r|-f]'.\nOptions:\n\t-r: randomly open a video\n\t-f: open the first video on top page of xvideos.com"
	else
		echo "Error: Only -r and -f are supported."
	fi
}
