return {{
    -- Mason: LSP/DAP/formatter 설치 관리자
    "williamboman/mason.nvim",
    config = function(_, opts)
        require("mason").setup(opts)
    end
}, {
    -- Mason과 LSPConfig 연동
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"williamboman/mason.nvim", "neovim/nvim-lspconfig"}
}, {
    -- 기본 LSP 설정
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        -- LSP attach 시 키맵핑
        local on_attach = function(_, bufnr)
            local opts = {
                noremap = true,
                silent = true,
                buffer = bufnr
            }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({
                    async = true
                })
            end, opts)
        end

        -- 기본 capabilities (nvim-cmp 연동)
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
    end
}, {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", 'hrsh7th/cmp-nvim-lsp',
                    "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", 'hrsh7th/cmp-nvim-lsp-signature-help',
                    'onsails/lspkind.nvim', 'zbirenbaum/copilot-cmp'},

    event = "InsertEnter",
    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            formatting = {
                format = require'lspkind'.cmp_format {
                    mode = "symbol_text",
                    menu = {
                        nvim_lsp = "[LSP]",
                        buffer = "[Buffer]",
                        latex_symbols = "[Latex]",
                        luasnip = "[LuaSnip]"
                    }
                }
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            view = {
                entries = {
                    name = 'custom',
                    selection_order = 'near_cursor'
                }
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'})
            }),
            sources = cmp.config.sources({{
                name = 'nvim_lsp'
            }, {
                name = 'luasnip'
            }, {
                name = 'buffer'
            }, {
                name = 'calc'
            }, {
                name = 'path',
                group_index = 2
            }, {
                name = "copilot",
                group_index = 2
            }, {
                name = 'treesitter'
            }})
        }
    end
}}
