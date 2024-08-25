return {
  {
    "folke/tokyonight.nvim",
    -- Set high priority so that it shows in Telescope colorscheme list
    priority = 1000,
    opts = function(_, opts)
      opts.style = "moon"
      opts.transparent = true
      opts.terminal_colors = false
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
      opts.on_colors = function(colors)
        local git_add = colors.green
        local git_change = colors.blue1
        local git_delete = colors.red
        colors.git.add = git_add
        colors.git.change = git_change
        colors.git.delete = git_delete
        colors.gitSignsAdd = git_add
        colors.gitSignsChange = git_change
        colors.gitSignsDelete = git_delete
      end
      opts.on_highlights = function(hl, c)
        local neotree_dim = "#4f5882"
        local neotree_dark = "#444c70"
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
        hl.NeoTreeDimText = {
          fg = neotree_dim,
        }
        hl.NeoTreeFileStats = {
          fg = neotree_dim,
        }
        hl.NeoTreeMessage = {
          fg = neotree_dark,
          italic = true,
        }
        hl.texCConceptArg = {
          bold = true,
          fg = c.green,
        }
        hl.texItemLabelConcealed = hl.texCConceptArg
        hl["@module"] = {
          fg = c.yellow,
        }
        hl["@lsp.type.namespace.python"] = { link = "@module" }
        hl["@string.documentation"] = {
          fg = "#636da6",
        }
        hl["@text.title"] = {
          bold = true,
          fg = c.blue,
        }
        hl["@text.property"] = {
          fg = c.yellow,
        }
        hl.texPartArgTitle = hl.Function
        hl.texGroup = {
          fg = c.yellow,
        }
      end
    end,
  },
  {
    "https://github.com/catppuccin/nvim",
    -- Set high priority so that it shows in Telescope colorscheme list
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
    opts = {
      term_colors = false,
      -- term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = { "italic" },
        conditionals = {},
        keywords = {},
        functions = { "bold" },
      },
      custom_highlights = function(colors)
        return {
          texCConceptArg = { fg = colors.maroon, style = { "bold" } },
          texItemLabelConcealed = { link = "texCConceptArg" },
          cmpGhostText = { fg = colors.surface0 },
          texPartArgTitle = { link = "Function" },
        }
      end,
      integrations = {
        cmp = true,
        dashboard = true,
        gitsigns = true,
        leap = true,
        noice = true,
        notify = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
      -- colorscheme = "catppuccin-latte",
    },
  },
}
