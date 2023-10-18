-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", --latest
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require("lazy").setup({
  -- Colorscheme
  {
    "EdenEast/nightfox.nvim",
  },

  -- Useful Lua functions
  { "nvim-lua/plenary.nvim" },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- Status line
  { 
    "nvim-lualine/lualine.nvim",
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },

  -- Buffer line
  { 
    "akinsho/bufferline.nvim",
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },

  -- Gitsigns
  { "lewis6991/gitsigns.nvim" },

  -- Indent guide
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- Auto pair
  { "windwp/nvim-autopairs" },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },

  -- Tag viewer
  { "preservim/tagbar" },

  -- Completions
  { 
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Snippets
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  -- Multiline selection
  -- https://github.com/mg979/vim-visual-multi
  { "mg979/vim-visual-multi" },

  -- Comment
  { "numToStr/Comment.nvim" },

  -- ToggleTerm
  { "akinsho/toggleterm.nvim", version = "*", config = true},

  -- Telescope
  {
    "nvim-telescope/telescope.nvim", 
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Which-Key
  { "folke/which-key.nvim", lazy = true },

  -- Markdown Preview
  { "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  }

})
