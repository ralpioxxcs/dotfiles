local status_ok, indent_blankline = pcall(require "ibl", "indent_blankline")
if not status_ok then
  return
end

vim.opt.list = true
--vim.opt.listchars:append "space:."

indent_blankline.setup {
  char = "▏",
  -- When on, if there is a single tab in a line, only tabs are used to calculate the indentation level.
  -- When off, both spaces and tabs are used to calculate the indentation level.
  -- Only makes a difference if a line has a mix of tabs and spaces for indentation.
  strict_tabs = false,

  use_treesitter = true,

  show_end_of_line = true,
  space_char_blankline = " ",

  show_current_context = true,
  show_current_context_start = true,

  show_trailing_blankline_indent = false,
  show_first_indent_level = true,

  -- Specifies a list of |filetype| values for which this plugin is not enabled.
  -- Ignored if the value is an empty list.
  filetype_exclude = {
    "lspinfo",
    "packer",
    "checkhealth",
    "help",
    "man",
    "dashboard",
    "git",
    "markdown",
    "text",
    "terminal",
    "NvimTree",
  },

  --  Specifies a list of |buftype| values for which this plugin is not enabled.
  --  Ignored if the value is an empty list.
  buftype_exclude = {
    "terminal",
    "nofile",
    "quickfix",
    "prompt",
  },
}
