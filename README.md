# dotfiles
dotfiles is the repository for setting developing environment.

## System requisite
* Ubuntu LTS (16~20)

## Supported dotfiles
* zsh, oh-my-zsh
* neovim
* tmux
* git

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
