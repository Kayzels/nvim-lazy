return {
  {
    "willothy/wezterm.nvim",
    config = function(_, opts)
      require("wezterm").setup(opts)

      require("wezterm").set_tab_title("nvim")
    end,
  },
}
