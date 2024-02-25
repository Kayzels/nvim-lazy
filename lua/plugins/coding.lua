return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")

      ls.config.set_config({
        history = true,
        update_events = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      })

      require("luasnip.loaders.from_vscode").lazy_load({
        paths = vim.fn.stdpath("config") .. "/lua/snippets/vscode/",
      })
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets/luasnippets/" },
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
    keys = {
      { "<Tab>", mode = { "i", "s" }, false },
      { "<S-Tab>", mode = { "i", "s" }, false },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "micangl/cmp-vimtex",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "vimtex" },
        { name = "luasnip" },
        { name = "buffer" },
      })
      opts.mapping["<CR>"] = nil
      opts.mapping["<S-CR>"] = cmp.mapping.confirm({ select = true })
      opts.mapping["<C-CR>"] = cmp.mapping.confirm({ select = true })
      opts.mapping["<S-Space>"] = cmp.mapping.abort()
      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" })
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })
      opts.formatting = {
        format = function(entry, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          item.menu = ({
            vimtex = item.menu,
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            path = "[Path]",
          })[entry.source.name]
          return item
        end,
      }
    end,
  },
  {
    "max397574/better-escape.nvim",
    opts = {
      mapping = { "jj", "jk", "kk", "kj" },
      timeout = vim.o.timeoutlen,
      clear_empty_lines = false,
      keys = "<Esc>",
    },
  },
  {
    "abecodes/tabout.nvim",
    lazy = false,
    opts = {},
    keys = {
      {
        "<A-x>",
        "<Plug>(TaboutMulti)",
        mode = "i",
        desc = "Tabout Multi",
      },
      {
        "<A-z>",
        "<Plug>(TaboutBackMulti)",
        mode = "i",
        desc = "Tabout Back Multi",
      },
    },
  },
}
