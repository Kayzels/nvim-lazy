return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
    opts = {
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "sc",
            auto_save = true,
            expiration_days = 0,
            picker = "fzf-lua",
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion_history",
            enable_logging = false,
          },
        },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = 'cmd:kwallet-query -f "CodeCompanion" -r Gemini kdewallet',
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                -- Gemma 3 is better, but bigger so don't load by default.
                -- default = "gemma3:12b",
                default = "hf.co/TheDrummer/Tiger-Gemma-9B-v3-GGUF:Q5_K_M",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "gemini",
          roles = {
            ---@type string|fun(adapter: CodeCompanion.Adapter): string
            llm = function(adapter)
              local icon = "󰚩  "
              local name = "CodeCompanion"
              local bracket_name = adapter.formatted_name
              if adapter.name == "ollama" then
                name = "WriteCompanion"
                if adapter.model and adapter.model.name then
                  bracket_name = adapter.model.name
                end
              end
              return icon .. name .. " (" .. bracket_name .. ")"
            end,
            ---@type string
            user = (function()
              local name = vim.env.USER or "Me"
              return "  " .. name:sub(1, 1) .. name:sub(2)
            end)(),
          },
        },
      },
      opts = {
        ---@param opts {adapter: CodeCompanion.Adapter, language?: string}
        ---@return string
        system_prompt = function(opts)
          local language = opts.language or "English"
          local prompts = require("prompts")
          local result = prompts.default_prompt
          if opts.adapter.name == "ollama" then
            result = prompts.writing_prompt
          end
          return string.format(result, language)
        end,
      },
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion chat" },
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanionActions",
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      overrides = {
        filetype = {
          codecompanion = {
            render_modes = { "n", "c", "v" },
            heading = {
              -- Remove the circle showing for H2, that's the user and bot heading
              icons = { "󰲡 ", " ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
            },
          },
        },
      },
    },
  },
}
