-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.commands")
if vim.g.vscode then
  require("vscode")
end
