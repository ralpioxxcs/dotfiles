set nocompatible

"---------[Plugins]----------
filetype off
set rtp+=~/.vim
set rtp+=~/.vim/bundle/Vundle.vim

" Plugin Install List (Vundle)
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'		" git
Plugin 'Tagbar'				" show tag
Plugin 'scrooloose/nerdtree'		" file explorer
Plugin 'scrooloose/nerdcommenter'	" comment
Plugin 'scrooloose/syntastic' 		" check syntax error
Plugin 'vim-airline/vim-airline'	" status bar
Plugin 'ctrlpvim/ctrlp.vim'		" file explorer
Plugin 'dracula/vim'			" vim theme
Plugin 'octol/vim-cpp-enhanced-highlight' " syntax highlighting
Plugin 'ervandew/supertab'		" <Tab> auto complete
call vundle#end()
filetype plugin indent on
"-----------------------------

"------[Vim Setting]--------
set ruler
set showcmd
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set copyindent
set autoindent
set showmatch
set smarttab
set incsearch
set nowrapscan
set hlsearch

hi search ctermbg=3
set wrap
set encoding=utf-8
set fileencoding=utf-8
set number
set cursorline
set visualbell
set splitbelow
"------------------------

"-----[Vim Setting2]-----
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let mapleader=","           "set hotkey
"clip board key ( Ctrl+C , Ctrl+V )
noremap <Leader>y "+y       
noremap <Leader>p "+p

noremap j gj
noremap k gk
nmap <tab> %
vmap <tab> %



"-------[ Themes ] --------
syntax on
set t_Co=256
let g:dracula_colorterm= 0
colorschem dracula
"--------------------------

"-------[ Plugin - Tagbar ] ---------
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tabar_autoclose=0
let g:tabar_autofocus=1
"let g:tagbar_ballon=1
noremap <F8> :TagbarToggle<CR>


"-------[ Plugin - NERDTree ] ---------
" Vim 으로 폴더를 열때만 NERDTree 자동실행
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" 단축어 설정
noremap <F9> :NERDTree<CR>
noremap nerd :NERDTreeToggle<CR>

"-------[ Plugin - vim-cpp-enhanced-highlight ] ----------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1


"-------[ Plugin - supertab ] ----------
let g:SuperTabDefaultCompletionType = '<c-n>'
let g:SUperTabCrMapping=1
