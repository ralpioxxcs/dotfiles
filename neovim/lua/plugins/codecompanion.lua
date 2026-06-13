return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  config = function()
    require("codecompanion").setup({
      display = {
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            title = "CodeCompanion actions", -- The title of the action palette
          },
        },

        chat = {
          slash_commands = {
            ["file"] = {
              -- Location to the slash command in CodeCompanion
              callback = "strategies.chat.slash_commands.file",
              description = "Select a file using Telescope",
              opts = {
                provider = "telescope", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
                contains_code = true,
              },
            },
            ["git_files"] = {
              description = "List git files",
              ---@param chat CodeCompanion.Chat
              callback = function(chat)
                local handle = io.popen("git ls-files")
                if handle ~= nil then
                  local result = handle:read("*a")
                  handle:close()
                  chat:add_context({ role = "user", content = result }, "git", "<git_files>")
                else
                  return vim.notify("No git files available", vim.log.levels.INFO, { title = "CodeCompanion" })
                end
              end,
              opts = {
                contains_code = false,
              },
            },
          },

          intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
          separator = "─", -- The separator between the different messages in the chat buffer
          show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
          show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          show_settings = false, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          show_tools_processing = true, -- Show the loading message when tools are being executed?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?

          -- Change the default icons
          icons = {
            chat_fold = " ",
            chat_context = "📎️",
            chat_settings = "⚙️ ",
            buffer_pin = " ",
            buffer_watch = "👀 ",
          },

          -- Alter the sizing of the debug window
          debug_window = {
            ---@return number|fun(): number
            width = vim.o.columns - 5,
            ---@return number|fun(): number
            height = vim.o.lines - 2,
          },

          -- Options to customize the UI of the chat buffer
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
            border = "rounded", -- Border style, see :h nvim_open_win for options
            height = 0.8,
            width = 0.4,
            relative = "editor",
            full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
            sticky = false, -- when set to true and `layout` is not `"buffer"`, the chat buffer will remain opened when switching tabs
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = "no",
              spell = false,
              wrap = true,
            },
          },

          ---Customize how tokens are displayed
          ---@param tokens number
          ---@param adapter CodeCompanion.Adapter
          ---@return string
          token_count = function(tokens, adapter)
            return " (" .. tokens .. " tokens)"
          end,
        },
      },

      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            -- MCP Tools
            make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
            show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
            add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
            show_result_in_chat = true, -- Show tool results directly in chat buffer
            format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer

            -- MCP Resources
            make_vars = false, -- Convert MCP resources to #variables for prompts

            -- MCP Prompts
            make_slash_commands = true, -- Add MCP prompts as /slash commands
          },
        },
      },

      -- adapters = {
      --   ["copilot-gpt"] = {
      --     type = "llm",
      --     command = "copilot-gpt",
      --     args = { "--model", "gpt-4o" },
      --     max_tokens = 3000,
      --     temperature = 0.7,
      --     top_p = 1,
      --     frequency_penalty = 0,
      --     presence_penalty = 0,
      --   },
      --   ["copilot-claude"] = {
      --     type = "chat",
      --     command = "copilot-claude",
      --     args = { "--model", "claude-sonnet-4-20250514" },
      --     max_tokens = 3000,
      --     temperature = 0.7,
      --     top_p = 1,
      --     frequency_penalty = 0,
      --     presence_penalty = 0,
      --   },
      --   ["copilot-gemini"] = {
      --     type = "chat",
      --     command = "copilot-gemini",
      --     args = { "--model", "gemini-1.5-pro" },
      --     max_tokens = 3000,
      --     temperature = 0.7,
      --     top_p = 1,
      --     frequency_penalty = 0,
      --     presence_penalty = 0,
      --   },
      -- },

      strategies = {
        chat = {
          adapter = {
            name = "copilot",
            model = "gpt-4o",
          },
        },
      },
    })
  end,
}

