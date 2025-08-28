return {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim',
                    'nvim-telescope/telescope-media-files.nvim', 'nvim-tree/nvim-web-devicons'},

    keys = {{
        "<C-p>",
        "<cmd>Telescope find_files<cr>",
        desc = "Find Files"
    }, {
        "<C-f>fg",
        "<cmd>Telescope live_grep<cr>",
        desc = "Live Grep"
    }, {
        "<C-b>fb",
        "<cmd>Telescope buffers<cr>",
        desc = "Find Buffers"
    }},

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- 기존에 사용하시던 이미지 미리보기 설정을 그대로 유지합니다.
                -- 참고: 이 기능을 사용하려면 시스템에 'catimg'가 설치되어 있어야 합니다.
                preview = {
                    mime_hook = function(filepath, bufnr, opts)
                        local is_image = function(filepath)
                            local image_extensions = {"png", "jpg", "jpeg", "webp"}
                            local split_path = vim.split(filepath:lower(), ".", {
                                plain = true
                            })
                            local extension = split_path[#split_path]
                            return vim.tbl_contains(image_extensions, extension)
                        end
                        if is_image(filepath) then
                            local term = vim.api.nvim_open_term(bufnr, {})
                            local function send_output(_, data, _)
                                for _, d in ipairs(data) do
                                    vim.api.nvim_chan_send(term, d .. "\r\n")
                                end
                            end
                            vim.fn.jobstart({"catimg", filepath}, {
                                on_stdout = send_output,
                                stdout_buffered = true,
                                pty = true
                            })
                        else
                            require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
                                "Binary cannot be previewed")
                        end
                    end
                },
                layout_strategy = "vertical",
                layout_config = {
                    height = 0.95
                },
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = {"smart"},
                file_ignore_patterns = {".git/", "node_modules"},
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-u>"] = false,
                        ["<Down>"] = actions.move_selection_next,
                        ["<Up>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous
                    }
                }
            },
            extensions = {
                ["ui-select"] = {require("telescope.themes").get_dropdown {}},
                media_files = {
                    find_cmd = "rg"
                }
            }
        })

        -- 확장 기능 로드
        telescope.load_extension("ui-select")
        telescope.load_extension("media_files")
    end
}
