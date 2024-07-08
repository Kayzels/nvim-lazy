local M = {}

---@param increment boolean
---@param g? boolean
function M.dialmap(increment, g)
  local result = "<Plug>(dial-"
  local direction = increment and "increment" or "decrement"
  result = g and "g" .. result or result
  result = result .. direction .. ")"
  return result
end

return {
  "monaqa/dial.nvim",
  vscode = true,
  keys = {
    {
      "<C-a>",
      M.dialmap(true),
      desc = "Increment",
      mode = { "n", "v" },
    },
    {
      "<C-x>",
      M.dialmap(false),
      desc = "Decrement",
      mode = { "n", "v" },
    },
    {
      "g<C-a>",
      M.dialmap(true, true),
      desc = "Increment",
      mode = { "n", "v" },
      remap = true,
    },
    {
      "g<C-x>",
      M.dialmap(false, true),
      desc = "Decrement",
      mode = { "n", "v" },
      remap = true,
    },
  },
  opts = function()
    local augend = require("dial.augend")

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local logical_word = augend.constant.new({
      elements = { "and", "or" },
      word = true,
      cyclic = true,
    })

    local ordinal_numbers = augend.constant.new({
      -- elements through which we cycle. When we increment, we go down
      -- On decrement we go up
      elements = {
        "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth",
      },
      -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
      word = false,
      -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
      -- Otherwise nothing will happen when there are no further values
      cyclic = true,
    })

    local weekdays = augend.constant.new({
      elements = {
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      },
      word = true,
      cyclic = true,
    })

    local months = augend.constant.new({
      elements = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      },
      word = true,
      cyclic = true,
    })

    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    return {
      dials_by_ft = {
        css = "css",
        sass = "css",
        scss = "css",
        javascript = "typescript",
        javascriptreact = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        python = "python",
      },
      groups = {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          weekdays,
          months,
          ordinal_numbers,
        },
        typescript = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          logical_alias,
          augend.constant.new({ elements = { "let", "const" } }),
          ordinal_numbers,
          weekdays,
          months,
        },
        css = {
          augend.integer.alias.decimal,
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
        markdown = {
          augend.misc.alias.markdown_header,
          ordinal_numbers,
          weekdays,
          months,
        },
        json = {
          augend.integer.alias.decimal,
          augend.semver.alias.semver,
          augend.constant.alias.bool,
        },
        lua = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          logical_word,
          ordinal_numbers,
          weekdays,
          months,
        },
        python = {
          augend.integer.alias.decimal,
          capitalized_boolean,
          logical_word,
          ordinal_numbers,
          weekdays,
          months,
        },
        cpp = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool,
          weekdays,
          months,
          ordinal_numbers,
          logical_alias,
        },
      },
    }
  end,
  config = function(_, opts)
    require("dial.config").augends:register_group(opts.groups)
  end,
}
