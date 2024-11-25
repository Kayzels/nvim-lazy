return {
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {
      floating = false,
      insert_mode = false,
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      smear_between_neighbor_lines = false,
      use_floating_windows = false,
      legacy_computing_symbols_support = false,
    },
  },
  {
    "lewis6991/satellite.nvim",
    opts = {
      winblend = 0,
      handlers = {
        cursor = {
          enable = true,
          symbols = { "•" },
        },
        gitsigns = {
          enable = true,
          signs = {
            add = "▎",
            change = "▎",
            delete = "",
          },
        },
      },
    },
  },
  -- {
  --   "dstein64/nvim-scrollview",
  --   event = "LazyFile",
  --   opts = {
  --     -- always_show = true,
  --     current_only = true,
  --     excluded_filetypes = { "snacks_dashboard", "TelescopePrompt", "Noice", "neo-tree" },
  --   },
  -- },
  -- {
  --   "dstein64/nvim-scrollview",
  --   opts = function(_, opts)
  --     require("scrollview.contrib.gitsigns").setup()
  --   end,
  -- },
}
