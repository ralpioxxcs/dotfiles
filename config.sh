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
################################

# check if package is installed
check_package_installed() {
  local value=$1
  REQUIRED_PKG=${value}
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG | grep "install ok installed")
  echo Checking for $REQUIRED_PKG: $PKG_OK
  if [ "" = "$PKG_OK" ]; then
    retVal="False"
  else
    retVal="True"
  fi
}

config_neovim() {
  local pac="neovim"
  check_package_installed $pac
  if [ "${retVal}" = "True" ]; then
    echo "$pac is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "$pac is not installed"
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install -y neovim
    sudo apt-get install python-dev python-pip python3-dev python3-pip
    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor
  fi

  if [ -d "$HOME/.config/nvim" ]; then
    read -p "neovim config folder is already existed. overwrite it? (y/n)" yn
    case $yn in
      [Yy]* ) 
        mkdir -p $HOME/.config/
        rsync -azvh nvim $HOME/.config/
        if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ]; then
          curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                      nvim -c "PlugInstall" -c "qall"
        fi
    esac
  else
    mkdir -p $HOME/.config/
    rsync -azvh nvim $HOME/.config/
    if [ ! -f "$HOME/.config/nvim/autoload/plug.vim" ]; then
      curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
              nvim -c "PlugInstall" -c "qall"
    fi
  fi
}

config_zsh() {
  local pac="zsh"
  check_package_installed $pac
  if [ "${retVal}" = "True" ]; then
    echo "$pac is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "$pac is not installed"
    sudo apt install -y zsh
    chsh -c /usr/bin/zsh
  fi

  cp zshrc $HOME/.zshrc

  # oh-my-zsh configuration
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  cp agnoster.zsh-theme $ZSH/themes
}

config_tmux() {
  local pac="tmux"
  check_package_installed $pac
  if [ "${retVal}" = "True" ]; then
    echo "$pac is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "$pac is not installed"
    sudo apt install -y tmux
  fi

  local file=".tmux.conf"
  if [ -f "$HOME/$file" ]; then
    read -p "$file is already existed. overwrite it? (y/n)" yn
    case $yn in
      [Yy]* ) cp tmux.conf $HOME/.tmux.conf
    esac
  fi

  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
}

##-------------------------------------------------------------------------##

os_type=$(uname)

echo "Select dotfile which you want to apply"
echo "1) neovim"
echo "2) zsh & oh-my-zsh"
echo "3) tmux"
read ans

if [ "$ans" != "${ans#[1]}" ] ;then
  config_neovim
elif [ "$ans" != "${ans#[2]}" ] ;then
  config_zsh
elif [ "$ans" != "${ans#[3]}" ] ;then
  config_tmux
fi
