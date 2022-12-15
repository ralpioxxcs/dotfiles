-- Common keymap options
local opts = { noremap = true, silent = true } 	

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "                      -- change leader to a comma
vim.g.maplocalleader = " "

-- [Normal Mode]
-- Window navigation 
-- Ctrl + (h,j,k,l)
keymap('n', "<C-h>", "<C-w>h", opts)
keymap('n', "<C-j>", "<C-w>j", opts)
keymap('n', "<C-k>", "<C-w>k", opts)
keymap('n', "<C-l>", "<C-w>l", opts)

-- Window resizing
keymap('n', "<C-Up>", ":resize +2<CR>", opts)
keymap('n', "<C-Down>", ":resize -2<CR>", opts)
keymap('n', "<C-Left>", ":vertical resize +2<CR>", opts)
keymap('n', "<C-Right>", ":vertical resize -2<CR>", opts)

-- Buffer navigation
keymap('n', "<S-l>", ":bnext<CR>", opts)
keymap('n', "<S-h>", ":bprevious<CR>", opts)

keymap('i', "jk", "<ESC>", opts)

-- [Visual Mode]
-- Move text indent
keymap('v', "<", "<gv", opts)
keymap('v', ">", ">gv", opts)
-- Move text Up&Down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- File explorer shorcut
keymap('n', "<leader>e", ":NvimTreeToggle<CR>", opts)
