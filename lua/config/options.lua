-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.pumblend = 0 -- Make popups transparent
vim.opt.foldtext = ""
-- vim.g.autoformat = false
vim.opt.listchars:append({ tab = " " })
vim.opt.scrolloff = 10

-- Appearance for diagnostic popups
vim.diagnostic.config({
  float = { border = "rounded" },
})

vim.g.python3_host_prog = "C:\\Users\\Kyzan\\Tools\\nvim-venv\\Scripts\\python.exe"

local function setPowershell()
  vim.opt.shell = "powershell"
  if vim.fn.executable("pwsh") then
    vim.opt.shell = "pwsh"
  end
  vim.opt.shellcmdflag =
    "-NoProfile -NoLogo -ExecutionPolicy RemoteSigned -NonInteractive -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering = [System.Management.Automation.OutputRendering]::PlainText;"
  vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

setPowershell()

-- LazyVim.terminal.setup("pwsh")

vim.opt.formatoptions = "jcroqlt"

vim.g.lazyvim_statuscolumn = {
  folds_open = false,
  folds_githl = true,
}
