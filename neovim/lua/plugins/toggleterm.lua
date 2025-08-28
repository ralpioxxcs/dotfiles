return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 20,
		start_in_insert = true,
		shading_factor = 2,
		direction = "float",
		close_on_exit = true,
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		-- 터미널 모드에서 Esc 키를 눌렀을 때 터미널 모드를 빠져나오도록 설정
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })
	end,
	keys = {
		-- 플로팅 터미널 토글
		{ "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" },

		-- 수평 터미널 토글
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },

		-- 수직 터미널 토글
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal" },

		-- lazygit 토글 (매우 유용)
		{
			"<leader>gg",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
				lazygit:toggle()
			end,
			desc = "Toggle lazygit",
		},
	},
}
