return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local which_key = require("which-key")

		-- 기본 설정
		which_key.setup({
			win = {
				title = true,
				title_pos = "center",
				padding = { 1, 2 },
			},
			layout = {
				spacing = 3,
			},
		})

		-- 키맵 그룹 등록
		-- <leader> 키를 눌렀을 때 표시될 메뉴를 정의합니다.
		which_key.add({
			{
				{ "<leader>c", group = "[C]ode / [C]opilot" },
				{ "<leader>c_", hidden = true },
				{ "<leader>f", group = "[F]ind / [F]ile" },
				{ "<leader>f_", hidden = true },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>g_", hidden = true },
				{ "<leader>t", group = "[T]erminal" },
				{ "<leader>t_", hidden = true },
			},
		})
	end,
}
