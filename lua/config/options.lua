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

if vim.fn.has("win32") == 1 then
  vim.g.python3_host_prog = "C:\\Users\\Kyzan\\Tools\\nvim-venv\\Scripts\\python.exe"
  LazyVim.terminal.setup("pwsh")
end

if vim.fn.has("wsl") == 1 then
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

  vim.g.python3_host_prog = "/usr/bin/python3"
end

if vim.fn.has("linux") then
  vim.opt.shell = "fish"
  -- vim.opt.clipboard = "unnamed"
  vim.opt.clipboard = ""
end

vim.opt.formatoptions = "jcroqlt"

vim.g.lazyvim_statuscolumn = {
  folds_open = false,
  folds_githl = true,
}

-- Don't let LazyVim set the theme for lazygit, because it messes up Wezterm theme change
vim.g.lazygit_config = false

-- Disable perl and ruby providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Set cursor shapes
vim.opt.guicursor =
  "n-v-c-sm:block,i-ci-ve:ver25-blinkon1200-blinkoff1200,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"
