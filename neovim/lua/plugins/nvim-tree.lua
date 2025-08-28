return {

    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {"kyazdani42/nvim-web-devicons"},
    opts = {
        sort = {
            sorter = "case_sensitive"
        },

        view = {
            cursorline = true,
            width = 40
        },

        renderer = {
            indent_width = 3,
            group_empty = true
        },

        filters = {
            dotfiles = false,
            git_ignored = false,
            custom = {"^.git$", "^.vscode$", "^node_modules$"}
        },

        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        }
    }
}
