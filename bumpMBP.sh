#!/opt/local/bin/bash

from=$(echo $1 | sed 's/\./\\\./g')
to=$(echo $2 | sed 's/\./\\\./g')

echo $from
echo $to

git checkout develop \
&& git checkout -b feature/bump_miubiq_build_plugin_from_$1_to_$2  \
&& sed -i "" -e "s/classpath \"gradle\.plugin\.org\.miubiq:miubiq-build-plugin:$from\"/classpath \"gradle\.plugin\.org\.miubiq:miubiq-build-plugin:$to\"/g" build.gradle  \
&& git add build.gradle \
&& git commit -m "bump miubiq build plugin version from $from to $to" \
&& git add build.gradle \
&& stree . \
