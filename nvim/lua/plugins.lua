-- Shorten vim function
local fn = vim.fn

-- packer 자동 설치
-- vim.fn.stdpath({what}) -- returns standard-path locations of various default files and dirs
-- vim.fn.empty({expr})
-- vim.fn.glob
-- vim.fn.system({cmd} [, {input}) - output of shell command
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print("Installing packer close and reopen Neovim")
  vim.cmd([[packadd packer.nvim]])
end

-- 현재파일 ('plugins.lua') 수정사항 발생시 auto reload
vim.cmd[[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Load packer module
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install plugins here
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'      -- packer itself
  use 'nvim-lua/plenary.nvim'     	-- commom utilites including useful lua function
  use 'onsails/lspkind-nvim'      	-- vscode-like pictograms
  use 'windwp/nvim-autopairs'		    -- a super powerful autopair plugin for neovim
  use 'kyazdani42/nvim-tree.lua'    -- tree explorer
  use 'kyazdani42/nvim-web-devicons'-- provide dev icons
  use 'EdenEast/nightfox.nvim' 		  -- colorscheme

  -- status line
  use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- buffer line
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

  use 'numToStr/Comment.nvim'            -- comment utility

  -- completions
  use 'hrsh7th/nvim-cmp'            -- completion plugin
  use 'hrsh7th/cmp-buffer'          -- buffer completion
  use 'hrsh7th/cmp-path'            -- path completion
  use 'hrsh7th/cmp-cmdline'         -- cmdline completion
  use 'saadparwaiz1/cmp_luasnip'

  -- lsp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  -- snippets
  use 'L3MON4D3/LuaSnip'          -- lua sinppet engine

  -- treesitter
  use {'nvim-treesitter/nvim-treesitter', commit = '8e763332b7bf7b3a426fd8707b7f5aa85823a5ac'}

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
