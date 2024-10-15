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

vim.keymap.del("n", "<leader>ub")
vim.keymap.set("n", "<leader>ub", "<cmd>ToggleLight<cr>", { desc = "Toggle Light Mode" })

LazyVim.toggle.map("<leader>ux", {
  name = "LTex",
  get = require("functions.lsp").getLtex,
  set = require("functions.lsp").setLtex,
})

-- Yank line on `dd` only if not empty
vim.keymap.set("n", "dd", function()
  if vim.fn.getline("."):match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true })
