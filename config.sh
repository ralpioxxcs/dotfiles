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

################################################################

log_filename="log_$(date_+%y%m%d%H%M%S).txt"
spin='-\|/'

main() {
  os_type=$(uname)

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

################################################################
check_preinstalled_packages() {
  prerequsite_pacakges=("curl", "zsh")
  echo "check preinstalled packages.."

  sudo apt install -y curl wget 2>&1 /dev/null
}

# check if package is installed
check_package_installed() {
  pkgName=${1}
  if [ ${os_type} == "Darwin" ]; then
    ok=$(brew ls --versions ${pkgName})
  elif [ ${os_type} == "Linux" ]; then
    ok=$(dpkg-query -W --showformat='${Status}\n' ${pkgName} | grep "install ok installed")
  fi

  if [ -n "${ok}" ]; then
    #printf "${COLOR_GREEN}${pkgName} is installed${COLOR_NONE}\n"
    retVal="True"
  else
    #printf "${COLOR_RED}${pkgName} is not installed${COLOR_NONE}\n"
    retVal="False"
  fi
}

check_directory_is_exist() {
  dirName=${1}
}

apt_install_wrapper() {
  packages=" "
  for var in "$@"
  do
    packages+=" ${var}"
  done
  echo ${packages}
  sudo apt install -y ${packages}
}

custom_install_wrapper() {
  $0

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
      config_zsh
    elif [ "$ans" != "${ans#[2]}" ]; then
      config_tmux
    elif [ "$ans" != "${ans#[3]}" ]; then
      config_lazygit
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
    printf "(1) neovim\n"
    printf "(2) vscode\n"
    printf "(3) ${COLOR_RED}back${COLOR_WHITE}\n"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      config_neovim
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
    echo "(1) golang"
    echo "(2) rust"
    echo "(3) ${COLOR_RED}back${COLOR_WHITE}"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      config_golang
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

config_neovim() {
  local pac="neovim"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo "${pac} is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "${pac} is not installed"
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

  if [ -d "${HOME}/.config/nvim" ]; then
    while true; do
      read -p "neovim config folder is already existed. overwrite it? (y/n)" yn
      case $yn in
      [Yy]*)
        mkdir -p ${HOME}/.config/
        rsync -azvh nvim ${HOME}/.config/
        if [ ! -f "${HOME}/.config/nvim/autoload/plug.vim" ]; then
          curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
          nvim -c "PlugInstall" -c "qall"
        fi
        break
        ;;
      [Nn]*) break ;;
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
    fi
  fi

  # Dependency - Node JS
  local pac="nodejs"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo "${pac} is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "${pac} is not installed"
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi

  # Dependency - Ctags
  local pac="exuberant-ctags"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo "${pac} is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "${pac} is not installed"
    sudo apt-get install -y exuberant-ctags
  fi

  # Dependency - Ripgrep
  local pac="ripgrep"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo "${pac} is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "${pac} is not installed"

    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
    sudo dpkg -i ripgrep_12.1.1_amd64.deb
    rm ripgrep_12.1.1_amd64.deb
  fi
}

config_zsh() {
  local pac="zsh"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo "${pac} is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "${pac} is not installed"
    sudo apt install -y zsh
    zsh --version
    chsh -s $(which zsh)
  fi

  # copy dotfile (zshrc, aliases)
  echo "copy \"zshrc\""
  cp zshrc ${HOME}/.zshrc 2 /dev/null &>1
  echo "copy \"aliases\""
  cp aliases ${HOME}/.aliases 2 /dev/null &>1

  # oh-my-zsh configuration
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    echo -e "oh-my-zsh is not installed\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo -e "oh-my-zsh is already installed\n"
  fi

  zsh_plugins=("zsh-completions" "zsh-syntax-highlighting" "zsh-autosuggestions", "spaceship-prompt", "fzf")

  # install plugins
  # -- completion, syntax-highligting, autosuggestions, fzf
  #----------------------------------------------------------------------------------------
  if [ -d ~/.oh-my-zsh/plugins/zsh-completions ]; then
    cd ~/.oh-my-zsh/plugins/zsh-completions && git pull
  else
    git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions 2>&1 /dev/null
  fi

  if [ -d ~/.oh-my-zsh/plugins/zsh-syntax-highlighting ]; then
    cd ~/.oh-my-zsh/plugins/zsh-syntax-highlighting && git pull
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>&1 /dev/null
  fi

  if [ -d ~/.oh-my-zsh/plugins/zsh-autosuggestions ]; then
    cd ~/.oh-my-zsh/plugins/zsh-autosuggestions && git pull
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>&1 /dev/null
  fi

  if [ -d ~/.oh-my-zsh/plugins/spaceship-prompt ]; then
    cd ~/.oh-my-zsh/plugins/spaceship-prompt && git pull
  else
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "${ZSH_CUSTOM}/themes/spaceship-prompt" --depth=1 2>&1 /dev/null
    ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme" 2>&1 /dev/null
  fi

  if [ -d ~/.fzf ]; then
    cd ~/.fzf && git pull
  else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 2>&1 /dev/null
    ~/.fzf/install 2>&1 /dev/null
  fi

  #cp agnoster.zsh-theme ${ZSH}/themes

  echo -e "n"
  while true; do
    read -p "Do you want to install Nerd-Fonts? (Hack) (y/n)" yn
    case $yn in
    [Yy]*)
      git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git
      nerd-fonts/install.sh Hack
      break
      ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer yes or no." ;;
    esac
  done
}


config_tmux() {
  local pac="tmux"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"

  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing tmux.."

    apt_install_wrapper ${pac} >/dev/null 2>&1 &

    pid=$!
    i=0
    echo -e ${COLOR_CYAN}
    while kill -0 $pid 2>/dev/null
    do
      i=$(( (i+1) %4 ))
      printf "\r ${spin:$i:1}"
      # echo -en "${spin:$i:1}"
      # echo -en "\010"
      #printf "."
      sleep .1
    done
    echo -e ${COLOR_NONE}

  fi

  local file=".tmux.conf"
  if [ -f "${HOME}/${file}" ]; then
    while true; do
      echo " "
      read -p "${file} is already existed. overwrite it? [Y/n]" yn
      case $yn in
      [Yy]*)
        cp tmux.conf ${HOME}/.tmux.conf
        break
        ;;
      [Nn]*) return 1 ;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  else
    cp -v tmux.conf ${HOME}/.tmux.conf
  fi

  echo -e "install tmux plugins .."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh > /dev/null 2>&1

  # custom_install_wrapper "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  # ~/.tmux/plugins/tpm/scripts/install_plugins.sh"

  # pid=$!
  # i=0
  # echo -e ${COLOR_CYAN}
  # while kill -0 $pid 2>/dev/null
  # do
  #   i=$(( (i+1) %4 ))
  #   printf "\r ${spin:$i:1}"
  #   # echo -en "${spin:$i:1}"
  #   # echo -en "\010"
  #   #printf "."
  #   sleep .1
  # done
  # echo -e ${COLOR_NONE}
}

config_lazygit() {
  local pac="lazygit"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo "${pac} is already installed"
  elif [ "${retVal}" == "False" ]; then
    echo "${pac} is not installed"

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[0-35.]+')

    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

    sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

  fi

  lazygit --version
}

config_golang() {
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
