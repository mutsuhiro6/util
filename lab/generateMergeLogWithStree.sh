#!/opt/local/bin/bash
cd $1
pwd
branchName=`git status | grep "On branch" | sed "s/On branch //"`
echo "On branch $branchName"
if [ $branchName = "develop" ]; then
    latestVer=`git ls-remote --tags | grep M | sed "s/.*refs\/tags\///" | sort -t . -n -k 1,1 -k 2,2 -k 3,3 | tail -n 1 | sed 's/M.*$/M/g'`
    echo "Creating merge log for $latestVer"
    system_uuid=`system_profiler SPHardwareDataType |grep "Hardware UUID: [0-9A-Z]\{8\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{12\}" | sed -e 's/^.*Hardware UUID: \([0-9A-Z]\{8\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{4\}-[0-9A-Z]\{12\}\).*$/\1/g'`
    bb_pw=`echo Nm11cmFrYW1pMwo= | /opt/local/bin/openssl enc -d -pbkdf2 -base64 -k "$system_uuid"`
    bb_id=miwam
    $HOME/Workspace/miubiq-templates/sbin/create-release-note.sh $latestVer <<< `echo "$bb_id"; echo "$bb_pw"`
else
    echo "You must execute this script on develop but current branch is $branchName"
fi
