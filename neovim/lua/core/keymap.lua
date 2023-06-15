-- Change Leader key to a <SPACE BAR>
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Common keymap options
--  * non-recursive-map
--  * silent
local opts = { noremap = true, silent = true }

-- Shorten function name (global mappings)
local keymap = vim.api.nvim_set_keymap

-- [Modes]
--  n : normal
--  v : visual and select
--  s : select
--  x : visual
--  i : insert

--#######################
-- [Normal Mode Mapping]
--#######################

-- [Window Navigation]
--  Ctrl + h : move to left
--  Ctrl + j : move to down
--  Ctrl + k : move to up
--  Ctrl + l : move to right
keymap('n', "<C-h>", "<C-w>h", opts)
keymap('n', "<C-j>", "<C-w>j", opts)
keymap('n', "<C-k>", "<C-w>k", opts)
keymap('n', "<C-l>", "<C-w>l", opts)

-- [Window Resizing]
--  Ctrl + Up   : expand to up
--  Ctrl + Down : expand to down
--  Ctrl + Left : expand to left
--  Ctrl + Right: expand to right
keymap('n', "<C-Up>", ":resize +2<CR>",             opts)
keymap('n', "<C-Down>", ":resize -2<CR>",           opts)
keymap('n', "<C-Left>", ":vertical resize +2<CR>",  opts)
keymap('n', "<C-Right>", ":vertical resize -2<CR>", opts)

-- [Buffer Navigation]
--  Shift + l : move to right buffer
--  Shift + h : move to left buffer 
keymap('n', "<S-l>", ":bnext<CR>", opts)
keymap('n', "<S-h>", ":bprevious<CR>", opts)

-- Clear search highlighting
--  <leader> + c
keymap('n', "<leader>c", ":nohl<CR>", opts)

--#######################
-- [Plugin Mapping]
--#######################

-- Lazygit
keymap('n', "<learder>l", "<cmd>lua _lazygit_toggle()<CR>", opts)

-- Htop
keymap('n', "<learder>ht", "<cmd>lua _htop_toggle()<CR>", opts)

-- Refresh Neovim
keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', opts)

-- NvimTree
--  <leader> + e : Open NvimTree
--  <leader> + f : Refresh NvimTree
--  <leader> + n : search NvimTree
keymap('n', "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap('n', '<leader>f', ':NvimTreeFocus<CR>', opts)
keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', opts)

-- Tagbar
--  <leader> + z : Open/Close
keymap('n', "<leader>z", ":TagbarToggle<CR>", opts)

-- Telescope
--  Ctrl + p : File files
--  Ctrl + f : Find string
keymap('n', "<C-p>", ":Telescope find_files<CR>", opts)
keymap('n', "<C-f>", ":Telescope grep_string<CR>", opts)
