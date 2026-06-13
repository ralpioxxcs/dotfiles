#!/bin/bash

################################################################
# macOS Dotfiles Installer (gum TUI)
################################################################

# gum 테마 색상 (Nord 계열)
CLR_PRIMARY=110   # blue
CLR_OK=108        # green
CLR_WARN=179      # yellow
CLR_ERR=167       # red
CLR_MUTED=243     # gray

################################################################
## UI helpers (gum)
################################################################

title() {
  gum style --border double --align center --width 50 --margin "1 0" --padding "0 2" \
    --foreground "$CLR_PRIMARY" --border-foreground "$CLR_PRIMARY" "$@"
}

ok()   { gum style --foreground "$CLR_OK"    "✓ $*"; }
warn() { gum style --foreground "$CLR_WARN"  "! $*"; }
err()  { gum style --foreground "$CLR_ERR"   "✗ $*"; }
info() { gum style --foreground "$CLR_PRIMARY" "› $*"; }

pause() { gum input --placeholder "Press Enter to continue..." >/dev/null 2>&1; }

# gum spin 래퍼: 메시지 + 실제 명령 (실 바이너리만 — bash 함수는 보이지 않음)
spin() {
  local msg="$1"; shift
  gum spin --spinner dot --title "$msg" -- "$@"
}

################
## Entrypoint ##
################
main() {
  check_macos_prereqs
  check_prerequisite_packages

  while true; do
    clear
    title "macOS Dotfiles Installer"
    local choice
    choice=$(gum choose --header "Select a category" \
      "Terminal Utils" "Editors" "Languages" "Tools" "Exit")

    case "$choice" in
      "Terminal Utils") terminal ;;
      "Editors")        editors ;;
      "Languages")      languages ;;
      "Tools")          tools ;;
      "Exit"|"")        exit 0 ;;
    esac
  done
}

##########################################
################ util ####################
##########################################

# macOS 필수 구성 요소 (Xcode CLT, Homebrew, gum) 확인 및 설치
check_macos_prereqs() {
  # gum 부트스트랩 전이라 plain echo 사용
  # 1. Xcode Command Line Tools
  if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
    echo "Follow the on-screen instructions, then press [Enter]."
    read -r
  fi

  # 2. Homebrew
  if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x "/opt/homebrew/bin/brew" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x "/usr/local/bin/brew" ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
    echo "Homebrew installation complete."
  fi

  # 3. gum (이후 모든 UI가 의존)
  if ! command -v gum &>/dev/null; then
    echo "Installing gum (TUI toolkit)..."
    brew install gum
  fi
}

check_prerequisite_packages() {
  local prerequsite_packages=(wget curl lua htop vim ripgrep eza jq)
  brew_install_wrapper "${prerequsite_packages[@]}"
}

check_package_installed() {
  local pkgName=${1}
  local is_cask=${2:-false}

  if [[ "$is_cask" == "true" ]]; then
    brew list --cask "$pkgName" &>/dev/null && retVal="True" || retVal="False"
  else
    brew list "$pkgName" &>/dev/null && retVal="True" || retVal="False"
  fi
}

brew_install_wrapper() {
  local packages_to_install=()
  for pkg in "$@"; do
    check_package_installed "$pkg"
    [[ "$retVal" == "False" ]] && packages_to_install+=("$pkg")
  done

  if [ ${#packages_to_install[@]} -gt 0 ]; then
    spin "Installing: ${packages_to_install[*]}" brew install "${packages_to_install[@]}"
    ok "Installed: ${packages_to_install[*]}"
  else
    ok "Already installed: $*"
  fi
}

brew_cask_install_wrapper() {
  local casks_to_install=()
  for cask in "$@"; do
    check_package_installed "$cask" true
    [[ "$retVal" == "False" ]] && casks_to_install+=("$cask")
  done

  if [ ${#casks_to_install[@]} -gt 0 ]; then
    spin "Installing (cask): ${casks_to_install[*]}" brew install --cask "${casks_to_install[@]}"
    ok "Installed: ${casks_to_install[*]}"
  else
    ok "Already installed: $*"
  fi
}

pip_install_wrapper() {
  spin "pip install: $*" pip3 install "$@"
}

################################################################
# Installation Menus
################################################################

terminal() {
  while true; do
    clear
    title "Terminal Utils"
    local choice
    choice=$(gum choose --header "Select to install (Esc = back)" \
      "Zsh & Oh My Zsh" \
      "Fish (fisher, starship)" \
      "Tmux" \
      "Lazy tools (lazygit, lazydocker)" \
      "GitHub tools (gh)" \
      "Alacritty" \
      "← Back")

    case "$choice" in
      "Zsh"*)       install_zsh ;;
      "Fish"*)      install_fish ;;
      "Tmux")       install_tmux ;;
      "Lazy"*)      install_lazygit && install_lazydocker ;;
      "GitHub"*)    install_github_tools ;;
      "Alacritty")  install_alacritty ;;
      "← Back"|"")  break ;;
    esac
  done
}

editors() {
  while true; do
    clear
    title "Editors"
    local choice
    choice=$(gum choose --header "Select to install (Esc = back)" \
      "Neovim" "Visual Studio Code" "← Back")

    case "$choice" in
      "Neovim")             install_neovim ;;
      "Visual Studio Code") install_vscode ;;
      "← Back"|"")          break ;;
    esac
  done
}

languages() {
  while true; do
    clear
    title "Languages"
    local choice
    choice=$(gum choose --header "Select to install (Esc = back)" \
      "Golang" "Rust" "Node (via nvm)" "← Back")

    case "$choice" in
      "Golang") install_golang ;;
      "Rust")   install_rust ;;
      "Node (via nvm)")
        local nodeVersion
        nodeVersion=$(gum input --prompt "Node version: " --placeholder "e.g. --lts, 20")
        install_node "${nodeVersion}"
        ;;
      "← Back"|"") break ;;
    esac
  done
}

tools() {
  while true; do
    clear
    title "Tools"
    local choice
    choice=$(gum choose --header "Select to install (Esc = back)" \
      "Postman" "Obsidian" "← Back")

    case "$choice" in
      "Postman")   install_postman ;;
      "Obsidian")  install_obsidian ;;
      "← Back"|"") break ;;
    esac
  done
}

################################################################
# Installation Functions
################################################################

install_neovim() {
  brew_install_wrapper "neovim"

  if [ -d "${HOME}/.config/nvim" ]; then
    if gum confirm "Neovim config already exists. Replace it?"; then
      info "Backing up existing config to ~/.config/nvim.bak"
      rm -rf "${HOME}/.config/nvim.bak"
      mv "${HOME}/.config/nvim" "${HOME}/.config/nvim.bak"
      rsync -azh neovim/* "${HOME}/.config/nvim"
      spin "Running ':Lazy install'" nvim --headless -c "Lazy! install" -c "qa"
    else
      warn "Skipping config setup."
    fi
  else
    mkdir -p "${HOME}/.config/"
    rsync -azh neovim/* "${HOME}/.config/nvim"
    spin "Running ':Lazy install'" nvim --headless -c "Lazy! install" -c "qa"
  fi

  brew_install_wrapper "ctags" "python"
  pip_install_wrapper "cmake-language-server" "pynvim"

  ok "Neovim setup complete."
  pause
}

install_zsh() {
  brew_install_wrapper "zsh"

  # Homebrew zsh를 기본 셸로 설정
  local brew_zsh_path
  brew_zsh_path=$(brew --prefix)/bin/zsh
  if ! grep -q "$brew_zsh_path" /etc/shells; then
    info "Adding Homebrew Zsh to /etc/shells..."
    echo "$brew_zsh_path" | sudo tee -a /etc/shells >/dev/null
  fi
  if [[ "$SHELL" != "$brew_zsh_path" ]]; then
    info "Changing default shell to Homebrew Zsh (password may be required)."
    chsh -s "$brew_zsh_path"
    warn "Shell changed. Restart terminal to take effect."
  fi

  # oh-my-zsh
  if [ ! -d "${HOME}/.oh-my-zsh" ]; then
    spin "Installing oh-my-zsh" bash -c \
      'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
  else
    ok "oh-my-zsh already installed."
  fi

  info "Copying .zshrc and .aliases..."
  cp -a zshrc "${HOME}/.zshrc"
  cp -a aliases "${HOME}/.aliases"

  # oh-my-zsh 플러그인
  local ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
  local plugins=(
    "https://github.com/zsh-users/zsh-completions.git|${ZSH_CUSTOM}/plugins/zsh-completions"
    "https://github.com/zsh-users/zsh-syntax-highlighting.git|${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
    "https://github.com/zsh-users/zsh-autosuggestions|${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
    "https://github.com/Aloxaf/fzf-tab|${ZSH_CUSTOM}/plugins/fzf-tab"
    "https://github.com/spaceship-prompt/spaceship-prompt.git|${ZSH_CUSTOM}/themes/spaceship-prompt"
  )
  for p in "${plugins[@]}"; do
    local url="${p%%|*}" dst="${p##*|}"
    [ -d "$dst" ] || spin "Cloning $(basename "$dst")" git clone --depth=1 "$url" "$dst"
  done
  ln -sf "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM}/themes/spaceship.zsh-theme"

  # fzf
  if [ ! -d "${HOME}/.fzf" ]; then
    spin "Installing fzf" git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
    spin "Configuring fzf" "${HOME}/.fzf/install" --all
  fi

  if gum confirm "Install Nerd Fonts (FiraCode)?"; then
    brew_cask_install_wrapper "font-fira-code-nerd-font"
    ok "Nerd Font installed. Set it in your terminal preferences."
  else
    warn "Skipping Nerd Font installation."
  fi

  ok "Zsh setup complete."
  pause
}

install_fish() {
  # fish + 의존 도구 (starship 프롬프트, zoxide, eza, fzf)
  brew_install_wrapper "fish" "starship" "zoxide" "eza" "fzf"

  # fish를 기본 셸로 설정
  local brew_fish_path
  brew_fish_path=$(brew --prefix)/bin/fish
  if ! grep -q "$brew_fish_path" /etc/shells; then
    info "Adding fish to /etc/shells..."
    echo "$brew_fish_path" | sudo tee -a /etc/shells >/dev/null
  fi
  if [[ "$SHELL" != "$brew_fish_path" ]]; then
    info "Changing default shell to fish (password may be required)."
    chsh -s "$brew_fish_path"
    warn "Shell changed. Restart terminal to take effect."
  fi

  # fish 설정 복사 (config, conf.d, completions, plugin 목록)
  info "Copying fish configuration..."
  mkdir -p "${HOME}/.config/fish/conf.d" "${HOME}/.config/fish/completions"
  cp -a fish/config.fish "${HOME}/.config/fish/config.fish"
  cp -a fish/fish_plugins "${HOME}/.config/fish/fish_plugins"
  rsync -azh fish/conf.d/ "${HOME}/.config/fish/conf.d/"
  rsync -azh fish/completions/ "${HOME}/.config/fish/completions/"

  # fisher 설치 후 fish_plugins 기반으로 플러그인 복원 (fzf.fish, nvm.fish 등)
  spin "Installing fisher and plugins" fish -c \
    'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher >/dev/null 2>&1; fisher update'

  ok "Fish setup complete."
  pause
}

install_tmux() {
  brew_install_wrapper "tmux"

  if [ -f "${HOME}/.tmux.conf" ]; then
    if gum confirm ".tmux.conf already exists. Overwrite it?"; then
      cp tmux.conf "${HOME}/.tmux.conf" && ok "Copied .tmux.conf"
    else
      warn "Skipping config copy."
    fi
  else
    cp tmux.conf "${HOME}/.tmux.conf" && ok "Copied .tmux.conf"
  fi

  if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
    spin "Installing TPM" git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
    info "Open tmux and press 'Prefix + I' to install plugins."
  else
    ok "TPM already installed."
  fi

  ok "Tmux setup complete."
  pause
}

install_github_tools() {
  brew_install_wrapper "gh"
  ok "gh has been installed."
  pause
}

install_alacritty() {
  brew_cask_install_wrapper "alacritty"
  ok "Alacritty has been installed."
  pause
}

install_lazygit() {
  brew_install_wrapper "lazygit"
  mkdir -p "${HOME}/.config/lazygit"
  cp -a lazygit.yml "${HOME}/.config/lazygit/config.yml"
  ok "lazygit installed and configured."
  pause
}

install_lazydocker() {
  spin "Installing lazydocker" brew install jesseduffield/lazydocker/lazydocker
  ok "lazydocker has been installed."
  pause
}

install_node() {
  local version=${1:-"--lts"}

  info "Installing nvm (Node Version Manager)..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

  info "Installing Node.js version: ${version}"
  nvm install "${version}"
  nvm use "${version}"
  nvm alias default "${version}"

  ok "Node.js setup via nvm complete."
  pause
}

install_rust() {
  info "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "${HOME}/.cargo/env"
  ok "Rust installation complete."
  pause
}

install_golang() {
  brew_install_wrapper "go"
  mkdir -p "${HOME}/go"
  info "GOPATH will be set to ~/go"
  ok "Golang installation complete."
  pause
}

install_postman() {
  brew_cask_install_wrapper "postman"
  ok "Postman has been installed."
  pause
}

install_obsidian() {
  brew_cask_install_wrapper "obsidian"
  ok "Obsidian has been installed."
  pause
}

install_vscode() {
  brew_cask_install_wrapper "visual-studio-code"
  ok "Visual Studio Code has been installed."
  pause
}

##-------------------------------------------------------------------------##

main "$@"
exit 0
