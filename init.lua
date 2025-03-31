-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.print("1")
if vim.g.vscode then
  require("vscode_custom")
end
