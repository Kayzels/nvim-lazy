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
      },
      {
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        mode = { "n", "o", "x" },
      },
      {
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        mode = { "n", "o", "x" },
      },
    },
  },
  {
    -- NOTE: Only using this fork until merged into "johmsalas/text-case.nvim"
    "theutz/text-case.nvim",
    vscode = true,
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup()
      require("telescope").load_extension("textcase")
    end,
    keys = function()
      vim.keymap.set({ "n", "x" }, "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
      return {
        { "ga" },
      }
    end,
    cmd = {
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    lazy = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
    vscode = true,
  },
  {
    "b0o/SchemaStore.nvim",
    version = false,
  },
  {
    "danymat/neogen",
    opts = {
      snippet_engine = "luasnip",
    },
    keys = {
      { "<leader>cnn", "<cmd>Neogen<cr>", desc = "Generate docs" },
      { "<leader>cnf", "<cmd>Neogen func<cr>", desc = "Generate function docs" },
      { "<leader>cnF", "<cmd>Neogen file<cr>", desc = "Generate file docs" },
      { "<leader>cnc", "<cmd>Neogen class<cr>", desc = "Generate class docs" },
      { "<leader>cnt", "<cmd>Neogen type<cr>", desc = "Generate type docs" },
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
      { "<leader>ctf", "<cmd>TSCppDefineClassFunc<cr>", desc = "Create Function Implementation" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>cn"] = { name = "+neogen" },
        ["<leader>ct"] = { name = "+tools (CPP)" },
      },
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
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({})
    end,
    ft = { "md" },
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
}
