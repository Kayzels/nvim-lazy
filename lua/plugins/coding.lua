return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = vim.fn.stdpath("config") .. "/lua/snippets/vscode/",
      })
    end,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load({
          exclude = { "tex" }, -- ignore friendly snippets tex
        })
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "micangl/cmp-vimtex" },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      table.insert(opts.sources, { name = "vimtex" })
    end,
  },
}
