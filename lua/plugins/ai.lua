return {
  {
    "monkoose/neocodeium",
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

      vim.keymap.set("i", "<S-CR>", function()
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
      vim.keymap.set("i", "<S-Space>", function()
        neocodeium.clear()
      end)
    end,
  },
}
