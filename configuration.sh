#!/bin/bash

# Apply all dotfiles
echo "Select dotfile which you want to apply?"
echo "1) vim"
echo "2) tmux"
echo "3) git"
echo "4) all"
read ans

if [ "$ans" != "${ans#[1]}" ] ;then
    echo vim
    if [ -f "vimrc" ] ;then
      cp vimrc ~/.vimrc
      echo -e '\E[47;34m'"\033[1mE\033[0m"
    else
      echo -e '\E[47;34m'"\033[1mE\033[0m"
    fi
elif [ "$ans" != "${ans#[2]}" ] ;then
    echo tmux
    cp tmux.conf ~/.tmux.conf
elif [ "$ans" != "${ans#[3]}" ] ;then
    echo git
    cp gitconfig ~/.gitconfig
else
    echo all setting
fi


