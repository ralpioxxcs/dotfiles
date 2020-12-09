# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

######################
# SYSTEM CONFIGURATION
######################
[ -z ${PLATFORM+x} ] && export PLATFORM=$(uname -s)
[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"
#[ -f /etc/bashrc ] && . /etc/bashrc
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
      . /usr/share/bash-completion/bash_completion

#BASE=$(dirname $(readlink $BASH_SOURCE))

##############
# OPTIONS
##############
# append to the history file, don't overwrite it
shopt -s histappend

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## Disable CTRL-S , CTRL-Q
[[ $- =~ i ]] && stty -ixoff -ixon

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

##############
# ENVIRONMETNS
##############
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:  "
[ -z "$TMPDIR" ] && TMPDIR=/tmp

export GOPATH=~/gowork
mkdir -p $GOPATH

if [ "$PLATFORM" = 'Darwin' ]; then
    export PATH=~/bin:/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$GOPATH/bin:$PATH
    export EDITOR=nvim
else
    export PATH=~/bin:$PATH
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.:/usr/local/lib
    export EDITOR=vim
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export LIBGL_ALWAYS_INDIRECT=1
export PATH="/usr/local/go/bin:$PATH"

## osx
export COPYFILE_DISABLE=true
export BASH_SILENCE_DEPRECATION_WARNING=1

##############
# PROMPT
##############
if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
elif [ "$PLATFORM" = Darwin ]; then
  alias ls='ls -G'
fi

if [ "$PLATFORM" = Linux ]; then
  PS1="\[\e[1;38m\]\u\[\e[1;34m\]@\[\e[1;31m\]\h\[\e[1;30m\]:"
  PS1="$PS1\[\e[0;38m\]\w\[\e[1;35m\]> \[\e[0m\]"
else
  ### git-prompt
  __git_ps1() { :;}
  if [ -e ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
  fi
  PS1='\[\e[34m\]\u\[\e[1;32m\]@\[\e[0;33m\]\h\[\e[35m\]:\[\e[m\]\w\[\e[1;30m\]$(__git_ps1)\[\e[1;31m\]> \[\e[0m\]'
fi

############
# FUNCTIONS
############
gitzip() {
  git archive -o $(basename $PWD).zip HEAD
}

gittgz() {
  git archive -o $(basename $PWD).tgz HEAD
}

gitdiffb() {
  if [ $# -ne 2 ]; then
    echo two branch names required
    return
  fi
  git log --graph \
  --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
  --abbrev-commit --date=relative $1..$2
}

alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

miniprompt() {
  unset PROMPT_COMMAND
  PS1="\[\e[38;5;168m\]$ \[\e[0m\]"
}
