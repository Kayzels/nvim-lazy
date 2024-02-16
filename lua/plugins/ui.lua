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
      custom_auto.inactive.c.bg = "None"
      opts.options = {
        theme = custom_auto,
        section_separators = { left = "", right = "" },
        component_separators = "▎",
        disabled_filetypes = {
          tabline = { "neo-tree", "dashboard" },
          winbar = { "neo-tree", "dashboard" },
        },
      }
      opts.winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          { "filetype", icon_only = true, colored = false, separator = "" },
          { "filename", file_status = true, padding = { left = 0, right = 2 } },
        },
      }
      opts.inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          { "filename", file_status = true, separator = "" },
          { "filetype", icon_only = true, colored = false },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }
      opts.tabline = {
        lualine_a = { "tabs" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "windows" },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
