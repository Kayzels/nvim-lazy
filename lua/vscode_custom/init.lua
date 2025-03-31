local recursive_options = { remap = true, silent = true }
local default_options = { remap = false, silent = true }

---Create a mapping in the given mode to a certain command for a given shortcut
---By default, nonrecursive remapping.
---@param mode string|table
---@param shortcut string
---@param command string|function
---@param options table|nil
local function map(mode, shortcut, command, options)
  options = options or default_options
  vim.keymap.set(mode, shortcut, command, options)
end

---Create a recursive mapping for a given shortcut and command in the given modes
---@param mode string|table
---@param shortcut string
---@param command string|function
---@param options table|nil
local function remap(mode, shortcut, command, options)
  options = options or recursive_options
  map(mode, shortcut, command, options)
end

---Recursive mapping function for normal mode
---@param shortcut string
---@param command string|function
---@param options table|nil
local function nremap(shortcut, command, options)
  options = options or recursive_options
  remap("n", shortcut, command, options)
end

---Nonrecursive mapping function for normal mode
---@param shortcut string
---@param command string|function
---@param options table|nil
local function nmap(shortcut, command, options)
  options = options or default_options
  map("n", shortcut, command, options)
end

local vscode = require("vscode-neovim")

---Create a higher-level function that returns a function for mappings
---@param command string
---@return function
local function vsCodeCaller(command)
  local function inner()
    vscode.call(command)
  end
  return inner
end

-- WhichKey
map({ "x", "n" }, "<Space>", vsCodeCaller("whichkey.show"))

-- Folding
nmap("zM", vsCodeCaller("editor.foldAll"))
nmap("zR", vsCodeCaller("editor.unfoldAll"))
nmap("zc", vsCodeCaller("editor.fold"))
nmap("zC", vsCodeCaller("editor.foldRecursively"))
nmap("zo", vsCodeCaller("editor.unfold"))
nmap("zO", vsCodeCaller("editor.unfoldRecursively"))
nmap("za", vsCodeCaller("editor.toggleFold"))

---Set cursor text to gj or gk when navigating over folds or wraps
---@param direction string
---@return string
local function moveCursor(direction)
  if vim.fn.reg_recording() == "" and vim.fn.reg_executing() == "" then
    return "g" .. direction
  else
    return direction
  end
end

nremap("j", moveCursor("j"), { noremap = false })
nremap("k", moveCursor("k"), { noremap = false })
