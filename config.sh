#!/bin/bash

#########################
# Bash colors
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

#########################
## Constants
declare -r RETURN_TRUE=1
declare -r RETURN_FALSE=0

#########################
## Runtime variables
os_type=$(uname)
sudoPW=""
log_filename='log_$(date_+%y%m%d%H%M%S).txt'
spin='-\|/'

################################################################

main() {
  sudo -S true < /dev/null 2> /dev/null
  if [ $? != 0 ]; then
    read -s -p "Enter password for sudo: " sudoPW
    echo -n ${sudoPW} | sudo -S ls /root >/dev/null 2>&1
    if [ $? != 0 ]; then
      echo -e "${COLOR_RED}sudo password is incorrect${COLOR_NONE}"
      exit    
    fi
  fi

  check_preinstalled_packages

  while true; do
    clear
    echo "# select categories"
    echo "[1] terminal"
    echo "[2] editors"
    echo "[3] languages"
    echo "[4] auto"
    echo "[5] exit"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      terminal
    elif [ "$ans" != "${ans#[2]}" ]; then
      editors
    elif [ "$ans" != "${ans#[3]}" ]; then
      languages
    elif [ "$ans" != "${ans#[4]}" ]; then
      echo "auto"
    elif [ "$ans" != "${ans#[5]}" ]; then
      exit 1
    else
      echo "Please answer number"
    fi
  done
}

##########################################
################ util ####################
##########################################

check_preinstalled_packages() {
  local prerequsite_pacakges=("curl", "zsh", "lua5.2")
  echo " "
  echo "check & install prerequisite packages.."
  apt_install_wrapper curl wget lua5.2 >/dev/null 2>&1 &
  spinner 
}

check_package_installed() {
  pkgName=${1}

  if command -v ${pkgName} &> /dev/null
  then
    retVal="True"
    return 
  fi

  if [ ${os_type} == "Darwin" ]; then
    ok=$(brew ls --versions ${pkgName})
  elif [ ${os_type} == "Linux" ]; then
    ok=$(dpkg-query -W --showformat='${Status}\n' ${pkgName} | grep "install ok installed")
  fi


  if [ -n "${ok}" ]; then
    retVal="True"
  else
    retVal="False"
  fi
}

check_directory_is_exist() {
  dirName=${1}
}

check_binary_is_exist() {
  binName=${1}
}


apt_install_wrapper() {
  packages=" "
  for var in "$@"
  do
    packages+=" ${var}"
  done
  echo ${packages}

  echo $sudoPW | sudo -S apt install -y ${packages}
}

custom_install_wrapper() {
  for cmd in "$@"
  do
    eval "${cmd}"
  done
}

spinner() {
    pid=$!
    i=0
    while kill -0 $pid 2>/dev/null
    do
      i=$(( (i+1) %4 ))
      #printf "${COLOR_CYAN}\r${spin:$i:1}"
      printf "."
      sleep .1
    done
    echo -e ${COLOR_NONE}
}

################################################################

terminal() {
  while true; do
    clear
    echo -e "[1] zsh & oh-my-zsh"
    echo -e "[2] tmux"
    echo -e "[3] lazygit"
    echo -e "[4] ${COLOR_DARK_GRAY}back${COLOR_NONE}"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      install_zsh
    elif [ "$ans" != "${ans#[2]}" ]; then
      install_tmux
    elif [ "$ans" != "${ans#[3]}" ]; then
      install_lazygit
    elif [ "$ans" != "${ans#[4]}" ]; then
      break
    else
      echo "please answer number"
    fi
  done
}

editors() {
  while true; do
    clear
    printf "[1] neovim\n"
    printf "[2] vscode\n"
    echo -e "[3] ${COLOR_DARK_GRAY}back${COLOR_NONE}"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      install_neovim
    elif [ "$ans" != "${ans#[2]}" ]; then
      # config_vscode
      echo "skip"
    elif [ "$ans" != "${ans#[3]}" ]; then
      break
    else
      echo "please answer number"
    fi
  done
}

languages() {
  while true; do
    clear    
    echo "[1] golang"
    echo "[2] rust"
    echo -e "[3] ${COLOR_DARK_GRAY}back${COLOR_NONE}"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      install_golang
    elif [ "$ans" != "${ans#[2]}" ]; then
      # config_rust
      echo "skip"
    elif [ "$ans" != "${ans#[3]}" ]; then
      break
    else
      echo "please answer number"
    fi
  done
}

################################################################

install_neovim() {
  local pac="neovim"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing ${pac}"

    custom_install_wrapper \
    'wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz' \
    'tar zxvf nvim-linux64.tar.gz' \
    'sudo mv ./nvim-linux64/bin/nvim /usr/local/bin'
    'sudo mv ./nvim-linux64/lib/* /usr/local/lib/'
    'sudo mv ./nvim-linux64/share/* /usr/local/share/'
    >/dev/null 2>&1 &
    spinner

    rm -rf nvim-linux64.tar.gz
  fi

  if [ -d "${HOME}/.config/nvim" ]; then
    while true; do
      read -p "neovim config directory is already existed. overwrite it? [Y/n]" yn
      case $yn in
      [Yy]*)
        mkdir -p ${HOME}/.config/
        rsync -azvh nvim ${HOME}/.config/
        if [ ! -f "${HOME}/.config/nvim/autoload/plug.vim" ]; then
          curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
          nvim -c "PlugInstall" -c "qall"
        fi
        break;;
      [Nn]*) break;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  else
    mkdir -p ${HOME}/.config/
    rsync -azvh nvim ${HOME}/.config/
    if [ ! -f "${HOME}/.config/nvim/autoload/plug.vim" ]; then
      curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      nvim -c "PlugInstall" -c "qall"
      nvim -c "coc-sh" -c "qall"
      nvim -c "coc-json" -c "qall"
      nvim -c "coc-cmake" -c "qall"
      nvim -c "coc-go" -c "qall"
    fi
  fi

  echo -e "${COLOR_GREEN}install dependencies ${COLOR_NONE}"

  local pac="nodejs"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing ${pac}"
    custom_install_wrapper \
    'curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -' \
    'sudo apt-get install -y nodejs' \
    >/dev/null 2>&1 &
    spinner
  fi

  local pac="exuberant-ctags"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing ${pac}"
    apt_install_wrapper exuberant-ctags 2>&1 &
    spinner
  fi

  local pac="ripgrep"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing ${pac}"
    custom_install_wrapper \
    'curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb' \
    'sudo dpkg -i ripgrep_12.1.1_amd64.deb' \
    >/dev/null 2>&1 &
    spinner

    rm -rf ripgrep_12.1.1_amd64.deb
  fi
}

install_zsh() {
  local pac="zsh"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing zsh.."
    apt_install_wrapper ${pac} >/dev/null 2>&1 &
    spinner
    zsh --version
    chsh -s $(which zsh)
  fi

  # copy dotfile (zshrc, aliases)
  cp -v .zshrc ${HOME}/.zshrc
  cp -v .aliases ${HOME}/.aliases

  # oh-my-zsh configuration
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    echo -e "${COLOR_RED}oh-my-zsh is not installed${COLOR_NONE}"
    custom_install_wrapper \
    'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"' \
    >/dev/null 2>&1 &
    spinner
  else
    echo -e "${COLOR_GREEN}oh-my-zsh is already installed${COLOR_NONE}"
  fi

  zsh_plugins=("zsh-completions" "zsh-syntax-highlighting" "zsh-autosuggestions", "spaceship-prompt", "fzf")

  # install plugins
  # -- completion, syntax-highligting, autosuggestions, fzf
  #----------------------------------------------------------------------------------------
  echo -e "${COLOR_GREEN}install oh-my-zsh plugins${COLOR_NONE}"
  custom_install_wrapper \
    'git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions' \
    'git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting' \
    'git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions' \
    'git clone --depth=1 https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab' \
    'git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt' \
    'ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme' \
    'git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf' \
    'yes | ~/.fzf/install' \
    >/dev/null 2>&1 &
    spinner

  while true; do
    read -p "Do you want to install Nerd-Fonts? (Hack) [Y/n]" yn
    case $yn in
    [Yy]*)
      echo "install nerd font .."
      custom_install_wrapper \
      'git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git' \
      'nerd-fonts/install.sh Hack' \
      >/dev/null 2>&1 &
      spinner

      break;;
    [Nn]*) break;;
    *) echo "Please answer yes or no." ;;
    esac
  done
}

install_tmux() {
  local pac="tmux"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing tmux.."
    apt_install_wrapper ${pac} >/dev/null 2>&1 &
    spinner
  fi

  local file=".tmux.conf"
  if [ -f "${HOME}/${file}" ]; then
    while true; do
      echo " "
      read -p "${file} is already existed, overwrite it? [Y/n]" yn
      case $yn in
      [Yy]*)
        cp -v tmux.conf ${HOME}/.tmux.conf
        break;;
      [Nn]*) return;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  else
    cp -v tmux.conf ${HOME}/.tmux.conf
  fi

  echo -e "instaling tmux plugin manager (tpm)"
  custom_install_wrapper \
  'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm' \
  '~/.tmux/plugins/tpm/scripts/install_plugins.sh' \
  >/dev/null 2>&1 &
  spinner
}

install_lazygit() {
  local pac="lazygit"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
    sleep 1
    return
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    echo "install lazygit.."
    #'export LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')' \
    #'curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"' \
    custom_install_wrapper \
    'curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_0.37.0_Linux_x86_64.tar.gz"' \
    'tar xf lazygit.tar.gz lazygit' \
    'sudo install lazygit /usr/local/bin' \
    dev/null 2>&1 &
    spinner
  fi
  echo -e "${COLOR_GREEN}${pac} has successfully installed!${COLOR_NONE}"
  lazygit --version
  sleep 5
}

install_golang() {
  local go_ver=1.15.8

  if ! command -v go &>/dev/null; then
    echo >&2 "go is not installed"
  else
    local cur_ver=$(go version | {
      read _ _ v _
      echo ${v#go}
    })
    local cur_ver_major=$(go version | {
      read _ _ v _
      echo ${v#go}
    } | cut -d. -f2)
    local go_ver_major=$(echo ${go_ver} | cut -d. -f2)
    echo "go is already installed (current version : ${cur_ver})"

    if [ ${cur_ver_major} -le ${go_ver_major} ]; then
      if [ -d "/usr/local/go" ]; then
        while true; do
          read -p "remove pre installed go directory (y/n)" yn
          case $yn in
          [Yy]*)
            sudo rm -rf /usr/local/go
            break
            ;;
          [Nn]*) return 1 ;;
          *) echo "Please answer yes or no." ;;
          esac
        done
      fi
    fi
  fi

  wget https://dl.google.com/go/go${go_ver}.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go${go_ver}.linux-amd64.tar.gz
  rm go${go_ver}.linux-amd64.tar.gz

  echo "export PATH=${PATH}:/usr/local/go/bin" >>${HOME}/.profile
  echo -e "command this line -> \"source ~/.profile\""

  source ${HOME}/.profile
  go version
  mkdir -p ${HOME}/gowork/pkg
  mkdir -p ${HOME}/gowork/src
  mkdir -p ${HOME}/gowork/bin
  export PATH=${PATH}:/usr/local/go/bin
  export GOROOT=/usr/local/go
  export GOPATH=${HOME}/gowork
}

##-------------------------------------------------------------------------##

main "$@"
exit
