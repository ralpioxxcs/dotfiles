return { -- 1. Copilot 자동완성 플러그인
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter", -- Insert 모드에 진입할 때 활성화
		opts = {
			suggestion = {
				-- 자동 제안 활성화
				auto_trigger = true,
				-- 제안 스타일 설정
				keymap = {
					accept = "<C-l>", -- 제안 수락 키 (Ctrl+L)
					dismiss = "<C-]>", -- 제안 닫기 키
				},
			},
			panel = {
				-- 여러 제안을 보여주는 패널 활성화
				enabled = true,
			},
		},
	}, -- 2. nvim-cmp와 Copilot을 연결하는 소스
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		-- nvim-cmp 설정 이후에 로드되도록 설정
		config = function()
			require("copilot_cmp").setup()
		end,
	}, -- 3. Copilot Chat 플러그인
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary", -- 최신 기능을 위해 canary 브랜치 사용
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- 인증 정보를 공유
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = false,
			-- 채팅창 스타일
			window = {
				layout = "vertical",
				width = 0.5,
			},
		},
		-- Copilot Chat을 위한 키맵 설정
		keys = {
			{
				"<leader>cc",
				"<cmd>CopilotChatToggle<cr>",
				desc = "Toggle CopilotChat",
			}, -- Visual 모드에서 선택된 코드로 질문하기
			{
				"<leader>cq",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						require("CopilotChat").ask(input, {
							selection = require("CopilotChat.select").get_selection(),
						})
					end
				end,
				mode = "v",
				desc = "Ask Copilot question about visual selection",
			},
		},
	},
}
