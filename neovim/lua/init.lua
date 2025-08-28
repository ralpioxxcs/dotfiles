---------------------------------
-- [ Bootstrap for lazy.nvim ]
---------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

---------------------------------
-- [ Luarocks ]
---------------------------------
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

if vim.g.vscode then
	-- VSCode Neovim
	require("user.vscode_keymaps")
else
	---------------------------------
	-- [ Import Lua modules ]
	---------------------------------
	require("core/options")
	require("core/keymap")

	require("lazy").setup({
		spec = { {
			import = "plugins",
		} },

		ui = {
			border = "rounded",
		},

		install = {
			colorscheme = { "tokyonight", "habamax" },
		},
	})

	vim.cmd.colorscheme("catppuccin")

	vim.g.markdown_fenced_languages = { "ts=typescript" }
end
