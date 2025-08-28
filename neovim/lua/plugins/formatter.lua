return {
    "nvimtools/none-ls.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        local null_ls = require("null-ls")

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        local code_actions = null_ls.builtins.code_actions

        null_ls.setup({
            sources = { 
            -- Formatter
            formatting.prettier.with({
                extra_args = {"--single-quote", "--jsx-single-quote"}
            }), 
            formatting.stylua, -- Lua 코드 포매터
            formatting.black, -- Python 포매터

            -- Linter
            diagnostics.eslint_d, 
            diagnostics.flake8, 

            -- Code Actions
            code_actions.gitsigns -- git 관련 quickfix
            },

            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", {
                        noremap = true,
                        silent = true
                    })
                end
            end
        })
    end
}

