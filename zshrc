# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Paths
export GOROOT=/usr/local/go
export PATH=${PATH}:${GOROOT}/bin:${ZSH_CUSTOM}/plugins/git-fuzzy/bin:${HOME}/.local/bin
export PATH=${PATH}:$(go env GOPATH)/bin
export PATH=${PATH}:/usr/local/cuda/bin

# Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# ZSH plugins variables
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_CONFIG=$HOME/.tmux.conf
ZSH_TMUX_DEFAULT_SESSION_NAME="main"

# ZSH plugins
plugins=(
  git

  # CLI support
  tmux
  fzf
  fzf-tab
  last-working-dir
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-interactive-cd

  rsync         # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync
  jump          # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jump

  # aliases
  debian        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/debian
  golang        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/golang

  # Docker
  docker
  docker-compose

  dotenv
  cp

  #chucknorris
)

ZSH_THEME="spaceship"

# Spaceship prompt config
SPACESHIP_PROMPT_ORDER=(
  time
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  node          # Node section
  package       # Package version
  golang        # Go section
  lua           # Lua section
  docker        # Docker section
  line_sep      # Line break
  char          # Prompt character
)

SPACESHIP_RPROMPT_ORDER=(
  jobs
  exit_code
)

# PROMPT
SPACESHIP_PROMPT_SYMBOL="➜"
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_PREFIXES_SHOW=true
SPACESHIP_PROMPT_SUFFIXES_SHOW=true
SPACESHIP_PROMPT_DEFAULT_PREFIX="via "
SPACESHIP_PROMPT_DEFAULT_SUFFIX=" "

# TIME
SPACESHIP_TIME_SHOW=false
SPACESHIP_TIME_PREFIX="at "
SPACESHIP_TIME_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_TIME_FORMAT=false
SPACESHIP_TIME_12HR=false
SPACESHIP_TIME_COLOR="yellow"

# USER
SPACESHIP_USER_SHOW=true
SPACESHIP_USER_PREFIX="with "
SPACESHIP_USER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_USER_COLOR="yellow"
SPACESHIP_USER_COLOR_ROOT="red"

# HOST
SPACESHIP_HOST_SHOW=true
SPACESHIP_HOST_PREFIX="at "
SPACESHIP_HOST_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_HOST_COLOR="green"

# DIR
SPACESHIP_DIR_SHOW=true
SPACESHIP_DIR_PREFIX="in "
SPACESHIP_DIR_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_COLOR="cyan"

# GIT
SPACESHIP_GIT_SHOW=true
SPACESHIP_GIT_PREFIX="on "
SPACESHIP_GIT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_GIT_SYMBOL=" "

# GIT BRANCH
SPACESHIP_GIT_BRANCH_SHOW=true
SPACESHIP_GIT_BRANCH_PREFIX="$SPACESHIP_GIT_SYMBOL"
SPACESHIP_GIT_BRANCH_SUFFIX=""
SPACESHIP_GIT_BRANCH_COLOR="magenta"

# GIT STATUS
SPACESHIP_GIT_STATUS_SHOW=true
SPACESHIP_GIT_STATUS_PREFIX=" ["
SPACESHIP_GIT_STATUS_SUFFIX="]"
SPACESHIP_GIT_STATUS_COLOR="red"
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_ADDED="+"
SPACESHIP_GIT_STATUS_MODIFIED="!"
SPACESHIP_GIT_STATUS_RENAMED="»"
SPACESHIP_GIT_STATUS_DELETED="✘"
SPACESHIP_GIT_STATUS_STASHED="$"
SPACESHIP_GIT_STATUS_UNMERGED="="
SPACESHIP_GIT_STATUS_AHEAD="⇡"
SPACESHIP_GIT_STATUS_BEHIND="⇣"
SPACESHIP_GIT_STATUS_DIVERGED="⇕"

# NODE
SPACESHIP_NODE_SHOW=true
SPACESHIP_NODE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
SPACESHIP_NODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_NODE_SYMBOL="⬢ "
SPACESHIP_NODE_DEFAULT_VERSION=""
SPACESHIP_NODE_COLOR="green"

# GOLANG
SPACESHIP_GOLANG_SHOW=true
SPACESHIP_GOLANG_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
SPACESHIP_GOLANG_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_GOLANG_SYMBOL=" "
SPACESHIP_GOLANG_COLOR="cyan"

# DOCKER
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_DOCKER_PREFIX="on "
SPACESHIP_DOCKER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
SPACESHIP_DOCKER_SYMBOL=" "
SPACESHIP_DOCKER_COLOR="cyan"

# Configs
if [[ $TERM == xterm ]]; then 
  TERM=xterm-256color; 
fi

# custom aliases
if [[ -f "$HOME/.aliases" ]]; then
  source "$HOME/.aliases"
fi

# fzf
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# Actually load
source $ZSH/oh-my-zsh.sh

#-----------------------------------------------

# [[Functions]]
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
