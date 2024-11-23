---@class TextCaseMapping
---@field key string
---@field case string
---@field lsp string
---@field desc string

---@param opts TextCaseMapping
local function setMapping(opts)
  local key = opts.key
  local case = opts.case
  local lsp = opts.lsp
  local desc = opts.desc
  local n_mode = {
    "ga" .. key,
    function()
      require("textcase").current_word(case)
    end,
    desc = "Convert " .. desc,
  }
  local lsp_mode = {
    "ga" .. lsp,
    function()
      require("textcase").lsp_rename(case)
    end,
    desc = "LSP rename " .. desc,
  }
  local op_mode = {
    "gao" .. key,
    function()
      require("textcase").operator(case)
    end,
    desc = desc,
  }
  local x_mode = {
    "ga" .. key,
    function()
      require("textcase").operator(case)
    end,
    desc = "Convert " .. desc,
    mode = { "x" },
  }
  return { n_mode, lsp_mode, op_mode, x_mode }
end

local function setTextCaseMappings()
  require("which-key").add({ "ga", group = "Text Case" })
  require("which-key").add({ "gao", group = "Pending Mode Operator" })
  ---@type TextCaseMapping[]
  local defs = {
    { key = "u", case = "to_upper_case", lsp = "U", desc = "TO UPPER CASE" },
    { key = "l", case = "to_lower_case", lsp = "L", desc = "to lower case" },
    { key = "s", case = "to_snake_case", lsp = "S", desc = "to_snake_case" },
    { key = "k", case = "to_dash_case", lsp = "K", desc = "to-kebab-case" },
    { key = "n", case = "to_constant_case", lsp = "N", desc = "TO_CONSTANT_CASE" },
    { key = "d", case = "to_dot_case", lsp = "D", desc = "to.dot.case" },
    { key = "c", case = "to_camel_case", lsp = "C", desc = "toCamelCase" },
    { key = "p", case = "to_pascal_case", lsp = "P", desc = "ToPascalCase" },
    { key = "t", case = "to_title_case", lsp = "T", desc = "To Title Case" },
    { key = "/", case = "to_path_case", lsp = "?", desc = "to/path/case" },
    { key = "f", case = "to_phrase_case", lsp = "F", desc = "To phrase case" },
  }

  local mappings = {}
  table.insert(mappings, { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" })
  for _, def in ipairs(defs) do
    local mapping = setMapping(def)
    for _, v in ipairs(mapping) do
      table.insert(mappings, v)
    end
  end

  return mappings
end

-- NOTE: cmp sources are placed in a separate file, so they can be called separately.

return {
  -- "tpope/vim-sleuth",
  { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
  { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
  { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
  "https://codeberg.org/FelipeLema/cmp-async-path",
  {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
  },
  {
    "nvim-cmp",
    dependencies = {
      "micangl/cmp-vimtex",
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      opts.matching = {
        disallow_fuzzy_matching = false,
      }

      opts.mapping = {
        ["<CR>"] = nil,
        -- ["<S-CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-CR>"] = cmp.mapping.confirm({ select = true }),
        ["<S-Space>"] = cmp.mapping.abort(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        -- ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
      }

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, item)
          item.abbr = string.sub(item.abbr, 1, 50)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            local icon = icons[item.kind]
            local menu = item.kind
            local origMenu = item.menu
            item.menu = "    (" .. (menu or "") .. ")"
            if entry.source.name == "vimtex" then
              ---@param menuString string
              ---@return string
              local removePackage = function(menuString)
                local newString = menuString:gsub("%b[]%s*", "")
                return newString
              end
              item.menu = item.menu .. removePackage(origMenu)
            end
            item.kind = icon .. "│"
          end

          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
              item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
            end
          end

          return item
        end,
      }
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      opts.update_events = "TextChanged,TextChangedI"
      opts.enable_autosnippets = true
      opts.store_selection_keys = "<Tab>"
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = vim.fn.stdpath("config") .. "/lua/snippets/vscode/",
      })
      require("luasnip.loaders.from_lua").load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets/luasnippets/" },
      })
    end,
    dependencies = {
      "kawre/neotab.nvim",
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({
            exclude = { "tex" }, -- ignore friendly snippets tex
          })
        end,
      },
      {
        "nvim-cmp",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          }
        end,
      },
    },
    keys = {
      {
        "<tab>",
        false,
        mode = "i",
      },
      {
        "<c-tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<Plug>(neotab-out)"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
    },
  },
  {
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
      pairs = {
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "`", close = "'" },
        { open = "<", close = ">" },
        { open = "$", close = "$" },
      },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    vscode = true,
    opts = {
      skipInsignificantPunctuation = false,
    },
    keys = {
      {
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        mode = { "n", "o", "x" },
        desc = "Next word",
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
        desc = "Next end of word",
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
        desc = "Previous end of word",
      },
    },
  },
  {
    -- NOTE: Changed from using theutz fork, but PR wasn't merged.
    -- Implemented the changes in the function I call in keys.
    "johmsalas/text-case.nvim",
    vscode = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "folke/which-key.nvim",
    },
    config = function(_, opts)
      require("textcase").setup(opts)
      require("telescope").load_extension("textcase")
    end,
    opts = {
      default_keymappings_enabled = false,
    },
    keys = setTextCaseMappings,
    cmd = {
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
  },
  {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = true,
    cmd = {
      "TSCppDefineClassFunc",
      "TSCppMakeConcreteClass",
      "TSCppRuleOf3",
      "TSCppRuleOf5",
    },
    opts = {
      preview = {
        quit = "q",
        accept = "<tab>",
      },
    },
    keys = {
      { "<localleader>ctf", "<cmd>TSCppDefineClassFunc<cr>", desc = "Create Function Implementation" },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      config = {
        cpp = "// %s",
      },
    },
  },
  {
    "nvim-cmp",
    dependencies = {
      "kawre/neotab.nvim",
    },
    keys = {
      {
        "<Tab>",
        false,
        mode = { "i", "s" },
      },
      {
        "<C-Tab>",
        function()
          return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Plug>(neotab-out)"
        end,
        expr = true,
        silent = true,
        mode = { "i", "s" },
      },
    },
  },
  {
    "nvim-cmp",
    event = "CmdlineEnter",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
    },
    opts = function()
      local cmp = require("cmp")
      cmp.setup.cmdline(":", {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "cmdline" },
          { name = "cmdline_history" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer", max_item_count = 3, keyword_length = 2 },
        },
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    --- NOTE: Calling config explicitly, because LazyVim overrides the minipairs open method.
    config = function(_, opts)
      Snacks.toggle({
        name = "Mini Pairs",
        get = function()
          return not vim.g.minipairs_disable
        end,
        set = function(state)
          vim.g.minipairs_disable = not state
        end,
      }):map("<leader>up")
      require("mini.pairs").setup(opts)
    end,
  },
  {
    "nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(require("config.cmp_sources").sources)
      cmp.setup.filetype(
        { "tex", "latex", "sty" },
        { sources = cmp.config.sources(require("config.cmp_sources").tex_sources) }
      )
    end,
  },
}
