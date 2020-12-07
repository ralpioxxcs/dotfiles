#!/bin/bash

# Bash Colours
COLOR_NONE='\033[0m'
COLOR_BLACK='\033[0;30m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_BROWN='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_PURPLE='\033[0;35m'
COLOR_CYAN='\033[0;36m'
COLOR_LIGHT_GRAY='\033[0;37m'
COLOR_DARK_GRAY='\033[1;30m'
COLOR_LIGHT_RED='\033[1;31m'
COLOR_LIGHT_GREEN='\033[1;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_LIGHT_BLUE='\033[1;34m'
COLOR_LIGHT_PURPLE='\033[1;35m'
COLOR_LIGHT_CYAN='\033[1;36m'
COLOR_WHITE='\033[1;37m'

# check if package is installed
# installed -> return True
# not installed -> return False
check_package() {
  local value=$1
  echo "check ${value} installed ..."
  REQUIRED_PKG=${value}
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
  echo Checking for $REQUIRED_PKG: $PKG_OK
  # if is not installed
  if [ "" = "$PKG_OK" ]; then
    retVal="False"
  else
    retVal="True"
  fi
}

install_ctags() {
  echo -e "${COLOR_YELLOW} install ctags ${COLOR_NONE}"
  wget -O ctags.tar.gz https://sourceforge.net/projects/ctags/files/ctags/5.8/ctags-5.8.tar.gz/download?use_mirror=jaist
  tar -zxvf ctags.tar.gz
  cd ctags-5.8
  ./configure
  CORE=$(nproc --all)
  make -j${CORE}
  sudo make install
}

install_cscope() {
  echo -e "${COLOR_YELLOW} install ctags ${COLOR_NONE}"
  wget -O cscope.tar.gz https://sourceforge.net/projects/cscope/files/latest/download
  tar -zxvf cscope.tar.gz
  cd cscope-15.9
  ./configure
  CORE=$(nproc --all)
  make -j${CORE}
  sudo make install
  sudo cp /usr/local/bin/cscope /usr/bin/cscope
}


##-------------------------------------------------------------------------##

os_type=$(uname)

echo -e "${COLOR_WHITE}Configure all development enviroments${COLOR_NONE}"

check_package "vim"
if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}vim is installed${COLOR_NONE}"
elif [ "${retVal}" = "False" ]; then
    sudo apt-get install vim
fi

check_package "git"
if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}git is installed${COLOR_NONE}"
elif [ "${retVal}" = "False" ]; then
    sudo apt-get install vim
fi

# Install vim & git
#sudo apt-get install vim git \
#  && echo -e "${COLOR_GREEN} success to install git and vim ${COLOR_NONE}" \
#  || { echo -e "${COLOR_RED} failed to install git and vim ${COLOR_NONE}"; }

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


