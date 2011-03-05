# -*- mode: shell-script -*-

[ -f  ~/.bash_aliases ] && . ~/.bash_aliases
[ -z "$PS1" ] && return

GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWDIRTYSTATE

export HISTCONTROL=ignoredups
export HISTCONTROL=ignoreboth
export HISTFILESIZE=5000
shopt -s checkwinsize
export PRINTER=two_west
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"



case "$TERM" in
xterm*|linux|rxvt)
    if [ -f ~/.bash_lcsee ]; then
         PS1='[CSEE]<\e[1;34m\u\e[0;39m>@(\e[0;36m\h\e[0;39m)[\w] \T$(__git_ps1 " (%s)")\n\$ '
    else
         PS1='<\e[1;34m\u\e[0;39m>@(\e[0;36m\h\e[0;39m)[\w] \T\e[0;31m$(__git_ps1 " (%s)")\e[0m\n\$ '
    fi
    ;;
screen*)
        PS1='\[\ek\e\\\]<\e[1;34m\u\e[0;39m>@(\e[0;36m\h\e[0;39m)[\w] \T\e[0;31m$(__git_ps1 " (%s)")\e[0m\n\$ '	
	;;
*)
    PS1='\u@\h:\w\$ '
    ;;
esac


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Handy Alias definitions.
if [ -f ~/.bash_lcsee_aliases ]; then
    . ~/.bash_lcsee_aliases

# I'm a developer, these are my creds
export DEBEMAIL=tbielawa@csee.wvu.edu
export DEVEDITOR=emacs
export EDITOR=emacs
export DEBFULLNAME="Timothy Bielawa (Shaggy)"
export EMAIL=tbielawa@redhat.com

#@source /etc/bash_completion.d/git
. ~/.bash_functions

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

GPG_TTY=`tty`
export GPG_TTY

