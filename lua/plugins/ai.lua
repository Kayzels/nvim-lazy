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

      vim.keymap.set("i", "<A-f>", function()
        neocodeium.accept()
      end)
      vim.keymap.set("i", "<A-w>", function()
        neocodeium.accept_word()
      end)
      vim.keymap.set("i", "<A-a>", function()
        neocodeium.accept_line()
      end)
      vim.keymap.set("i", "<A-e>", function()
        neocodeium.cycle_or_complete()
      end)
      vim.keymap.set("i", "<A-r>", function()
        neocodeium.cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<A-c>", function()
        neocodeium.clear()
      end)
    end,
  },
}
