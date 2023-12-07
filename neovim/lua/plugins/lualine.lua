local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "nord",

    component_separators = "|",
    section_separators = { left = "", right = "" },

    ignore_focus = {},

    -- When set to true, left sections i.e. 'a','b' and 'c' can't take over the entire statusline
    -- even if neither of 'x', 'y' or 'z' are present.
    always_divide_middle = true,

    -- enable global statusline (have a single statusline at bottom of neovim instead of one for every window).
    -- This feature is only available in neovim 0.7 and higher.
    globalstatus = false,

    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },

  --  +-------------------------------------------------+
  -- | A | B | C                             X | Y | Z |
  -- +-------------------------------------------------+
  --   [Available components]
  --      branch (git branch)
  --      buffers (shows currently available buffers)
  --      diagnostics (diagnostics count from your preferred source)
  --      diff (git diff status)
  --      encoding (file encoding)
  --      fileformat (file format)
  --      filename
  --      filesize
  --      filetype
  --      hostname
  --      location (location in file in line:column format)
  --      mode (vim mode)
  --      progress (%progress in file)
  --      searchcount (number of search matches when hlsearch is active)
  --      selectioncount (number of selected characters or lines)
  --      tabs (shows currently available tabs)
  --      windows (shows currently available windows)

  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename", "filesize" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location", "searchcount" },
  },

  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },

  -- not use tabline
  tabline = nil,

  -- not use winbar
  winbar = nil,
  inactive_winbar = {},

  -- not use extensions
  extensions = nil,
}
