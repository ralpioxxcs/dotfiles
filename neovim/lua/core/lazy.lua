-- Bootstrap for lazy.nvim
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

--
-- [Setup plugins]
-- 
require("lazy").setup({

  -- Colorscheme
  { "EdenEast/nightfox.nvim" },

  -- Language Server Protocl (LSP)
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Completions
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer"
    },
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },

  -- Snippet Engine
  {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" }
  },

  -- LuaSnip for completion
  { 'saadparwaiz1/cmp_luasnip' },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
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

  -- Tag viewer
  { "preservim/tagbar" },

  -- Multiline selection (https://github.com/mg979/vim-visual-multi)
  { "mg979/vim-visual-multi" },

  -- Comment
  { "numToStr/Comment.nvim" },

  -- ToggleTerm
  { "akinsho/toggleterm.nvim", version = "*", config = true},

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Which-Key
  { "folke/which-key.nvim", lazy = true },

  -- Markdown Preview
  { "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Formatter
  { "mhartington/formatter.nvim" }

})
