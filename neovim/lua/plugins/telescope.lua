return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  -- Already set in core/keymap.lua
  -- keys = {
  --   {
  --     "<C-p>",
  --     "<cmd>Telescope find_files<cr>",
  --     desc = "Find Files",
  --   },
  --   {
  --     "<C-f>fg",
  --     "<cmd>Telescope live_grep<cr>",
  --     desc = "Live Grep",
  --   },
  --   {
  --     "<C-b>fb",
  --     "<cmd>Telescope buffers<cr>",
  --     desc = "Find Buffers",
  --   },
  -- },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          height = 0.95,
        },
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules" },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-u>"] = false,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      },
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
      },
    })

    telescope.load_extension("ui-select")
  end,
}
