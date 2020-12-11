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

echo -e "${COLOR_WHITE}Check pacakges ..${COLOR_NONE}"
check_package "neovim"
if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}vim is installed${COLOR_NONE}"
elif [ "${retVal}" = "False" ]; then
    echo -e "${COLOR_GREEN}vim is not installed${COLOR_NONE}"
fi

check_package "git"
if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}git is installed${COLOR_NONE}"
elif [ "${retVal}" = "False" ]; then
    echo -e "${COLOR_GREEN}git is not installed${COLOR_NONE}"
fi

[[ -f "$HOME/.oh-my-zsh" ]] && cp agnoster.zsh-theme $HOME/.oh-my-zsh/themes/
cp zshrc $HOME/.zshrc
cp aliases $HOME/.aliases
cp wgetrc $HOME/.wgetrc

# Apply all dotfiles
echo "Select dotfile which you want to apply?"
echo "1) neovim"
echo "2) zsh & oh-my-zsh"
echo "3) tmux"
read ans

if [ "$ans" != "${ans#[1]}" ] ;then
	check_package "neovim"
	if [ "${retVal}" = "True" ]; then
		echo "nvim is already installed"
	elif [ "${retVal}" == "False" ]; then
		echo "nvim is not installed"
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

  # neovim configuration
  if [ -d "$HOME/.config/nvim" ]; then
    read -p "neovim configuration folder is already existed. Do you overwrite it? (y/n)" yn
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
elif [ "$ans" != "${ans#[2]}" ] ;then
  check_package "neovim"
fi
