return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    -- "folke/which-key.nvim",
    -- NOTE: Use this PR until merged, fixes winborder issue
    "iguanacucumber/which-key.nvim",
    opts = {
      preset = "classic",
      win = {
        border = "rounded",
        title = true,
        title_pos = "center",
      },
      spec = {
        { "f", desc = "Move to next character" },
        { "F", desc = "Move to prev character" },
        { "t", desc = "Move before next chaacter" },
        { "T", desc = "Move before prev character" },
        { "H", desc = "Prev buffer" },
        { "L", desc = "Next buffer" },
        { "M", desc = "which_key_ignore" },
        { "Y", desc = "Yank to end of line" },
        { "&", desc = "Repeat last substitute" },
        { "%", desc = "Matching character" },
        { "<C-Z>", desc = "which_key_ignore" },
        { ",", desc = "Repeat find character backwards" },
        { ";", desc = "Repeat find character forwards" },
      },
    },
  },
  {
    -- "folke/noice.nvim",
    -- NOTE: Using my own repo here to fix double-bordered scrollbar.
    "Kayzels/noice.nvim",
    branch = "fix-scrollbar",
    config = function(_, opts)
      -- NOTE: Calling explicitly rather than using LazyVim way,
      -- because LazyVim config clears messages
      require("noice").setup(opts)
    end,
    ---@type NoiceConfig
    opts = {
      presets = {
        lsp_doc_border = true,
        command_palette = true,
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
      lsp = {
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = true,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = true,
        },
      },
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {
      default = {
        file = { glyph = "󰦪" },
      },
      filetype = {
        tex = {
          glyph = "󰊄",
        },
      },
    },
  },
  {
    "echasnovski/mini.hipatterns",
    opts = function()
      local hi = require("mini.hipatterns")
      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color(),
          zero_x_hex = {
            pattern = "0x%x%x%x%x%x%x",
            ---@param _ any
            ---@param match string
            group = function(_, match)
              ---@type string
              local color = match:gsub("0x", "#")
              return MiniHipatterns.compute_hex_color_group(color, "bg")
            end,
          },
        },
      }
    end,
    config = function(_, opts)
      require("mini.hipatterns").setup(opts)
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      image = {
        enabled = true,
        doc = {
          enabled = false,
          float = false,
          inline = false,
        },
      },
      terminal = {
        win = { position = "float", border = "rounded" },
      },
      indent = {
        enabled = true,
      },
      scope = {
        enabled = true,
      },
      scroll = {
        enabled = false,
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = function(_, _)
      Snacks.config.style("news", {
        height = 0.6,
        width = 0.6,
        border = "rounded",
        wo = {
          conceallevel = 3,
          signcolumn = "yes",
          spell = false,
          statuscolumn = " ",
          wrap = false,
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      code = {
        sign = true,
      },
      heading = {
        sign = true,
        position = "inline",
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        checkbox = {
          enabled = true,
        },
      },
      checkbox = {
        enabled = true,
      },
      pipe_table = {
        preset = "round",
      },
    },
    --- Even if other config is elsewhere, ft *has* to be set here for it to work
    --- in the buffer types.
    --- Setting it elsewhere means it only works in the first filetype opened.
    ft = { "markdown", "norg", "rmd", "org", "codecompanion", "Avante" },
  },
}
