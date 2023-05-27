-- Editor settings
-- vim.opt : set global, window, buffer settings

----------------------------------------------------------------------------------------------------------------
-- [Indentation]

-- New lines inherit the indentation of previous lines
vim.opt.autoindent = true

-- Tab over space
vim.opt.expandtab = true

-- When, shifting, indent using 2 spaces
vim.opt.shiftwidth = 2

-- Insert "tabstop" number of spaces when the "tab" pressed
vim.opt.smarttab = true

-- Make indenting smarter again
vim.opt.smartindent = true

-- Indent using 2 spaces
vim.opt.tabstop = 4
----------------------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------------------
-- [Searching]

-- Highlight all matches on previous search pattern
vim.opt.hlsearch = true

-- Ignore case in search patterns
vim.opt.ignorecase = true

-- Incremental search that shows partial matches
vim.opt.incsearch = true

-- Automatically switch search to case-sensitive
vim.opt.smartcase = true
----------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------
-- [Rendering]

-- Sets the character encoding for the file of this buffer
vim.opt.fileencoding = "utf-8"

-- Avoid wrapping a line in the middle of a word
vim.opt.linebreak = true

-- Enable line wrapping
vim.opt.wrap = false

-- The number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- The minimal number of screen columns to keep to the left and to the right of the cursor if 'nowrap' is set 
vim.opt.sidescrolloff = 8

-- 	The value of this option specifies when the line with tab page labels will be displayed:
--      0: never
--	    1: only if there are at least two tab pages
--      2: always
vim.opt.showtabline = 2

-- Determines the maximum number of items to show in the popup menu for Insert mode completion
vim.opt.pumheight = 20

-- Determines the minimum width to use for the popup menu for Insert mode
vim.opt.pumheight = 15

-- Print the line number in front of each line
vim.opt.number = true

-- Show the line number relative to the line with the cursor in front of each line
vim.opt.relativenumber = false

-- Minimal number of columns to use for the line number
vim.opt.numberwidth = 6

-- Whether or not to draw the signcolumn. Valid values are:
--	   "auto"	only when there is a sign to display
--	   "no"		never
--	   "yes"	always
--	   "number"	display signs in the 'number' column. If the number column is not present, then behaves like "auto".
vim.opt.signcolumn = "yes"

-- Highlight the text line of the cursor with CursorLine hl-CursorLine. Useful to easily spot the cursor
vim.opt.cursorline = true

-- Highlight the screen column of the cursor with CursorColumn hl-CursorColumn.
vim.opt.cursorcolumn = false

----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
-- [Window]

-- When on, splitting a window will put the new window below the current one
vim.opt.splitbelow = true

-- When on, splitting a window will put the new window right of the current one
vim.opt.splitright = true
----------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------
-- [ETC]
-- When on spell checking will be done
vim.opt.spell = true

-- Make a backup before overwriting a file
vim.opt.backup = false

-- Allow neovim to access to system clipboard
vim.opt.clipboard = "unnamedplus"

-- If this many milliseconds nothing is typed the swap file will be written to disk
vim.opt.updatetime = 300

-- When on, Vim automatically saves undo history to an undo file when writing a buffer to a file, and restores undo history from the same file on buffer read.
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.mousemoveevent = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
----------------------------------------------------------------------------------------------------------------
