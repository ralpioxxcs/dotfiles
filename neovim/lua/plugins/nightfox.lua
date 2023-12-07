local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
  return
end

nightfox.setup {
  options = {

    -- Compiled file's destination location
    compile_path = vim.fn.stdpath "cache" .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix

    transparent = true, -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`

    dim_inactive = false, -- Non focused panes set to alternative background
    module_default = true, -- Default enable value for modules

    -- Style to be applied to different syntax groups
    styles = {
      comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "bold",
      keywords = "bold",
      numbers = "italic",
      operators = "NONE",
      strings = "NONE",
      types = "italic,bold",
      variables = "NONE",
    },

    -- Inverse highlight for different types
    inverse = {
      match_paren = false,
      visual = false,
      search = true,
    },
  },
}

-- setup must be called before loading
vim.cmd "colorscheme nordfox"

-- transparent background
-- vim.cmd('highlight Normal guibg=none')
