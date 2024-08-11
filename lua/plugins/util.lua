return {
  {
    "folke/persistence.nvim",
    enabled = false,
  },
  {
    "telescope.nvim",
    opts = {
      defaults = {
        file_ignore_patterns = { "%.png", "%.jpg", "%.jpeg", "%.pdf" },
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
      },
    },
    dependencies = {
      {
        "olimorris/persisted.nvim",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "SessionLoad", "SessionSave", "SessionLoadLast", "SessionStop" },
        config = function(_, opts)
          require("persisted").setup(opts)
          require("lazyvim.util").on_load("telescope.nvim", function()
            require("telescope").load_extension("persisted")
          end)
        end,
        keys = {
          { "<leader>fp", "<Cmd>Telescope persisted<cr>", desc = "Sessions" },
          { "<leader>qr", "<Cmd>SessionSave<cr>", desc = "Save Session" },
          { "<leader>qs", "<Cmd>SessionLoad<cr>", desc = "Load session for cwd" },
          { "<leader>ql", "<Cmd>SessionLoadLast<cr>", desc = "Load last session" },
          { "<leader>qx", "<Cmd>SessionStop<cr>", desc = "Stop recording a session" },
          { "<leader>qd", "<Cmd>SessionDelete<cr>", desc = "Delete current session" },
        },
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    optional = true,
    opts = function(_, opts)
      local sessions = {
        action = "Telescope persisted",
        desc = "Sessions",
        icon = "  ",
        key = "p",
      }
      local load = {
        action = "SessionLoadLast",
        desc = "Restore Session",
        icon = "  ",
        key = "s",
      }
      local last = {
        action = "SessionLoad",
        desc = "Restore Session for cwd",
        icon = "  ",
        key = "o", -- for "old"
      }

      sessions.desc = sessions.desc .. string.rep(" ", 43 - #sessions.desc)
      sessions.key_format = "  %s"
      load.desc = load.desc .. string.rep(" ", 43 - #load.desc)
      load.key_format = "  %s"
      last.desc = last.desc .. string.rep(" ", 43 - #last.desc)
      last.key_format = "  %s"

      table.insert(opts.config.center, 3, sessions)
      table.remove(opts.config.center, 7) -- remove persistence one
      table.insert(opts.config.center, 7, load)
      table.insert(opts.config.center, 8, last)
    end,
  },
}
