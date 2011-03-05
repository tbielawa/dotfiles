# -*- mode: shell-script -*-
# Access a lot of public terminals? Lets make sure we don't get
# carried away while we're hacking

for user in $(who | cut -d " " -f1 - ); do
    if [[ ! "${user}" = `whoami` ]]; then
	echo
	echo "(!!) Be careful -- you're not the only one here. (!!)"
	w
	break
    fi
done

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
if [ -d ~/.bin ]; then
    PATH=${PATH}:.bin/
fi

source .bash_colors

if test -f $HOME/.gpg-agent-info && kill -0 `cut -d: -f 2 $HOME/.gpg-agent-info` 2>/dev/null; then
    GPG_AGENT_INFO=`cat $HOME/.gpg-agent-info`
    export GPG_AGENT_INFO
else
    eval `gpg-agent --daemon`
    echo $GPG_AGENT_INFO >$HOME/.gpg-agent-info
fi

