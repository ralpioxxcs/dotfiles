local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter.setup({
  ensure_installed = { "bash", "c", "cpp", "cmake", "go", "python", "javascript", "json", "css", "yaml", "markdown", "lua" },
  sync_install = true,
  auto_install = true,
  autopairs = {
    enable = true
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
})
