-- Change Leader key to a <SPACE BAR>
vim.g.mapleader = ","
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
--  Ctrl + w + h : move to left
--  Ctrl + w + j : move to down
--  Ctrl + w + k : move to up
--  Ctrl + w + l : move to right

-- [Window Resizing]
--  Ctrl + Up   : expand to up
--  Ctrl + Down : expand to down
--  Ctrl + Left : expand to left
--  Ctrl + Right: expand to right
keymap("n", "<C-k>", ":resize +2<CR>", opts)
keymap("n", "<C-j>", ":resize -2<CR>", opts)
keymap("n", "<C-h>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-l>", ":vertical resize -2<CR>", opts)

-- [Buffer Navigation]
--  Shift + l : move to right buffer
--  Shift + h : move to left buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear search highlighting
--  <leader> + c
keymap("n", "<leader>c", ":nohl<CR>", opts)

--#######################
-- [Plugin Mapping]
--#######################
-- Lazygit
keymap("n", "<learder>l", "<cmd>lua _lazygit_toggle()<CR>", opts)

-- Htop
keymap("n", "<learder>ht", "<cmd>lua _htop_toggle()<CR>", opts)

-- Refresh Neovim
keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", opts)

-- NvimTree
--  <leader> + e : Open NvimTree
--  <leader> + f : Refresh NvimTree
--  <leader> + n : search NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>f", ":NvimTreeFocus<CR>", opts)
keymap("n", "<leader>n", ":NvimTreeFindFile<CR>", opts)

-- Tagbar
--  <leader> + z : Open/Close
keymap("n", "<leader>z", ":TagbarToggle<CR>", opts)

-- Telescope
--  Ctrl + p : File files
--  Ctrl + f : Find string
keymap("n", "<C-p>", ":Telescope find_files path_display='absolute'<CR>", opts)
keymap("n", "<C-f>", ":Telescope live_grep<CR>", opts)
keymap("n", "<C-b>", ":Telescope buffers<CR>", opts)

-- Formatter
-- <leader> + f : Formatting
keymap("n", "<leader>f", ":Format<CR>", opts)
keymap("n", "<leader>F", ":FormatWrite<CR>", opts)

-- GitSigns
-- keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)

-- Vim-doge
keymap("n", "<leader>d", ":DogeGenerate<CR>", opts)

