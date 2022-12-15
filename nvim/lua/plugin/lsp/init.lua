local status_ok, _ = pcall(require, "lspconfig")
if not statsu_ok then
  return
end

require("lsp.mason")
