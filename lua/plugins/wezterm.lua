return {
  {
    "willothy/wezterm.nvim",
    keys = {
      {
        "<leader>Wt",
        function()
          local tab_title = vim.fn.input("Enter new tab title: ")
          if not tab_title then
            return
          else
            require("wezterm").set_tab_title(tab_title)
          end
        end,
        desc = "Set Wezterm Tab Title",
      },
    },
    opts = {},
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>W", group = "Wezterm" },
      },
    },
  },
}
