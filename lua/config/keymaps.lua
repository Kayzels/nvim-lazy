-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<S-CR>", function()
  print("Shift Enter")
end, { desc = "which_key_ignore" })
vim.keymap.set("n", "<C-CR>", function()
  print("Ctrl Enter")
end, { desc = "which_key_ignore" })
vim.keymap.set("n", "<S-Space>", function()
  print("Shift Space")
end, { desc = "which_key_ignore" })
vim.keymap.set("n", "<C-Space>", function()
  print("Ctrl Space")
end, { desc = "which_key_ignore" })
vim.keymap.set("n", "U", "<cmd>redo<cr>", { silent = true, desc = "Redo" })
vim.keymap.set("n", "<C-Z>", "<Nop>", { desc = "which_key_ignore" })
