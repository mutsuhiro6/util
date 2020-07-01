#!/opt/local/bin/bash

from=$(echo $1 | sed 's/\./\\\./g')
to=$(echo $2 | sed 's/\./\\\./g')

echo $from
echo $to

repoName=$(basename $(git remote -v |  awk '{print $2}') |  sed 's/\.git//g')
currentBranch=`git rev-parse --abbrev-ref HEAD`
bumpBranch=feature/bump_mltoolkit_from_$1_to_$2

if [ -n "$(git status --porcelain)" ]; then 
    # Stash uncommit changes and untracked files
    git stash -u
fi

git checkout develop
git pull

git checkout -b $bumpBranch \
&& sed -i "" -e "s/compile(group: \'org\.miubiq\.commons\', name: \'mltoolkit\', version: \'$from\')/s/compile(group: \'org\.miubiq\.commons\', name: \'mltoolkit\', version: \'$to\')/g" build.gradle \
&& git commit -am "bump mltoolkit version from $from to $to" \
&& git push -u origin $bumpBranch \
&& open https://bitbucket.org/icslab/$repoName/pull-requests/new?dest=icslab/$repoName::develop&source=icslab/$repoName::$bumpBranch#diff

git checkout $currentBranch && git stash pop

echo -e "I bumped mltoolkit version from $1 to $2.\nI appreciate it if you make prompt approval.\nThank you for your cooperation.