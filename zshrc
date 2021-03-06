# #################
# ENV
# #################
# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [[ -z "$XDG_DATA_HOME" ]]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

if [[ -z "$XDG_DATA_DIRS" ]]; then
    export XDG_DATA_DIRS="/usr/local/share:/usr/share"
fi

if [[ -z "$XDG_CONFIG_DIRS" ]]; then
    export XDG_CONFIG_DIRS="/etc/xdg"
  else
      export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_DIRS"
fi

# #################
# THEME
# #################
ZSH_THEME="agnoster"

# #################
# CONFIG
# #################
if [[ $TERM == xterm ]]; then TERM=xterm-256color; fi

# custom aliases
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# git
#autoload -Uz vcs_info
#zstyle ":vcs_info:*" enable git
#zstyle ":vcs_info:(git*):*" get-revision true
#zstyle ":vcs_info:(git*):*" check-for-changes true

#local _branch="%c%u%m %{$fg[green]%}%b%{$reset_color%}"
#local _repo="%{$fg[green]%}%r %{$fg[yellow]%}%{$reset_color%}"
#local _revision="%{$fg[yellow]%}%.7i%{$reset_color%}"
#local _action="%{$fg[red]%}%a%{$reset_color%}"
#zstyle ":vcs_info:*" stagedstr "%{$fg[yellow]%}✓%{$reset_color%}"
#zstyle ":vcs_info:*" unstagedstr "%{$fg[red]%}✗%{$reset_color%}"
#zstyle ":vcs_info:git*" formats "$_branch:$_revision - $_repo"
#zstyle ":vcs_info:git*" actionformats "$_branch:$_revision:$_action - $_repo"
#zstyle ':vcs_info:git*+set-message:*' hooks git-stash

#function +vi-git-stash() {
#  if [[ -s "${hook_com[base]}/.git/refs/stash" ]]; then
#        hook_com[misc]="%{$fg_bold[grey]%}~%{$reset_color%}"
#  fi
#}

# precmd() {
#  vcs_info
#}

# #################
# OH-MY-ZSH
# #################
export ZSH=$HOME/.oh-my-zsh

# plugins
plugins=(
  # git
  git
  #git-prompt

  # cli support
  fzf
  last-working-dir 
  zsh-autosuggestions
  zsh-syntax-highlighting 
  zsh-interactive-cd
  dotenv

  # docker
  docker
  docker-compose
)

# actually load
source "${ZSH}/oh-my-zsh.sh"

# #################
# FUNCTIONS
# #################

# zip all files (include .git) in directory recursively
# usage : dzip [folder name]
dzip() {
  if [[ -d $1/.git ]]; then
    echo "git exist"
    if [[ -d $1/build ]]; then
      echo "build exist"
      zip -r $1.zip $1/* $1/.git -x $1/build/\*
    else
      zip -r $1.zip $1/* $1/.git
    fi
  else
    echo "git not"
    zip -r $1.zip $1/*
  fi
}

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

fzfpw() {
  fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                echo {} is a binary file ||
                (highlight -0 ansi -l {} ||
                coderay {} ||
                rougify {} ||
                cat {}) 2> /dev/null | head -500'
              }


miniprompt() {
  unset PROMPT_COMMAND
  PS1="\[\e[38;5;168m\]$ \[\e[0m\]"
}

# kill tmux sessions
tmuxkillf () {
  local sessions
  sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
  local i
  for i in "${(f@)sessions}"
  do
    [[ $i =~ '([^:]*):.*' ]] && {
      echo "Killing $match[1]"
      tmux kill-session -t "$match[1]"
    }
  done
}

# just display docker container id
fb() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# stop running docker container
ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# remove docker images
drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}

# display disk usage ascending sorted
usage() {
  du -hs * .* | sort -h
}

# tmux
tattch() {
  tmux attach-session -t "$S1"
}

# touch all files recursively current directory
touchall() {
  find . -type f -exec touch {} +
}

# xauth
# equivalent -> (xauth -f ~/.Xauthority list | tail -1)
xlist() {
  local num
  if [ -z "$1" ]; then num=10; else num=$1; fi
  xauth list | awk "/unix:${num}/"
}

# #################
# EXTRAS
# #################
export GOPATH=$HOME/gowork
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin

export BAT_THEME="Dracula"
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin
