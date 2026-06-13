set -x EDITOR nvim

#
# Docker
#
alias d="docker"
alias dc="docker compose"

#
# Vim
#
alias vi="vim"
alias vim="nvim"

#
# Easy navigation
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#
# Shortcuts
#
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"

#
# Git
#
alias g="git"

#
# List files
#
alias ls="eza"
alias ll="eza -alh"
alias tree="eza --tree"

#
# Grep
#
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#
# Networks
#
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

#
# Translation
#
alias trs_k2e="trans -b :en"
alias trs_e2k="trans -b :ko"

#
# ETC
#
alias reload="exec fish"
alias lg='lazygit'
alias ts="tmux-session"
alias tsw="tmux-session-window"
alias wm='workmux'
