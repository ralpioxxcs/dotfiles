return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- 시작 시 바로 로드하도록 설정
    priority = 1000, -- 다른 UI 플러그인보다 먼저 로드되도록 우선순위 설정
    opts = {
        -- 테마 종류 설정: "latte", "frappe", "macchiato", "mocha"
        flavour = "macchiato",
        -- 투명 배경 설정
        transparent_background = false,
        term_colors = true,
        -- 다른 플러그인과의 통합 설정
        integrations = {
            cmp = true,
            gitsigns = true,
            mason = true,
            native_lsp = {
                enabled = true,
                underlines = {
                    errors = {"undercurl"},
                    hints = {"undercurl"},
                    warnings = {"undercurl"},
                    information = {"undercurl"}
                }
            },
            telescope = true,
            treesitter = true,
            bufferline = true -- 이전에 추가한 bufferline
            -- 추가적인 플러그인 통합을 원하면 여기에 추가
        }
    }
}
