#!/opt/local/bin/bash

from=$(echo $1 | sed 's/\./\\\./g')
to=$(echo $2 | sed 's/\./\\\./g')

echo $from
echo $to

git checkout develop \
&& git checkout -b feature/bump_mltoolkit_from_$1_to_$2  \
&& sed -i "" -e "s/compile(group: \'org\.miubiq\.commons\', name: \'mltoolkit\', version: \'$from\')/s/compile(group: \'org\.miubiq\.commons\', name: \'mltoolkit\', version: \'$to\')/g" build.gradle  \
&& git add build.gradle \
&& git commit -m "bump mltoolkit version from $from to $to" \
&& git add build.gradle \
&& stree . \
