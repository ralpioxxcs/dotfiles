local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

nvim_tree.setup {
  sort = {
    sorter = "case_sensitive",
  },

  view = {
    cursorline = true,
    width = 40,
  },

  renderer = {
    indent_width = 3,
    group_empty = true,
  },

  filters = {
    dotfiles = false,
    git_ignored = false,
    custom = {
      "^.git$",
      "^.vscode$",
      "^node_modules$",
    },
  },

  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
}
