
WORK_DIR=`pwd`

for dir in `ls -F | grep /`; do
    cd $dir
    pwd

    currentBranch=`git rev-parse --abbrev-ref HEAD`
    stash=1

    if [ -n "$(git status --porcelain)" ]; then 
	# Stash uncommit changes and untracked files
	git stash -u
	stash=0
    fi
    
    git fetch --all\
    && git checkout master\
    && git pull\
    && git checkout develop\
    && git pull

    if [ $stash = 0 ]; then
	git stash pop
    fi

    git checkout $currentBranch
    
    cd $WORK_DIR
done
