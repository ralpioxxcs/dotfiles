# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
HIST_STAMPS="mm/dd/yyyy"

# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(
  git 
  gitfast 
  last-working-dir 
  common-aliases 
  zsh-autosuggestions
  zsh-syntax-highlighting 
  history-substring-search
  fzf
  docker
  docker-compose
)

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Bat
export BAT_THEME="Dracula"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
