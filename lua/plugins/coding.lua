return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
    end,
  },
  {
    -- Allow tabbing out of pair
    "abecodes/tabout.nvim",
    dependencies = { "nvim-treesitter", "nvim-cmp" },
    opts = {},
  },
}
