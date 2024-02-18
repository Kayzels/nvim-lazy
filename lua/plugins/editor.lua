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
}
