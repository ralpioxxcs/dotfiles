#!/bin/bash

#########################
# Colors
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

## Entrypoint
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
    echo "# Select categories"
    echo "[1] terminal"
    echo "[2] editors"
    echo "[3] languages"
    echo "[4] tools"
    echo "[5] exit"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      terminal
    elif [ "$ans" != "${ans#[2]}" ]; then
      editors
    elif [ "$ans" != "${ans#[3]}" ]; then
      languages
    elif [ "$ans" != "${ans#[4]}" ]; then
      tools
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
  local prerequsite_pacakges=("curl", "zsh", "lua5.3", "python-pip", "python3-pip", "build-essential", "htop", "vim")
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

pip_install_wrapper() {
  for var in "$@"
  do
    pip3 install ${var}
  done
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
#
# TODO: incremental numbering as a array
#
terminal() {
  while true; do
    clear
    echo -e "[1] zsh & oh-my-zsh"
    echo -e "[2] tmux"
    echo -e "[3] lazy tools (lazygit, lazydocker)"
    echo -e "[4] github tools (gh, ...)"
    echo -e "[5] alacritty"
    echo -e "[6] ${COLOR_DARK_GRAY}back${COLOR_NONE}"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      install_zsh
    elif [ "$ans" != "${ans#[2]}" ]; then
      install_tmux
    elif [ "$ans" != "${ans#[3]}" ]; then
      install_lazygit
      install_lazydocker
    elif [ "$ans" != "${ans#[4]}" ]; then
      install_github_tools
    elif [ "$ans" != "${ans#[5]}" ]; then
      install_alacritty
    elif [ "$ans" != "${ans#[6]}" ]; then
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
    echo "[3] node"
    echo -e "[4] ${COLOR_DARK_GRAY}back${COLOR_NONE}"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      install_golang
    elif [ "$ans" != "${ans#[2]}" ]; then
      # config_rust
      echo "skip"
    elif [ "$ans" != "${ans#[3]}" ]; then
      install_node 18
    elif [ "$ans" != "${ans#[4]}" ]; then
      break
    else
      echo "please answer number"
    fi
  done
}

tools() {
  while true; do
    clear    
    echo "[1] postman"
    echo "[2] obsidian"
    echo -e "[3] ${COLOR_DARK_GRAY}back${COLOR_NONE}"
    read ans

    if [ "$ans" != "${ans#[1]}" ]; then
      install_postman
    elif [ "$ans" != "${ans#[2]}" ]; then
      install_obsidian
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
    'sudo mv ./nvim-linux64/bin/nvim /usr/local/bin' \
    'sudo mv ./nvim-linux64/lib/* /usr/local/lib/' \
    'sudo mv ./nvim-linux64/share/* /usr/local/share/' \
    >/dev/null 2>&1 &
    spinner

    rm -rf nvim-linux64.tar.gz nvim-linux64
  fi

  if [ -d "${HOME}/.config/nvim" ]; then
    while true; do
      read -p "config directory is already existed. Replace it? [Y/n]" yn
      case $yn in
      [Yy]*)
        rm -rf ${HOME}/.config/nvim
        rsync -azvh neovim/* ${HOME}/.config/nvim
        nvim -c "Lazy install"
        break;;
      [Nn]*) break;;
      *) echo "Please answer yes or no." ;;
      esac
    done
  else
    mkdir -p ${HOME}/.config/
    rsync -azvh neovim/* ${HOME}/.config/nvim
    nvim -c "Lazy install"
  fi

  # TODO: universal-ctags (https://github.com/universal-ctags/ctags)
  local pac="exuberant-ctags"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing ${pac}"
    apt_install_wrapper ${pac} >/dev/null 2>&1 &
    spinner
  fi

  pip_install_wrapper "cmake-language-server"

  local pac="python3-venv"
  check_package_installed ${pac}
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    printf "installing ${pac}"
    apt_install_wrapper ${pac} >/dev/null 2>&1 &
    spinner
  fi

  sleep 3
}

install_zsh() {
  local pac="zsh"

  check_package_installed ${pac}

  # Skip install zsh
  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"

    printf "installing zsh.."
    apt_install_wrapper ${pac} >/dev/null 2>&1 &
    spinner

    # verify zsh
    zsh --version
    chsh -s $(which zsh)
  fi

  # copy dotfile (zshrc, aliases)
  printf "Copy zshrc, aliases"
  cp -av zshrc ${HOME}/.zshrc
  cp -av aliases ${HOME}/.aliases

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

  zsh_plugins=(
    "zsh-completions" 
    "zsh-syntax-highlighting" 
    "zsh-autosuggestions", 
    "spaceship-prompt", 
    "fzf"
  )

  # Install plugins
  # -- zsh-completion, 
  # -- zsh-syntax-highligting, 
  # -- zsh-autosuggestions, 
  # -- fzf-tab,
  # -- spaceship-prompt
  #----------------------------------------------------------------------------------------
  echo -e "${COLOR_GREEN}install oh-my-zsh plugins${COLOR_NONE}"
  custom_install_wrapper \
    'git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions' \
    'git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting' \
    'git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions' \
    'git clone --depth=1 https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab' \
    'git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt' \
    'ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme' \
    'git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf' \
    'yes | ~/.fzf/install' \
    >/dev/null 2>&1 &
    spinner

  while true; do
    read -p "Do you want to install Nerd-Fonts? [Y/n]" yn
    case $yn in
    [Yy]*)
      echo "installing Nerd Font (Hack, FiraCode) ..."
      custom_install_wrapper \
      'git clone --depth=1 https://github.com/ryanoasis/nerd-fonts.git' \
      'nerd-fonts/install.sh FiraCode' \
      'nerd-fonts/install.sh SpaceMono' \
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
      read -p "${file} is already existed, Overwrite it? [Y/n]" yn
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

  echo -e "installing Tmux Plugin Manager (tpm)"
  custom_install_wrapper \
  'git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm' \
  '~/.tmux/plugins/tpm/scripts/install_plugins.sh' \
  >/dev/null 2>&1 &
  spinner
}

install_github_tools() {
  local pac="gh"
  check_package_installed ${pac}

  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
    sleep 1
    return
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    echo "installing gh.."

    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)

    custom_install_wrapper \
    'curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg' \
    'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list' \
    'sudo apt update' \
    'sudo apt install gh -y' \
    >/dev/null 2>&1 &
    spinner

  fi

}

install_alacritty() {
  local pac="alacritty"
  check_package_installed ${pac}

  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
    sleep 1
    return
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    echo "installing alacritty.."

    # check cargo
    check_package_installed "cargo"
    if [ "${retVal}" == "False" ]; then
      curl https://sh.rustup.rs -sSf | sh
    fi

    custom_install_wrapper \
    'git clone https://github.com/alacritty/alacritty /tmp/alacirtty'
    'cargo install alacritty' \
    'sudo tic -xe alacritty,alacritty-direct /tmp/alacritty/extra/alacritty.info' \
    'sudo cp /tmp/alacritty/extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg' \
    'sudo desktop-file-install /tmp/alacritty/extra/linux/Alacritty.desktop' \
    'sudo update-desktop-database' \
    >/dev/null 2>&1 &
    spinner

  fi
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
    echo "installing lazygit.."

    custom_install_wrapper \
    'export LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"'"'\"tag_name\": \"v\K[^\"]*'"'"')' \
    'curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"' \
    'tar xf lazygit.tar.gz lazygit' \
    'sudo install lazygit /usr/local/bin' \
    >/dev/null 2>&1 &
    spinner

  fi

  if [ ! -d "${HOME}/.config/lazygit" ]; then
    mkdir -p ${HOME}/.config/lazygit
  fi
  cp -av lazygit.yml ${HOME}/.config/lazygit/config.yml

  rm -rf lazygit.tar.gz lazygit
  echo -e "${COLOR_GREEN}${pac} has successfully installed!${COLOR_NONE}"
  lazygit --version

  sleep 5
}

install_lazydocker() {
  local pac="lazydocker"
  check_package_installed ${pac}

  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
    sleep 1
    return
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    echo "installing lazygit.."

    custom_install_wrapper \
    'curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash' \
    >/dev/null 2>&1 &
    spinner
  fi

  sleep 5
}

install_node() {
  local pac="nvm"
  local version=${1}
  check_package_installed ${pac}

  if [ "${retVal}" = "True" ]; then
    echo -e "${COLOR_GREEN}${pac} is already installed${COLOR_NONE}"
    sleep 1
  elif [ "${retVal}" == "False" ]; then
    echo -e "${COLOR_RED}${pac} is not installed${COLOR_NONE}"
    echo "installing nvm.."

    custom_install_wrapper \
    'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash' \
    >/dev/null 2>&1 &
    spinner

    export NVM_DIR="$HOME/.nvm" >> ~/.zshrc
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" >> ~/.zshrc
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" >> ~/.zshrc

    source ~/.zshrc
  fi

  nvm list
  nvm install ${version}
  nvm use ${version}
}

install_golang() {
  local go_ver=1.20.4

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

install_postman() {
  cd /tmp || exit
  echo "Download Postman .."

  sudo rm -rf /opt/Postman

  tar -C /tmp/ -xzf <(curl -L https://dl.pstmn.io/download/latest/linux64) && sudo mv /tmp/Postman /opt/

  echo "Creating .desktop file..."
  sudo tee -a /usr/share/applications/postman.desktop << END
[Desktop Entry]
Encoding=UTF-8
Name=Postman
Exec=/opt/Postman/Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
END

  echo "Installation completed successfully."
}

##-------------------------------------------------------------------------##

main "$@"
exit
