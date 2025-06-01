return {
  {
    "monkoose/neocodeium",
    dependencies = {
      "folke/snacks.nvim",
    },
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup({
        enabled = false,
        manual = true,
        silent = true,
        filetypes = {
          help = false,
          gitcommit = false,
          gitrebase = false,
          ["."] = false,
          TelescopePrompt = false,
          snacks_dashboard = false,
          ["neo-tree"] = false,
          ["dap-repl"] = false,
          snacks_terminal = false,
        },
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "NeoCodeiumCompletionDisplayed",
        callback = function()
          require("cmp").abort()
        end,
      })

      vim.keymap.set("i", "<C-CR>", function()
        neocodeium.accept()
      end)
      vim.keymap.set("i", "<A-o>", function()
        neocodeium.accept()
      end)
      vim.keymap.set("i", "<A-n>", function()
        neocodeium.cycle_or_complete()
      end)
      vim.keymap.set("i", "<A-p>", function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<A-i>", function()
        neocodeium.accept_word()
      end)
      vim.keymap.set("i", "<A-u>", function()
        neocodeium.accept_line()
      end)
      vim.keymap.set("i", "<C-Space>", function()
        neocodeium.clear()
      end)

      local snacks = require("snacks")
      snacks
        .toggle({
          name = "Codeium Completion",
          get = function()
            local status, _ = require("neocodeium").get_status()
            return status == 0
          end,
          set = function(_)
            require("neocodeium.commands").toggle()
          end,
        })
        :map("<leader>an")
      snacks
        .toggle({
          name = "Codeium Server",
          get = function()
            local _, server_status = require("neocodeium").get_status()
            return server_status == 0
          end,
          set = function(state)
            local _, server_status = require("neocodeium").get_status()
            if state then
              if server_status == 2 then
                require("neocodeium.commands").restart()
                require("neocodeium.commands").enable()
              end
            else
              require("neocodeium.commands").disable(true)
            end
          end,
        })
        :map("<leader>aN")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local neocodium_icons = {
        status = {
          [0] = "󰚩 ", -- enabled
          [1] = "󱚧 ", -- disabled globally
          [2] = "󱙻 ", -- disabled for buffer
          [3] = "󱙺 ", -- disabled for buffer filetype
          [4] = "󱙺 ", -- disabled for buffer with enabled function
          [5] = "󱚠 ", -- disabled for buffer encoding
        },
        server_status = {
          [0] = "󰣺 ", -- server connected
          [1] = "󰣻", -- server connecting
          [2] = "󰣽", -- server disconnected
        },
      }
      local neocodeium_status = {
        ---@return string
        function()
          local status, server_status = require("neocodeium").get_status()
          if server_status ~= 0 then
            return neocodium_icons.server_status[server_status]
          end
          return neocodium_icons.status[status]
        end,
        color = function()
          return { fg = Snacks.util.color("Special") }
        end,
      }
      table.insert(opts.sections.lualine_x, 2, neocodeium_status)
    end,
  },
}
