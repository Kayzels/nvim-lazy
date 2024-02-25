-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Neotree focus" })
vim.keymap.set("n", "<S-p>", "<cmd>Legendary<cr>", { desc = "Open Legendary" })
vim.keymap.set("n", "<S-CR>", function()
  print("Shift Enter")
end, { desc = "Test Shift Enter" })
vim.keymap.set("n", "<C-CR>", function()
  print("Ctrl Enter")
end, { desc = "Test Ctrl Enter" })
vim.keymap.set("n", "<S-Space>", function()
  print("Shift Space")
end, { desc = "Test Shift Space" })
vim.keymap.set("n", "<C-Space>", function()
  print("Ctrl Space")
end, { desc = "Test Ctrl Space" })
vim.keymap.set("n", "U", "<cmd>redo<cr>", { silent = true })
