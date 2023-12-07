-- Language servers
-- (ref : https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers)
local servers = {
  -- c/c++
  "clangd",
  "cmake",

  -- golang
  "gopls",

  -- python
  "pyright",

  -- html/css/js
  "html",
  "cssls",
  "tailwindcss",
  "tsserver",

  -- scripts
  "lua_ls",
  "bashls",

  -- markup
  "jsonls",
  "yamlls",

  "dockerls",
}

-- 아래 순서대로 setup 해야함
-- 1. mason.nvim
-- 2. mason-lspconfig.nvim
-- setup lspconfig servers

-- Mason setup
require("mason").setup {
  ui = {
    border = "none",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  log_level = vim.log.levels.INFO,

  max_concurrent_installers = 4,
}

-- Mason lspconfig setup
require("mason-lspconfig").setup {
  -- 자동으로 설치될 language 서버 목록
  ensure_installed = servers,

  -- 모든 서버들은 lspconfig를 통해 자동으로 설치됨
  automatic_installation = true,
}

-- lspconfig setup
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

-- Apply each server settings
for _, server in pairs(servers) do
  opts = {
    on_attach = require("lsp.handlers").on_attach,
    capabilities = require("lsp.handlers").capabilities,
  }
  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "lsp." .. server)

  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
