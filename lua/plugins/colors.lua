return {
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "dark",
      transparent = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      opts.transparent = true
      opts.styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = { bold = true },
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      }
      opts.dim_inactive = true
      opts.lualine_bold = true
      opts.on_highlights = function(hl, c)
        hl.VertSplit = {
          fg = c.border_highlight,
        }
        hl.WinSeparator = {
          fg = c.border_highlight,
        }
        hl.NeoTreeTitleBar = {
          fg = c.border_highlight,
        }
        hl.ColorColumn = {
          bg = c.bg_highlight,
        }
        hl.Folded = {
          bg = c.bg_statusline,
        }
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
