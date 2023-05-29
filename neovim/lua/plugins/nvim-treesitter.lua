local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter.setup({
  ensure_installed = { 
    "c", 
    "cpp",
    "make",
    "cmake", 
    "cuda",

    "go",
    "gomod",

    "bash", 
    "python", 
    "lua",
    "vim",

    "javascript",
    "typescript",
    "html",
    "css", 

    "json", 
    "yaml", 
    "markdown", 
  },
  sync_install = true,
  auto_install = true,

  autopairs = {
    enable = true
  },

  highlight = {
    enable = true,
  },

  indent = {
    enable = true,
  }
})
