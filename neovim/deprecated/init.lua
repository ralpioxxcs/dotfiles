
-- Import Lua modules
require "core/lazy"
require "core/options"
require "core/keymap"

-- Load LSP configuration
require "lsp"

-- Load plugin configurations
require "plugins/nightfox"
require "plugins/alpha-nvim"
require "plugins/lualine"
require "plugins/bufferline"
require "plugins/nvim-cmp"
require "plugins/nvim-tree"
require "plugins/nvim-treesitter"
require "plugins/nvim-autopairs"
require "plugins/indent-blankline"
require "plugins/comment"
require "plugins/toggleterm"
require "plugins/which-key"
require "plugins/telescope"
require "plugins/gitsigns"
require "plugins/qmk-format"

--------------------------------------------------

-- require("image").setup({
--   render = {
--     min_padding = 10,
--     show_label = true,
--     show_image_dimensions = true,
--     use_dither = true,
--     foreground_color = true,
--     background_color = true,
--   },
--   events = {
--     update_on_nvim_resize = true,
--   },
-- })

-- Utilities for creating configurations

-- stylua
-- clangformat
-- gofmt
-- yapf
-- prettier
-- jq
-- yamlfmt

local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help
        -- files
        return {
          exe = "stylua",
          args = {
            "--indent-type=Spaces",
            "--indent-width=2",
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end,
    },

    cpp = {
      require("formatter.filetypes.cpp").clangformat,
    },

    go = {
      require("formatter.filetypes.go").gofmt,
    },

    python = {
      require("formatter.filetypes.python").yapf,

      function()
        return {
          exe = "yapf",
          args = {
            "--style='{based_on_style: pep8, indent_width: 2}'",
          },
          stdin = true,
        }
      end,
    },

    javascript = {
      require("formatter.filetypes.javascript").prettier,
    },

    typescript = {
      require("formatter.filetypes.typescript").prettier,
    },

    json = {
      require("formatter.filetypes.json").jq,

      function()
        return {
          exe = "jq",
          args = {
            "--indent=2",
          },
          stdin = true,
        }
      end,
    },

    yaml = {
      require("formatter.filetypes.yaml").yamlfmt,
    },

    sh = {
      require("formatter.filetypes.sh").shfmt,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
}



