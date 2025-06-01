return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "ibhagwan/fzf-lua",
      "zbirenbaum/copilot.lua",
    },
    opts = {
      provider = "copilot",
      auto_suggestions_provider = nil,
      behaviour = {
        auto_suggestions = false,
      },
      gemini = {
        api_key_name = 'cmd:kwallet-query -f "CodeCompanion" -r Gemini kdewallet',
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      { "Kaiser-Yang/blink-cmp-avante" },
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { "avante" },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            score_offset = 100,
            opts = {
              kind_icons = {
                Avante = "󰖷 ",
              },
            },
          },
        },
      },
    },
  },
}
