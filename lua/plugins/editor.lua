return {
  {
    "mikavilpas/yazi.nvim",
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
          enabled = false,
        },
      },
    },
  },
}
