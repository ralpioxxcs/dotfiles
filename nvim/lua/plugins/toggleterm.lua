local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

local Terminal = require('toggleterm.terminal').Terminal
local Lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

require("toggleterm").setup{
  size=20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true, -- shades terminal filetypes to be darker than other window
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'float',
  close_on_exit = true,
  shell = vim.o.shell,
  auto_scroll = true,
  float_opts = {
    border = 'curved',
    winblend = 10,
  },
}
