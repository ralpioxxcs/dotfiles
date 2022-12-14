local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packet.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 
    'clone', 
    '--depth', 
    '1', 
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print("Installing packer close and reopen Neovim")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever save the plugins.lua file
vim.cmd[[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

--packer.init({
--  display = {
--    open_fn = function()
--      return require("packer.util").float({border = "rounded"})
--    end,
--  },
--})

-- Install plugins here
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'    -- packer itself

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  use 'nvim-lua/plenary.nvim'     -- commom utilites
  use 'onsails/lspkind-nvim'      -- vscode-like pictograms
  use 'windwp/nvim-autopairs'
  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'EdenEast/nightfox.nvim'

  -- completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- lsp
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  -- colorschemes
  use 'arcticicestudio/nord-vim'

  -- snippets
  use 'L3MON4D3/LuaSnip'          -- lua sinppet engine

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
		commit = '8e763332b7bf7b3a426fd8707b7f5aa85823a5ac',
	}
  
  -- bufferline
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
