-- Bootstrap for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

if vim.g.vscode then
    -- VSCode Neovim
    require("user.vscode_keymaps")
else
    -- Import Lua modules
    require("core/options")
    require("core/keymap")

    require("lazy").setup({
        spec = {{
            import = "plugins"
        }},
        ui = {
            border = "rounded"
        },
        install = {
            colorscheme = {"tokyonight", "habamax"}
        },

        -- Colorscheme
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000
        },
        {"shaunsingh/nord.nvim"},

        -- Language Server Protocl (LSP)
        -- {"neovim/nvim-lspconfig"},
        -- {"williamboman/mason.nvim"},
        -- {"williamboman/mason-lspconfig.nvim"},

        -- Completions
        -- {
        --     "hrsh7th/nvim-cmp",
        --     dependencies = {"hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-buffer"}
        -- },

        -- LuaSnip for completion
        {"saadparwaiz1/cmp_luasnip"},

        -- Snippet Engine
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            dependencies = {"rafamadriz/friendly-snippets"}
        },

        -- Dashboard
        {
            "goolord/alpha-nvim",
            dependencies = {"kyazdani42/nvim-web-devicons"}
        },

        -- Status line
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {"kyazdani42/nvim-web-devicons"}
        },

        -- Buffer line
        -- {
        --     "akinsho/bufferline.nvim",
        --     dependencies = {"kyazdani42/nvim-web-devicons"}
        -- },

        -- Auto pair
        {
            "windwp/nvim-autopairs",
            opts = {
                check_ts = true,
                ts_config = {
                    lua = {"string", "source"}
                }
            }

        },

        -- Tag viewer
        -- {"preservim/tagbar"},

        -- Multiline selection (https://github.com/mg979/vim-visual-multi)
        {"mg979/vim-visual-multi"},

        -- Comment
        -- {"numToStr/Comment.nvim"},

        -- ToggleTerm
        -- {
        --     "akinsho/toggleterm.nvim",
        --     version = "*",
        --     config = true
        -- },

        -- Telescope
        -- {
        --     "nvim-telescope/telescope.nvim",
        --     tag = "0.1.4",
        --     dependencies = {"nvim-lua/plenary.nvim"}
        -- },
        -- {
        --     "nvim-telescope/telescope-media-files.nvim",
        --     dependencies = {"nvim-lua/popup.nvim"}
        -- },
        -- {"nvim-telescope/telescope-ui-select.nvim"},

        -- Which-Key
        -- {
        --     "folke/which-key.nvim",
        --     event = "VeryLazy",
        --     dependencies = {"echasnovski/mini.nvim"}
        -- },

        -- Zen
        {
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
                        list = true
                    },
                    plugins = {
                        twilight = {
                            enabled = false
                        },
                        gitsigns = {
                            enabled = true
                        },
                        tmux = {
                            enabled = true
                        },

                        -- this will change the font size on alacritty when in zen mode
                        -- requires  Alacritty Version 0.10.0 or higher
                        -- uses `alacritty msg` subcommand to change font size
                        alacritty = {
                            enabled = true,
                            font = "30" -- font size
                        }
                    }
                },
                -- callback where you can add custom code when the Zen window opens
                on_open = function(win)
                end,
                -- callback where you can add custom code when the Zen window closes
                on_close = function()
                end
            }
        },

        -- Markdown Preview
        {
            "iamcco/markdown-preview.nvim",
            cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
            ft = {"markdown"},
            build = function()
                vim.fn["mkdp#util#install"]()
            end
        },

        -- Formatter
        {"mhartington/formatter.nvim"},

        -- Image
        {"edluffy/hologram.nvim"},

        -- Documentation
        {
            "kkoomen/vim-doge",
            build = function()
                vim.fn["doge#install"]()
            end
        },

        -- Twilight
        {
            "folke/twilight.nvim",
            opts = {
                dimming = {
                    alpha = 0.5, -- amount of dimming
                    -- we try to get the foreground from the highlight groups or fallback color
                    color = {"Normal", "#ffffff"},
                    term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
                    inactive = false -- when true, other windows will be fully dimmed (unless they contain the same buffer)
                },
                context = 50, -- amount of lines we will try to show around the current line
                treesitter = true, -- use treesitter when available for the filetype
                -- treesitter is used to automatically expand the visible text,
                -- but you can further control the types of nodes that should always be fully expanded
                expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                "function", "method", "table", "if_statement"},
                exclude = {} -- exclude these filetypes
            }
        },

        -- QMK Formats
        -- { "codethread/qmk.nvim" },

        -- CHAT GPT  (not used)
        --
        -- {
        --   "jackMort/ChatGPT.nvim",
        --   event = "VeryLazy",
        --   config = function()
        --     require("chatgpt").setup()
        --   end,
        --   dependencies = {
        --     "MunifTanjim/nui.nvim",
        --     "nvim-lua/plenary.nvim",
        --     "folke/trouble.nvim",
        --     "nvim-telescope/telescope.nvim",
        --   },
        -- },

        -- { "f-person/git-blame.nvim" },

        {"liuchengxu/vista.vim"},

        -- Github Copilot
        {
            "zbirenbaum/copilot.lua",
            cmd = "Copilot",
            event = "InsertEnter"
        },
        {
            "zbirenbaum/copilot-cmp",
            config = function()
                require("copilot_cmp").setup()
            end
        },
        {
            "CopilotC-Nvim/CopilotChat.nvim",
            branch = "main",
            dependencies = {{"zbirenbaum/copilot.lua"}, -- or github/copilot.vim
            {"nvim-lua/plenary.nvim"} -- for curl, log wrapper
            },
            opts = {
                debug = false, -- Enable debugging
                -- See Configuration section for rest
                window = {
                    layout = "float",
                    width = 100, -- Fixed width in columns
                    height = 40, -- Fixed height in rows
                    border = "rounded", -- 'single', 'double', 'rounded', 'solid'
                    title = "🤖 AI Assistant",
                    zindex = 100 -- Ensure window stays on top
                },
                headers = {
                    user = "👤 You",
                    assistant = "🤖 Copilot",
                    tool = "🔧 Tool"
                },
                separator = "━━",
                auto_fold = true -- Automatically folds non-assistant messages
            }

            -- 키맵 설정 (가장 중요한 부분)
            -- keys = {
            --   -- 채팅창 열기
            --   { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Open Chat" },
            --
            --   -- 선택된 코드로 질문하기 (Visual 모드)
            --   { "<leader>cq", "<cmd>CopilotChat<cr>", mode = "v", desc = "CopilotChat - Ask question" },
            --
            --   -- 빠른 프롬프트: 선택된 코드 설명 (Visual 모드)
            --   { "<leader>ce", "<cmd>CopilotChat Explain<cr>", mode = "v", desc = "CopilotChat - Explain code" },
            --
            --   -- 빠른 프롬프트: 선택된 코드에 대한 테스트 생성 (Visual 모드)
            --   { "<leader>ct", "<cmd>CopilotChat Tests<cr>", mode = "v", desc = "CopilotChat - Generate Tests" },
            --
            --   -- 빠른 프롬프트: 선택된 코드 리팩토링 제안 (Visual 모드)
            --   { "<leader>cr", "<cmd>CopilotChat Review<cr>", mode = "v", desc = "CopilotChat - Review code" },
            -- },
        },

        {
            "ThePrimeagen/refactoring.nvim",
            dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter"},
            lazy = false,
            config = function()
                require("refactoring").setup()
            end
        },

        -- DAP
        {
            -- DAP Client
            "mfussenegger/nvim-dap",
            lazy = true,
            dependencies = { -- DAP Client UI
            "rcarriga/nvim-dap-ui", -- DAP Adapter
            "mxsdev/nvim-dap-vscode-js", -- Debugger
            {
                "microsoft/vscode-js-debug",
                version = "1.x",
                -- 커맨드 꼭 이대로 사용하기
                build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
            }},
            keys = {...},
            -- DAP Adater 설정
            config = function()
                require("dap-vscode-js").setup({
                    -- vscode-js-debug의 `절대 경로`. 꼭 직접 확인 후 설정해주셔야 합니다.
                    debugger_path = "/home/hong/.local/share/nvim/lazy/vscode-js-debug",
                    -- 사용하고자 하는 어댑터.
                    adapters = {"pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost"}
                })
                require("dapui").setup()
            end
        }
    })

    --------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------
    -- Utilities for creating configurations
    --------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------------------------------------------------------------------

    -- stylua
    -- clangformat
    -- gofmt
    -- yapf
    -- prettier
    -- jq
    -- yamlfmt

    -- local util = require("formatter.util")

    -- -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    -- require("formatter").setup({
    --     -- Enable or disable logging
    --     logging = true,
    --     -- Set the log level
    --     log_level = vim.log.levels.WARN,
    --     -- All formatter configurations are opt-in
    --     filetype = {
    --         lua = {require("formatter.filetypes.lua").stylua, -- You can also define your own configuration
    --         function()
    --             -- Supports conditional formatting
    --             if util.get_current_buffer_file_name() == "special.lua" then
    --                 return nil
    --             end

    --             -- Full specification of configurations is down below and in Vim help
    --             -- files
    --             return {
    --                 exe = "stylua",
    --                 args = {"--indent-type=Spaces", "--indent-width=2", "--search-parent-directories",
    --                         "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()), "--", "-"},
    --                 stdin = true
    --             }
    --         end},

    --         cpp = {require("formatter.filetypes.cpp").clangformat},

    --         c = {require("formatter.filetypes.c").clangformat},

    --         go = {require("formatter.filetypes.go").gofmt},

    --         python = {require("formatter.filetypes.python").yapf, function()
    --             return {
    --                 exe = "yapf",
    --                 args = {"--style='{based_on_style: pep8, indent_width: 2}'"},
    --                 stdin = true
    --             }
    --         end},

    --         javascript = {require("formatter.filetypes.javascript").prettier},

    --         typescript = {require("formatter.filetypes.typescript").prettier},

    --         json = {require("formatter.filetypes.json").jq, function()
    --             return {
    --                 exe = "jq",
    --                 args = {"--indent=2"},
    --                 stdin = true
    --             }
    --         end},

    --         yaml = {require("formatter.filetypes.yaml").yamlfmt},

    --         sh = {require("formatter.filetypes.sh").shfmt},

    --         -- Use the special "*" filetype for defining formatter configurations on
    --         -- any filetype
    --         ["*"] = { -- "formatter.filetypes.any" defines default configurations for any
    --         -- filetype
    --         require("formatter.filetypes.any").remove_trailing_whitespace}
    --     }
    -- })

    vim.g.markdown_fenced_languages = {"ts=typescript"}

    require("catppuccin").setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "frappe"
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15 -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = {"italic"}, -- Change the style of comments
            conditionals = {"italic"},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {}
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            mini = {
                enabled = true,
                indentscope_color = ""
            },
            telescope = {
                enabled = true
            }
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        }
    })

    -- setup must be called before loading
    vim.cmd.colorscheme("catppuccin")
end
