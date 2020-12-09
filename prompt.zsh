#!/bin/zsh

if [[ -e /usr/share/zsh/site-contrib/powerline.zsh ]]; then
  . /usr/share/zsh/site-contrib/powerline.zsh
  VIRTUAL_ENV_DISABLE_PROMPT=true
else
  # users        : cyan
  # root         : red
  # sytstem user : magenta
  local _time="%{$fg[yellow]%}[%*]"
  local _path="%B{$fg[green]%}%(8~|...|)%7~"
  local _usercol
  if [[ $EUID -lt 1000 ]]; then
    _usercol="%(!.%{$fg[red]%}.%{$fg[magenta]%})"
  else
    _usercol="$fg[cyan]"
  fi
  local _user="%{$_usercol%}%n@%M"
  local _prompt="%{$fg[white]%}${(r:$SHLVL*2::%#:)}"

  PROMPT="$_time $_user $_path $_prompt%b%f%k "

  RPROMPT='${vcs_info_msg_0_}' # git branch
  if [[ ! -z "$SSH_CLIENT" ]]; then
    RPROMPT="$RPROMPT ⇄" # ssh icon
  fi
fi
