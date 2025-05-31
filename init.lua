-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
if vim.g.vscode then
  require("vscode_custom")
end
if vim.g.neovide then
  require("neovide")
end
