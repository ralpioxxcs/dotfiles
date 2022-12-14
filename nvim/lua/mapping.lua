local keymap = vim.keymap                       -- load keymap module (:help keymap)

vim.g.mapleader = ','                           -- change leader to a comma

keymap.set('n', '+', '<C-a>')                   -- increment
keymap.set('n', '-', '<C-x>')                   -- decrement

keymap.set('n', 'te', ":tabedit")

keymap.set('n', 'ss', ':split<Return><C-w>w')   -- split window hoziontally
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')  -- split window vertically

keymap.set('n', '<Space>', '<C-w>w')            -- move window
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')

keymap.set('n', '<C-w><left>', '<C-w><')        -- resize window
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
