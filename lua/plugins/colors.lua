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
        colors.bg_statusline = colors.none
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
          bg = c.bg_dark,
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
        hl["lualine_c_normal"] = "NONE"
        hl["lualine_c_inactive"] = "NONE"
        hl["@markup.strong"] = {
          bold = true,
          fg = c.green,
        }
        hl.TelescopeSelection = hl.Visual
        hl.TabLineFill = "NONE"
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- Set high priority so that it shows in Telescope colorscheme list
    priority = 1000,
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
        local groups = {
          texCConceptArg = { fg = colors.sky, style = { "bold" } },
          -- texCConceptArg = { fg = colors.maroon, style = { "bold" } },
          texItemLabelConcealed = { link = "texCConceptArg" },
          cmpGhostText = { fg = colors.surface0 },
          texPartArgTitle = { link = "Function" },
          texGroup = { fg = colors.maroon, style = { "bold " } },
          -- MatchParen = { fg = colors.peach, bg = colors.none, style = { "bold" } },
          TelescopeSelection = { fg = colors.text, bg = colors.surface0, style = { "bold" } },
          Folded = { fg = colors.blue, bg = colors.surface0 },
          -- Change comment back to original overlay0: the change to overlay2 makes it harder
          -- to distinguish comments from code.
          -- Not sure how to access opts table, so setting style here as well.
          Comment = { fg = colors.overlay0, style = { "italic" } },
          YankyPut = { link = "Search" },
          YankyYanked = { link = "IncSearch" },
        }
        local darken = require("catppuccin.utils.colors").darken
        local rainbow = {
          colors.red,
          colors.peach,
          colors.yellow,
          colors.green,
          colors.sapphire,
          colors.lavender,
        }
        for i = 1, 6 do
          local color = rainbow[i]
          groups["RenderMarkdownH" .. i] = { fg = color, style = { "bold" } }
          -- groups["RenderMarkdownH" .. i .. "Bg"] = { bg = darken(color, 0.10, colors.base) }
          groups["RenderMarkdownH" .. i .. "Bg"] = { bg = darken(color, 0.10, colors.mantle) }
        end
        return groups
      end,
      integrations = {
        mini = {
          enabled = true,
          indentscope_color = "sky",
        },
        which_key = false,
        render_markdown = false,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = require("functions.theme").setColorScheme,
    },
  },
}
