vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Neotree focus" })

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      popup_border_style = "rounded",
      sort_case_insensitive = true,
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = { enabled = true },
        hijack_netrw_behaviour = "open_current",
        filtered_items = {
          always_show = {
            ".gitignore",
          },
        },
        group_empty_dirs = true,
      },
      window = {
        position = "float",
      },
      window_mappings = {
        function(state)
          local node = state.tree:get_node()
          if require("neo-tree.utils").is_expandable(node) then
            state.commands["toggle_node"](state)
          else
            state.commands["open"](state)
            vim.cmd("Neotree reveal")
          end
        end,
        desc = "Open and keep Neotree focus",
      },
    },
  },
}
