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
      "folke/which-key.nvim",
    },
    config = function(_, opts)
      require("textcase").setup(opts)
    end,
    opts = {
      default_keymappings_enabled = false,
    },
    keys = setTextCaseMappings,
    cmd = {
      "Subs",
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
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
  },
  {
    "gbprod/yanky.nvim",
    opts = {
      ring = {
        permanent_wrapper = require("yanky.wrappers").remove_carriage_return,
      },
    },
  },
}
