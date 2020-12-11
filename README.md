# dotfiles
dotfiles is the repository for setting developing environment.

## requisite package
* zsh, [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
* neovim
* [Bat](https://github.com/sharkdp/bat)

## Supported dotfiles
* bash
* neovim
* tmux
* git

## How to apply
Just execute **config.sh** shell script
```Bash
$ chmod + config.sh
$ ./config.sh
```

### coc-nvim
* :CocInstall coc-emoji coc-explorer coc-json coc-lists coc-marketplace
* :CocInstall coc-pairs coc-prettier coc-python coc-sh coc-snippets 
* :CocInstall coc-tsserver coc-yank
