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

if vim.fn.has("win32") and not vim.fn.has("wsl") then
  vim.g.python3_host_prog = "C:\\Users\\Kyzan\\Tools\\nvim-venv\\Scripts\\python.exe"
  LazyVim.terminal.setup("pwsh")
end

if vim.fn.has("wsl") then
  -- xclip is significantly faster than the suggestion in docs.
  -- It requires $DISPLAY to be set,
  -- which is done by WSL2 automatically if gui is enabled
  vim.g.clipboard = {
    name = "xclip-wsl",
    copy = {
      ["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
      ["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
    },
    paste = {
      ["+"] = { "xclip", "-o", "-selection", "clipboard" },
      ["*"] = { "xclip", "-o", "-selection", "primary" },
    },
    cache_enabled = 1, -- cache MUST be enabled, or else it hangs on dd/y/x and all other copy operation
  }
end

vim.opt.formatoptions = "jcroqlt"

vim.g.lazyvim_statuscolumn = {
  folds_open = false,
  folds_githl = true,
}

-- Don't let LazyVim set the theme for lazygit, because it messes up Wezterm theme change
vim.g.lazygit_config = false
