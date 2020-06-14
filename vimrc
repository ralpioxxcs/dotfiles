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
"Plugin 'ervandew/supertab'		" <Tab> auto complete
"Plugin 'Valloric/YouCompleteMe' " auto completion 
"Plugin 'rdnetto/YCM-Generator' " .ycm_extra_conf.py file generator
Plugin 'rhysd/vim-clang-format' " text indent clang format
Plugin 'junegunn/fzf', { 'do': { -> fzf#install()}}
Plugin 'junegunn/fzf.vim'
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

set clipboard=unnamedplus "set system clipboard

noremap j gj
noremap k gk
nmap <tab> %
vmap <tab> %

nnoremap B ^
nnoremap E $


"-------[ Themes ] --------
syntax on
set t_Co=256
let g:dracula_italic = 0
let g:dracula_colorterm= 0
colorschem dracula
highlight Normal ctermbg=None
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

"-------[ Plugin - Commenter ] ---------
let g:NERDSpaceDelims = 1    " 주석처리 이후 Space 추가
let g:NERDCompactSexyComs = 1 " 다중 주석처리용 compact syntax
let g:NERDDefaultAlign = 'left'
let g:NERDToggleCheckAllLines = 1

"-------[ Plugin - vim-cpp-enhanced-highlight ] ----------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

"-------[ Plugin - vim-cpp-enhanced-highlight ] ----------
let g:clang_format#code_style = 'google'

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" "-------[ Plugin - supertab ] ----------
" let g:SuperTabDefaultCompletionType = '<c-n>'
" let g:SUperTabCrMapping=1

"-------[ Plugin - YouCompleteMe ] ----------

let g:ycm_global_ycm_extra_conf = '/home/hong/.vim/bundle/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0  " 1 설정 시, 파일 열때마다 ycm_extra_conf.py 로드 ask
let g:ycm_extra_conf_globlist = []
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_auto_trigger = 0
let g:ycm_python_binary_path = '/usr/bin/python3'

nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>gg :YcmCompleter GoToImprecise<CR>
nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>p :YcmCompleter GetParent<CR>
