
-- Change leader to a <SPACE BAR>
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Common keymap options
local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name (global mappings)
local keymap = vim.api.nvim_set_keymap

-- n : normal
-- x : visual
-- v : visual and select
-- i : insert

----------------------------------------------------------
-- [Normal Mode]

-- [Window navigation]
-- Ctrl + h : move to left
-- Ctrl + j : move to down
-- Ctrl + k : move to up
-- Ctrl + l : move to right
keymap('n', "<C-h>", "<C-w>h", opts)
keymap('n', "<C-j>", "<C-w>j", opts)
keymap('n', "<C-k>", "<C-w>k", opts)
keymap('n', "<C-l>", "<C-w>l", opts)

-- [Window resizing]
--  Ctrl + Up
--  Ctrl + Down
--  Ctrl + Left
--  Ctrl + Right
keymap('n', "<C-Up>", ":resize +2<CR>", opts)
keymap('n', "<C-Down>", ":resize -2<CR>", opts)
keymap('n', "<C-Left>", ":vertical resize +2<CR>", opts)
keymap('n', "<C-Right>", ":vertical resize -2<CR>", opts)

-- [Buffer navigation]
--  Shift + l : right
--  Shift + h : left
keymap('n', "<S-l>", ":bnext<CR>", opts)
keymap('n', "<S-h>", ":bprevious<CR>", opts)

-- Clear search highlighting with <leader> and c
keymap('n', '<leader>c', ':nohl<CR>', opts)

-- Alt + j : move text to up
-- Alt + k : move text to down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)


----------------------------------------------------------

-- Terminal mappings
--  Ctrl - t : Open terminal
--  ESC : Exit terminal
keymap('n', '<C-t>', ':Term<CR>', opts)
keymap('t', '<Esc>', '<C-\\><C-n>', opts)

-- Lazygit
keymap('n', "<learder>l", "<cmd>lua _lazygit_toggle()<CR>", opts)

-- Htop
keymap('n', "<learder>ht", "<cmd>lua _htop_toggle()<CR>", opts)


-- Refresh Neovim
keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', opts)



----------------------------------------------------------
-- [Plugin Keymappings]

-- NvimTree
--  Leader + e : Open
--  Leader + f : Refresh
--  Leader + n : search
keymap('n', "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap('n', '<leader>f', ':NvimTreeRefresh<CR>', opts)
keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', opts)

-- Tagbar
--  Leader + z : Open/Close
keymap('n', "<leader>z", ":TagbarToggle<CR>", opts)

-- Telescope
keymap('n', "<C-f>", ":Telescope find_files<CR>", opts)

----------------------------------------------------------



----------------------------------------------------------
-- [Visual Mode]

-- Move text indent
--keymap('v', "<", "<gv", opts)
--keymap('v', ">", ">gv", opts)

-- Move text Up&Down
--keymap("v", "<A-j>", ":m .+1<CR>==", opts)
--keymap("v", "<A-k>", ":m .-2<CR>==", opts)
----------------------------------------------------------

