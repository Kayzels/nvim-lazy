-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.commands")
if vim.g.vscode then
  require("vscode")
end

-- Needed because sometimes it doesn't correctly use transparent
-- until called.
if vim.opt.background:get() == "light" then
  vim.cmd("Catppuccin latte")
end
