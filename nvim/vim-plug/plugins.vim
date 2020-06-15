" neovim settings - plugin install list
" --------------------------------------

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" git command
Plug 'tpope/vim-fugitive'

" enable multi cursor
Plug 'terryma/vim-multiple-cursors'

" file tree viewer
Plug 'scrooloose/nerdtree'

" support comment
Plug 'scrooloose/nerdcommenter'

" status line
Plug 'vim-airline/vim-airline'

" status line themes
Plug 'vim-airline/vim-airline-themes'

" tag bar (ctags)
Plug 'majutsushi/tagbar'

" Themes
Plug 'dracula/vim'
Plug 'w0ng/vim-hybrid'

" CPP Plugin
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

" Language Server Protocol
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

" Change working dir to root
Plug 'airblade/vim-rooter'

" Icons
Plug 'ryanoasis/vim-devicons'

" Snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()
