#! /bin/bash

dateInfo=$(date "+%Y%m%d%H%M")
repoName=$(basename $(git rev-parse --show-toplevel))
commitHash=$(git rev-parse --short HEAD)
workspace=$1
mkdir -p ${workspace}/${repoName}-from-miubiq/$dateInfo
cp -r ../${repoName} ${workspace}/${repoName}-from-miubiq/$dateInfo/
cd "$workspace"
tar czf ${repoName}-${dateInfo}.tar.gz ${repoName}-from-miubiq

# 依頼するスクリプト生成
echo "===="
echo "wget TODO \\"
echo "&& tar xzf ${repoName}-${dateInfo}.tar.gz \\"
echo "&& cd ${repoName}-from-miubiq/${dateInfo}/${repoName} \\" 
echo "&& ./miubiq-exp.sh -y TODO"
echo "===="

# 伝える情報の出力
echo "output dir: \${実行開始時間}-${repoName}-${commitHash}-\${実行環境情報}"
echo "commit hash: $commitHash"
