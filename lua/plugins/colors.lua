return {
  {
    "folke/tokyonight.nvim",
    -- Set high priority so that it shows in Telescope colorscheme list
    priority = 1000,
    opts = {
      style = "moon",
      -- opts.transparent = false
      transparent = true,
      terminal_colors = false,
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = { bold = true },
        variables = {},
        -- sidebars = "normal",
        -- floats = "normal",
        sidebars = "transparent",
        floats = "transparent",
      },
      dim_inactive = true,
      lualine_bold = true,
      on_colors = function(colors)
        -- colors.bg = "#1d262a"
        -- colors.bg_dark = colors.bg
        -- colors.bg_float = colors.bg
        -- colors.bg_sidebar = colors.bg
        local git_add = colors.green
        local git_change = colors.blue1
        local git_delete = colors.red
        colors.git.add = git_add
        colors.git.change = git_change
        colors.git.delete = git_delete
        colors.gitSignsAdd = git_add
        colors.gitSignsChange = git_change
        colors.gitSignsDelete = git_delete
      end,
      on_highlights = function(hl, c)
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
      end,
    },
  },
  {
    "https://github.com/catppuccin/nvim",
    -- Set high priority so that it shows in Telescope colorscheme list
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(opts)
    end,
    opts = {
      flavour = "latte",
      transparent_background = true,
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
          texCConceptArg = { fg = colors.sky, style = { "bold" } },
          -- texCConceptArg = { fg = colors.maroon, style = { "bold" } },
          texItemLabelConcealed = { link = "texCConceptArg" },
          cmpGhostText = { fg = colors.surface0 },
          texPartArgTitle = { link = "Function" },
          texGroup = { fg = colors.maroon, style = { "bold " } },
          MatchParen = { fg = colors.peach, bg = colors.none, style = { "bold" } },
          TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = { "bold" } },
          Folded = { fg = colors.blue, bg = colors.surface0 },
        }
      end,
      integrations = {
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        leap = true,
        mini = {
          enabled = true,
          indentscope_color = "sky",
        },
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
      colorscheme = require("config.functions").setColorScheme,
    },
  },
}
