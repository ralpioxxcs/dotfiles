# dotfiles
dotfiles is the repository for setting developing environment.

## System requisite
* Ubuntu 18.04 LTS
* Gnome environment

## Supported dotfiles
* zsh, oh-my-zsh
* Neovim
* Tmux
* Git

## How to apply
Just execute **configure.sh** shell script
```Bash
$ chmod + configure.sh
$ ./configure.sh
```

### coc-nvim
* :CocInstall coc-emoji coc-explorer coc-json coc-lists coc-marketplace
* :CocInstall coc-pairs coc-prettier coc-python coc-sh coc-snippets 
* :CocInstall coc-tsserver coc-yank
