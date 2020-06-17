#! /bin/bash

# specify the location of the directory from and to
## ex. $HOME/git/mltoolkit
from=${1%/}
## ex. $HOME/git/parser-toolkit
to=${2%/}

# specify the full name of package
## ex. org.miubiq.common.io.parser.opendata.iris
package=$(echo $3 | sed 's/\./\//g')

echo "from: $from"
echo "to: $to"
echo "package: $package"

mainscala="src/main/scala/$package"
mainresources="src/main/resources/$package"
testscala="src/test/scala/$package"
testresources="src/test/resources/$package"

itr=($mainscala $mainresources $testscala $testresources)

for path in ${itr[@]} 
do
	echo "$to/$path"
	if [ -d "$to/$path" ]; then
		echo "$to/$path already exists. Exit with error."
		exit 1
	else
		mkdir -p "$to/$path"
	fi
	cp -r "$from/$path/" "$to/$path"
done

