"" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
"if (has('nvim'))
"  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
"endif

"" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
"" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
"" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
"if (has('termguicolors'))
"  set termguicolors
"endif

" Dracula Theme
colorscheme dracula
"let g:dracula_bold = 1
"let g:dracula_italic = 1
"let g:dracula_underline = 1
"let g:dracula_undercurl = 1
"let g:dracula_inverse = 1
"let g:dracula_colorterm= 1

"-------------------------------------------------------
" Hybrid Theme
"colorscheme hybrid
"set background=dark

"-------------------------------------------------------
" Base16 (Dark) Theme
"colorscheme base16-ocean
"let base16colorspace=256
"set termguicolors

"-------------------------------------------------------
" Material Theme
"" Dark
"set background=dark
"set termguicolors
"colorscheme vim-material

"" Palenight
"let g:material_style='palenight'
"set background=dark
"colorscheme vim-material

" Oceanic
"let g:material_style='oceanic'
"set background=dark
"colorscheme vim-material

"" Light
"set background=light
"colorscheme vim-material
