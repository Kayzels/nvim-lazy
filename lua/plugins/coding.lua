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

return {
  "tpope/vim-sleuth",
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
          table.insert(opts.sources, { name = "luasnip" })
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
    "hrsh7th/nvim-cmp",
    dependencies = {
      "micangl/cmp-vimtex",
      "saadparwaiz1/cmp_luasnip",
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
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        {
          name = "vimtex",
          -- option = {
          --   additional_information = {
          --     info_in_menu = false,
          --   },
          -- },
        },
        { name = "luasnip" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              local bufs = vim.api.nvim_list_bufs()
              --- @type integer[]
              local new_bufs = {}

              ---Check if the buffer is valid
              ---@param bufnr number
              ---@return number | nil
              local function valid_bufnr(bufnr)
                if vim.api.nvim_buf_get_name(bufnr) == "" then
                  return
                end

                local ignore_patterns = { "out", "pygtex", "gz", "fdb_latexmk", "fls", "aux", "log" }

                -- local filename = vim.fn.bufname(bufnr)
                local filename = vim.api.nvim_buf_get_name(bufnr)
                local extension = vim.fn.fnamemodify(filename, ":e")
                if extension == "" or extension == nil then
                  return
                end
                for _, pattern in ipairs(ignore_patterns) do
                  if string.find(string.lower(extension), pattern, 1) == nil then
                    return bufnr
                  end
                end
              end

              for _, bufnr in pairs(bufs) do
                local num = valid_bufnr(bufnr)
                if num ~= nil then
                  new_bufs[#new_bufs + 1] = num
                end
              end

              return new_bufs
            end,
          },
        },
      })
      opts.mapping["<CR>"] = nil
      opts.mapping["<S-CR>"] = cmp.mapping.confirm({ select = true })
      opts.mapping["<C-CR>"] = cmp.mapping.confirm({ select = true })
      opts.mapping["<S-Space>"] = cmp.mapping.abort()
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
          return item
        end,
      }
    end,
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
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },
}
