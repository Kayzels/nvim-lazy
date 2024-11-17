-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.pumblend = 0 -- Make popups transparent
vim.opt.foldtext = ""
-- vim.g.autoformat = false
vim.opt.listchars:append({ tab = " " })
vim.opt.scrolloff = 10

vim.opt.showtabline = 1

-- Appearance for diagnostic popups
vim.diagnostic.config({
  float = { border = "rounded" },
})

local uname = vim.uv.os_uname()
local currentOS = uname.sysname
local isWin = currentOS:lower():find("windows") and true or false
local isLinux = currentOS:lower():find("linux") and true or false
local isWSL = isLinux and (uname.version:lower():find("microsoft") and true or false)

if isWin then
  vim.g.python3_host_prog = "C:\\Users\\Kyzan\\Tools\\nvim-venv\\Scripts\\python.exe"
  LazyVim.terminal.setup("pwsh")
end

if isWSL then
  _G.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.opt.formatoptions = "jcroqlt"

vim.g.lazyvim_statuscolumn = {
  folds_open = false,
  folds_githl = true,
}

-- Don't let LazyVim set the theme for lazygit, because it messes up Wezterm theme change
vim.g.lazygit_config = false
