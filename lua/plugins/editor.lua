return {
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
      { "<localleader>\\", desc = "Arrow" },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
      {
        "<leader>y",
        function()
          require("yazi").yazi()
        end,
        desc = "Explorer Yazi",
      },
    },
    opts = {
      open_for_directories = false,
      log_level = vim.log.levels.DEBUG,
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
  },
}
