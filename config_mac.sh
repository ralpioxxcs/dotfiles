#!/bin/bash

#########################
# Colors
COLOR_NONE='\033[0m'
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_CYAN='\033[0;36m'
COLOR_DARK_GRAY='\033[1;30m'
COLOR_YELLOW='\033[1;33m'

#########################
## Runtime variables
sudoPW=""
spin='-\|/'

################################################################

################
## Entrypoint ##
################
main() {
  check_macos_prereqs
  check_prerequisite_packages

  while true; do
    clear
    echo "#################################"
    echo "#   macOS Dotfiles Installer    #"
    echo "#################################"
    echo ""
    echo "# Select categories to install"
    echo "[1] Terminal Utils"
    echo "[2] Editors"
    echo "[3] Languages"
    echo "[4] Tools"
    echo "[5] Exit"
    read -p "Enter number: " ans

    case "$ans" in
      1) terminal ;;
      2) editors ;;
      3) languages ;;
      4) tools ;;
      5) exit 0 ;;
      *) echo "Please enter a valid number." && sleep 2 ;;
    esac
  done
}

##########################################
################ util ####################
##########################################

# macOS 필수 구성 요소 (Xcode Command Line Tools, Homebrew) 확인 및 설치
check_macos_prereqs() {
  # 1. Xcode Command Line Tools 확인
  if ! xcode-select -p &>/dev/null; then
    echo -e "${COLOR_YELLOW}Xcode Command Line Tools not found. Installing...${COLOR_NONE}"
    xcode-select --install
    echo -e "${COLOR_GREEN}Please follow the on-screen instructions to complete the installation.${COLOR_NONE}"
    read -p "Press [Enter] to continue after installation is complete..."
  fi

  # 2. Homebrew 확인
  if ! command -v brew &>/dev/null; then
    echo -e "${COLOR_YELLOW}Homebrew not found. Installing...${COLOR_NONE}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Apple Silicon과 Intel Mac의 경로를 모두 처리
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    echo -e "${COLOR_GREEN}Homebrew installation complete.${COLOR_NONE}"
  else
    echo -e "${COLOR_GREEN}Homebrew is already installed. Updating...${COLOR_NONE}"
    brew update
  fi
}

check_prerequisite_packages() {
  prerequsite_packages=(
    "wget"
    "curl"
    "lua"
    "htop"
    "vim"
    "ripgrep"
    "exa"
    "jq"
  )
  echo "Checking & installing pre-requisite packages..."

  brew_install_wrapper "${prerequsite_packages[@]}" >/dev/null 2>&1 &
  spinner
  echo -e "${COLOR_GREEN}Done.${COLOR_NONE}"
}

check_package_installed() {
  local pkgName=${1}
  local is_cask=${2:-false}

  if [[ "$is_cask" == "true" ]]; then
    if brew list --cask "$pkgName" &>/dev/null; then
      retVal="True"
    else
      retVal="False"
    fi
  else
    if brew list "$pkgName" &>/dev/null; then
      retVal="True"
    else
      retVal="False"
    fi
  fi
}

brew_install_wrapper() {
  local packages_to_install=()
  for pkg in "$@"; do
    check_package_installed "$pkg"
    if [[ "$retVal" == "False" ]]; then
      packages_to_install+=("$pkg")
    fi
  done

  if [ ${#packages_to_install[@]} -gt 0 ]; then
    brew install "${packages_to_install[@]}"
  fi
}

brew_cask_install_wrapper() {
  local casks_to_install=()
  for cask in "$@"; do
    check_package_installed "$cask" true
    if [[ "$retVal" == "False" ]]; then
      casks_to_install+=("$cask")
    fi
  done

  if [ ${#casks_to_install[@]} -gt 0 ]; then
    brew install --cask "${casks_to_install[@]}"
  fi
}

pip_install_wrapper() {
  pip3 install "$@"
}

custom_install_wrapper() {
  for cmd in "$@"; do
    eval "${cmd}"
  done
}

spinner() {
  local pid=$!
  while kill -0 $pid 2>/dev/null; do
    printf "."
    sleep .1
  done
  echo
}

################################################################
#
# Installation Menus
#
terminal() {
  while true; do
    clear
    echo "--- Terminal Utils ---"
    echo "[1] Zsh & Oh My Zsh"
    echo "[2] Tmux"
    echo "[3] Lazy tools (lazygit, lazydocker)"
    echo "[4] GitHub tools (gh)"
    echo "[5] Alacritty"
    echo "[6] ${COLOR_DARK_GRAY}Back to main menu${COLOR_NONE}"
    read -p "Enter number: " ans

    case "$ans" in
      1) install_zsh ;;
      2) install_tmux ;;
      3) install_lazygit && install_lazydocker ;;
      4) install_github_tools ;;
      5) install_alacritty ;;
      6) break ;;
      *) echo "Please enter a valid number." && sleep 2 ;;
    esac
  done
}

editors() {
  while true; do
    clear
    echo "--- Editors ---"
    echo "[1] Neovim"
    echo "[2] Visual Studio Code"
    echo "[3] ${COLOR_DARK_GRAY}Back to main menu${COLOR_NONE}"
    read -p "Enter number: " ans

    case "$ans" in
      1) install_neovim ;;
      2) install_vscode ;;
      3) break ;;
      *) echo "Please enter a valid number." && sleep 2 ;;
    esac
  done
}

languages() {
  while true; do
    clear
    echo "--- Languages ---"
    echo "[1] Golang"
    echo "[2] Rust"
    echo "[3] Node (via nvm)"
    echo "[4] ${COLOR_DARK_GRAY}Back to main menu${COLOR_NONE}"
    read -p "Enter number: " ans

    case "$ans" in
      1) install_golang ;;
      2) install_rust ;;
      3)
        read -p "Which version of Node do you want to install? (e.g., --lts, 20): " nodeVersion
        install_node "${nodeVersion}"
        ;;
      4) break ;;
      *) echo "Please enter a valid number." && sleep 2 ;;
    esac
  done
}

tools() {
  while true; do
    clear
    echo "--- Tools ---"
    echo "[1] Postman"
    echo "[2] Obsidian"
    echo "[3] ${COLOR_DARK_GRAY}Back to main menu${COLOR_NONE}"
    read -p "Enter number: " ans

    case "$ans" in
      1) install_postman ;;
      2) install_obsidian ;;
      3) break ;;
      *) echo "Please enter a valid number." && sleep 2 ;;
    esac
  done
}

################################################################
# Installation Functions
################################################################

install_neovim() {
  printf "Installing neovim..."
  brew_install_wrapper "neovim" >/dev/null 2>&1 &
  spinner

  if [ -d "${HOME}/.config/nvim" ]; then
    read -p "Neovim config directory already exists. Replace it? [y/N] " yn
    case $yn in
      [Yy]*)
        echo "Backing up existing config to ~/.config/nvim.bak"
        mv "${HOME}/.config/nvim" "${HOME}/.config/nvim.bak"
        rsync -azvh neovim/* "${HOME}/.config/nvim"
        echo "Running ':Lazy install'..."
        nvim --headless -c "Lazy! install" -c "qa"
        ;;
      *) echo "Skipping config setup." ;;
    esac
  else
    mkdir -p "${HOME}/.config/"
    rsync -azvh neovim/* "${HOME}/.config/nvim"
    echo "Running ':Lazy install'..."
    nvim --headless -c "Lazy! install" -c "qa"
  fi

  printf "Installing dependencies (ctags, python)..."
  brew_install_wrapper "ctags" "python" >/dev/null 2>&1 &
  spinner
  pip_install_wrapper "cmake-language-server" "pynvim"

  echo -e "${COLOR_GREEN}Neovim setup complete.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_zsh() {
  # macOS 기본 셸이 zsh이지만, Homebrew로 최신 버전을 설치
  printf "Installing latest zsh via Homebrew..."
  brew_install_wrapper "zsh" >/dev/null 2>&1 &
  spinner

  # Homebrew Zsh를 기본 셸로 설정
  local brew_zsh_path
  brew_zsh_path=$(brew --prefix)/bin/zsh
  if ! grep -q "$brew_zsh_path" /etc/shells; then
    echo "Adding Homebrew Zsh to /etc/shells..."
    echo "$brew_zsh_path" | sudo tee -a /etc/shells
  fi
  if [[ "$SHELL" != "$brew_zsh_path" ]]; then
    echo "Changing default shell to Homebrew Zsh. You may need to enter your password."
    chsh -s "$brew_zsh_path"
    echo -e "${COLOR_YELLOW}Shell changed. Please restart your terminal for it to take effect.${COLOR_NONE}"
  fi

  # oh-my-zsh 설치
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    printf "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended >/dev/null 2>&1 &
    spinner
  else
    echo -e "${COLOR_GREEN}Oh My Zsh is already installed.${COLOR_NONE}"
  fi

  # zshrc, aliases 복사
  echo "Copying .zshrc and .aliases..."
  cp -av zshrc "${HOME}/.zshrc"
  cp -av aliases "${HOME}/.aliases"

  # oh-my-zsh 플러그인 설치
  echo "Installing oh-my-zsh plugins..."
  ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
  custom_install_wrapper \
    'git clone --depth=1 https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM}/plugins/zsh-completions' \
    'git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting' \
    'git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions' \
    'git clone --depth=1 https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM}/plugins/fzf-tab' \
    'git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git ${ZSH_CUSTOM}/themes/spaceship-prompt' \
    >/dev/null 2>&1
    
  # spaceship 테마 심볼릭 링크 생성 (오류 방지를 위해 -f 옵션 추가)
  ln -sf "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme"

  # fzf 설치
  if [ ! -d "${HOME}/.fzf" ]; then
      printf "Installing fzf..."
      git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf >/dev/null 2>&1
      ~/.fzf/install --all >/dev/null 2>&1 &
      spinner
  fi
  
  read -p "Do you want to install Nerd Fonts (FiraCode)? [y/N] " yn
  case $yn in
    [Yy]*)
      echo "Installing Nerd Fonts via Homebrew..."
      brew tap homebrew/cask-fonts
      brew_cask_install_wrapper "font-fira-code-nerd-font" >/dev/null 2>&1 &
      spinner
      echo -e "${COLOR_GREEN}Nerd Font installed. Please set it in your terminal preferences.${COLOR_NONE}"
      ;;
    *) echo "Skipping Nerd Font installation." ;;
  esac
  
  echo -e "${COLOR_GREEN}Zsh setup complete.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_tmux() {
  printf "Installing tmux..."
  brew_install_wrapper "tmux" >/dev/null 2>&1 &
  spinner

  local file=".tmux.conf"
  if [ -f "${HOME}/${file}" ]; then
    read -p "${file} already exists. Overwrite it? [y/N] " yn
    case $yn in
      [Yy]*) cp -v tmux.conf "${HOME}/.tmux.conf" ;;
      *) echo "Skipping config copy." ;;
    esac
  else
    cp -v tmux.conf "${HOME}/.tmux.conf"
  fi

  if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
      echo "Installing Tmux Plugin Manager (tpm)..."
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm >/dev/null 2>&1
      echo "To finish, open tmux and press 'Prefix + I' to install plugins."
  else
      echo "TPM already installed."
  fi
  
  echo -e "${COLOR_GREEN}Tmux setup complete.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_github_tools() {
  printf "Installing GitHub CLI (gh)..."
  brew_install_wrapper "gh" >/dev/null 2>&1 &
  spinner
  echo -e "${COLOR_GREEN}gh has been installed.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_alacritty() {
  printf "Installing Alacritty..."
  brew_cask_install_wrapper "alacritty" >/dev/null 2>&1 &
  spinner
  echo -e "${COLOR_GREEN}Alacritty has been installed.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_lazygit() {
  printf "Installing lazygit..."
  brew_install_wrapper "lazygit" >/dev/null 2>&1 &
  spinner

  if [ ! -d "${HOME}/.config/lazygit" ]; then
    mkdir -p "${HOME}/.config/lazygit"
  fi
  cp -av lazygit.yml "${HOME}/.config/lazygit/config.yml"
  echo -e "${COLOR_GREEN}lazygit has been installed and configured.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_lazydocker() {
  printf "Installing lazydocker..."
  brew install jesseduffield/lazydocker/lazydocker >/dev/null 2>&1 &
  spinner
  echo -e "${COLOR_GREEN}lazydocker has been installed.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_node() {
  local version=${1:-"--lts"} # 기본값으로 lts 버전 설치
  
  echo "Installing nvm (Node Version Manager)..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  # nvm 환경 변수 로드
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

  echo "Installing Node.js version: ${version}"
  nvm install "${version}"
  nvm use "${version}"
  nvm alias default "${version}"
  
  echo -e "${COLOR_GREEN}Node.js setup via nvm is complete.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_rust() {
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "${HOME}/.cargo/env"
  echo -e "${COLOR_GREEN}Rust installation is complete.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_golang() {
  printf "Installing Golang..."
  brew_install_wrapper "go" >/dev/null 2>&1 &
  spinner

  mkdir -p "${HOME}/go"
  echo "GOPATH will be set to ~/go"
  echo -e "${COLOR_GREEN}Golang installation is complete.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_postman() {
  printf "Installing Postman..."
  brew_cask_install_wrapper "postman" >/dev/null 2>&1 &
  spinner
  echo -e "${COLOR_GREEN}Postman has been installed.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_obsidian() {
  printf "Installing Obsidian..."
  brew_cask_install_wrapper "obsidian" >/dev/null 2>&1 &
  spinner
  echo -e "${COLOR_GREEN}Obsidian has been installed.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

install_vscode() {
  printf "Installing Visual Studio Code..."
  brew_cask_install_wrapper "visual-studio-code" >/dev/null 2>&1 &
  spinner
  echo -e "${COLOR_GREEN}Visual Studio Code has been installed.${COLOR_NONE}"
  read -p "Press [Enter] to continue..."
}

##-------------------------------------------------------------------------##

main "$@"
exit 0
