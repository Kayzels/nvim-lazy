return {
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = "rounded",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local custom_auto = require("lualine.themes.auto")
      custom_auto.normal.c.bg = "None"
      opts.options = {
        theme = custom_auto,
        section_separators = { left = "", right = "" },
        component_separators = "▎",
      }
    end,
  },
}
