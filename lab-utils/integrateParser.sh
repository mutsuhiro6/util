#! /bin/bash

# Usage:
# ./integrateParser io-parser-ud parser-toolkit org.miubiq.commons.io.parser.ud.poi_count.v2014

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

SRC_REPO=`basename $1`
DEST_REPO=`basename $2`

echo "Edit \"TODO\"s and paste the following message in pull request."
echo "================================"
echo -e "SRC_REPO=$SRC_REPO\\
&& DEST_REPO=$DEST_REPO\\
&& DEST_BRANCH=TODOTODO\\
&& git clone git@bitbucket.org:icslab/\$SRC_REPO.git -b master\\
&& git clone git@bitbucket.org:icslab/\$DEST_REPO.git -b \$DEST_BRANCH \\
&& PACKAGE_INFO=$package\\
&& diff -rq \$DEST_REPO/src/main/scala/\$PACKAGE_INFO \$SRC_REPO/src/main/scala/\$PACKAGE_INFO\\
&& diff -rq \$DEST_REPO/src/main/resources/\$PACKAGE_INFO \$SRC_REPO/src/main/resources/\$PACKAGE_INFO\\
&& diff -rq \$DEST_REPO/src/test/scala/\$PACKAGE_INFO \$SRC_REPO/src/test/scala/\$PACKAGE_INFO\\
&& diff -rq \$DEST_REPO/src/test/resources/\$PACKAGE_INFO \$SRC_REPO/src/test/resources/\$PACKAGE_INFO"
