return {
  {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    dependencies = { "kkharji/sqlite.lua" },
    opts = {
      extensions = {
        lazy_nvim = {
          auto_register = true,
        },
        which_key = {
          auto_register = true,
        },
      },
    },
  },
  {
    "otavioschwanck/arrow.nvim",
    opts = function(_, opts)
      opts.show_icons = true
      opts.leader_key = "<leader>\\"
      local width = 50
      local col = math.ceil((vim.o.columns - width) / 2)
      opts.window = {
        width = width,
        col = col,
      }
    end,
    keys = {
      { "<leader>\\", desc = "Arrow" },
    },
  },
  {
    "RRethy/vim-illuminate",
    enabled = false,
  },
}
