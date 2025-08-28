return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        -- A list of parser names
        ensure_installed = {"c", "cpp", "make", "cmake", "cuda", "go", "gomod", "gosum", "bash", "python", "lua", "vim",
                            "tmux", "javascript", "typescript", "html", "css", "sql", "graphql", "xml", "json", "yaml",
                            "markdown"},

        -- Install parsers synchronously
        sync_install = true,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- List of parsers to ignore installing
        ignore_install = {},

        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },

        autopairs = {
            enable = true
        },

        indent = {
            enable = true
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn", -- set to `false` to disable one of the mappings
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm"
            }
        }
    }

}
