return {
  {
    "telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = {
          "%.png",
          "%.jpg",
          "%.jpeg",
          "%.pdf",
          "%.pygtex",
          "%.gz",
          "%.fdb_latexmk",
          "%.fls",
          "%.aux",
        },
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
      },
    },
  },
}
