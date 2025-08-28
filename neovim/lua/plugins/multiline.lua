return {
	"mg979/vim-visual-multi",

	init = function()
		vim.g.VM_leader = "\\"
		vim.g.VM_mouse_mappings = 1

		-- https://github.com/mg979/vim-visual-multi/wiki/Mappings
		vim.g.VM_maps = {
			-- 단어
			["Find Under"] = "<C-n>",
			["Find Subword Under"] = "<C-n>",

			-- 모든 동일 단어 선택
			["Select All"] = "ga",

			-- 선택 영역
			["Skip Region"] = "<C-x>",
			["Remove Region"] = "<C-b>",

			-- 커서 이동
			["Add Cursor Down"] = "<C-Down>",
			["Add Cursor Up"] = "<C-Up>",
			["Add Cursor At Pos"] = "\\",

			-- 마우스 설정
			["Mouse Cursor"] = "<C-LeftMouse>",
			["Mouse Word"] = "<C-RightMouse>",
			["Mouse Column"] = "<M-C-RightMouse>",
		}
	end,

	event = "VeryLazy",
}
