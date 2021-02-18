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

  # Dependency - Node JS
  local pac="nodejs"
  check_package_installed $pac
  if [ "${retVal}" = "True" ]; then
    echo "$pac is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "$pac is not installed"
    curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi

  # Dependency - Ctags
  local pac="exuberant-ctags"
  check_package_installed $pac
  if [ "${retVal}" = "True" ]; then
    echo "$pac is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "$pac is not installed"
    sudo apt-get install -y exuberant-ctags
  fi

  # Dependency - Ripgrep
  local pac="ripgrep"
  check_package_installed $pac
  if [ "${retVal}" = "True" ]; then
    echo "$pac is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "$pac is not installed"
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
    sudo dpkg -i ripgrep_12.1.1_amd64.deb
    rm ripgrep_12.1.1_amd64.deb
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

  # copy dotfile
  cp zshrc $HOME/.zshrc
  cp aliases $HOME/.aliases

  # oh-my-zsh configuration
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "oh-my-zsh is not installed\n"
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  else
   echo -e "oh-my-zsh is already installed\n"
  fi

  # install plugins
  # * syntax-highligting, autosuggestions, fxf
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

  cp agnoster.zsh-theme ${ZSH}/themes

  # source ~/.zshrc
  echo -e "\nSudo access is needed to change default shell\n"

  if chsh -s $(which zsh) && /bin/zsh -i -c upgrade_oh_my_zsh; then
    echo -e "Installation Successful, exit terminal and enter a new session"
  else
    echo -e "Something is wrong"
  fi

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
  else
    cp tmux.conf $HOME/.tmux.conf
  fi


  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
}

config_golang() {
  local go_ver=1.15.8

  if ! command -v go &> /dev/null
  then
    echo >&2 "go not installed";
    wget https://dl.google.com/go/go${go_ver}.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go${go_ver}.linux-amd64.tar.gz
  else
    local cur_ver=`go version | { read _ _ v _; echo ${v#go}; }`
    local cur_ver_major=`go version | { read _ _ v _; echo ${v#go}; } | cut -d. -f2`
    local go_ver_major=`echo ${go_ver} | cut -d. -f2`
    echo "go is already installed (current version : ${cur_ver})"

    if [ ${cur_ver_major} -le ${go_ver_major} ]; then
      if [ -d "/usr/local/go" ]; then
        read -p "remove pre installed go directory (y/n)" yn
        case $yn in
          [Yy]* ) sudo rm -rf /usr/local/go
        esac
      fi
      wget https://dl.google.com/go/go${go_ver}.linux-amd64.tar.gz
      sudo tar -C /usr/local -xzf go${go_ver}.linux-amd64.tar.gz
    fi
  fi

  go version
  mkdir -p $HOME/gowork/pkg
  mkdir -p $HOME/gowork/src
  mkdir -p $HOME/gowork/bin
  export PATH=$PATH:/usr/local/go/bin
  export GOROOT=/usr/local/go
  export GOPATH=$HOME/gowork
}

##-------------------------------------------------------------------------##

os_type=$(uname)

if [ "$os_type" == "Darwin" ]; then
  echo "not support osx"
  exit
fi

echo "Select configuration which you want to apply"
echo "1) neovim"
echo "2) zsh & oh-my-zsh"
echo "3) tmux"
echo "4) golang"
read ans

if [ "$ans" != "${ans#[1]}" ] ;then
  config_neovim
elif [ "$ans" != "${ans#[2]}" ] ;then
  config_zsh
elif [ "$ans" != "${ans#[3]}" ] ;then
  config_tmux
elif [ "$ans" != "${ans#[4]}" ] ;then
  config_golang
fi
