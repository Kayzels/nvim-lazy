return {
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {
      floating = false,
      insert_mode = true,
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
    "dstein64/nvim-scrollview",
    event = "LazyFile",
    opts = {
      always_show = true,
      current_only = true,
      excluded_filetypes = { "snacks_dashboard", "TelescopePrompt", "Noice", "neo-tree" },
    },
  },
  {
    "dstein64/nvim-scrollview",
    opts = function(_, opts)
      require("scrollview.contrib.gitsigns").setup()
    end,
  },
}
