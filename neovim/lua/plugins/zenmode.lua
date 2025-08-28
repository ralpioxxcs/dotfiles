return {

	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
			-- height and width can be:
			-- * an absolute number of cells when > 1
			-- * a percentage of the width / height of the editor when <= 1
			-- * a function that returns the width or the height
			width = 120,
			height = 1,
			options = {
				signcolumn = "yes",
				number = true,
				cursorline = true,
				relativenumber = false,
				cursorcolumn = false,
				foldcolumn = "0",
				list = true,
			},
			plugins = {
				twilight = {
					enabled = false,
				},
				gitsigns = {
					enabled = true,
				},
				tmux = {
					enabled = true,
				},

				-- this will change the font size on alacritty when in zen mode
				-- requires  Alacritty Version 0.10.0 or higher
				-- uses `alacritty msg` subcommand to change font size
				alacritty = {
					enabled = true,
					font = "30", -- font size
				},
			},
		},
		-- callback where you can add custom code when the Zen window opens
		on_open = function(win) end,
		-- callback where you can add custom code when the Zen window closes
		on_close = function() end,
	},
}
