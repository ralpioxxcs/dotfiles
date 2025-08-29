return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    -- formatting sources
    local formatting = null_ls.builtins.formatting
    -- diagnostic sources
    local diagnostics = null_ls.builtins.diagnostics
    -- code action sources
    local code_actions = null_ls.builtins.code_actions
    -- hover sources
    local hover = null_ls.builtins.hover

    null_ls.setup({
      debug = true,

      sources = {
        -- [Formatters]

        ---- JavaScript / TypeScript / JSX / TSX / JSON / CSS / HTML / Markdown
        formatting.prettier.with({
          extra_args = { "--single-quote", "--jsx-single-quote" },
        }),

        ---- Lua
        formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
        }),

        ---- Python
        formatting.black,

        ---- Code Spell Checker
        formatting.codespell,

        ---- Shell
        formatting.shellharden,

        ---- SQL
        formatting.sqlformat,
        --formatting.sql_formatter,

        -- Linter
        diagnostics.codespell,
        diagnostics.commitlint,
        diagnostics.dotenv_linter,

        -- Code Actions
        code_actions.gitsigns,
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", {
            noremap = true,
            silent = true,
          })
        end
      end,
    })
  end,
}
