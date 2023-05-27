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
    lazy = false,
    priority = 1000,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- File explorer
  {
    "kyazdani42/nvim-tree.lua",
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

  -- Indent guide
  { "lukas-reineke/indent-blankline.nvim" },

  -- Autopair
  {
    "windwp/nvim-autopairs",
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup{}
    end
  },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },

  -- Tag viewer
  { "preservim/tagbar" },

  { "nvim-lua/plenary.nvim" },
  { "onsails/lspkind-nvim" },

  -- Completions
  { 
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
    },

  },

  -- Multiline selection
  { "mg979/vim-visual-multi" },

  -- Comment utility
  { "numToStr/Comment.nvim" },

  -- ToggleTerm
  { "akinsho/toggleterm.nvim", version = "*", config = true},

  -- Which-Key
  { "folke/which-key.nvim", lazy = true }

})
