function meigen () {
	rand=$(($RANDOM % 10))
	if [ $rand -eq 0 ]; then
		source $HOME/util/yoshii-meigen.sh
	else
		source $HOME/util/meigen.sh
	fi
}

export PS1="\w\n\[\e[1;35m\]$\[\e[m\] "

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

source $HOME/util/password-util.sh

function generate-release-note() {
	tag=$1
	bb_id=miwam
	bb_pw=`decrypt_password Nm11cmFrYW1pMwo=`
	$HOME/Workspace/miubiq-templates/sbin/create-release-note.sh $tag <<< `echo "$bb_id"; echo "$bb_pw"` | pbcopy
}

export PATH=/opt/local/bin:$PATH
export JAVA_HOME="/Library/Java/JavaVirtualMachines/liberica-jdk-8-full.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
eval `opam config env`

export MIUBIQY="$HOME/Dropbox/MIUBIQ_Y"
export ART="$MIUBIQY/temporary-from-miubiq/from-iwamoto/artifacts"

# not to include MacOS system files into tar archives
export COPYFILE_DISABLE=1

alias cl=clear
alias la="ls -a"
alias ll="ls -la"
alias t2="~/util/t2/t2login.py"
alias ptl="~/util/ptl/plogin.py"
alias skim="open -a /Applications/Skim.app"
alias typora="open -a /Applications/Typora.app"
alias e="emacs"
alias openExpArchives="~/util/lab/openExpArchives.sh"
alias top="top -o cpu"

source $HOME/util/lab-utils/set-dyld-lib-path.sh
set-dyld-v98
meigen
# source $HOME/utils/xvideos.sh


