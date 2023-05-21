
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

-- Alt + j : move text to up
-- Alt + k : move text to down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- File explorer
keymap('n', "<leader>e", ":NvimTreeToggle<CR>", opts)
----------------------------------------------------------

----------------------------------------------------------
-- [Insert Mode]
--

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

