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
  git-prompt

  # cli support
  fzf
  last-working-dir 
  zsh-autosuggestions
  zsh-syntax-highlighting 
  dotenv

  # docker
  docker
  docker-compose
)

# actually load
source "${ZSH}/oh-my-zsh.sh"

# #################
# ETC
# #################

export BAT_THEME="Dracula"
