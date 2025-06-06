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
vim.keymap.set("n", "U", "<cmd>redo<cr>", { silent = true, desc = "Redo" })
if vim.fn.has("win32") == 1 then
  vim.keymap.set("n", "<C-Z>", "<Nop>", { desc = "which_key_ignore" })
end

if not vim.g.vscode then
  vim.keymap.del("n", "<leader>ub")
  local wk = require("which-key")
  wk.add({ "<leader>ub", hidden = true })
end

Snacks.toggle({
  name = "Light Mode",
  get = function()
    local mode = require("functions.theme").currentMode
    return mode == "light"
  end,
  set = function(_)
    require("functions.theme").toggleLight()
    -- toggleLight()
  end,
}):map("<leader>ub")

Snacks.toggle({
  name = "Background Image",
  get = function()
    return require("functions.theme").useBack
  end,
  set = function(_)
    require("functions.theme").toggleBackgroundImage()
  end,
}):map("<leader>uB")

Snacks.toggle({
  name = "Winbar",
  get = function()
    return #(vim.opt.winbar:get()) > 0
  end,
  set = function(state)
    require("lualine").hide({
      place = { "winbar" },
      unhide = state,
    })
  end,
}):map("<leader>uv")

-- Yank line on `dd` only if not empty
vim.keymap.set("n", "dd", function()
  if vim.fn.getline("."):match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- Stop going to new line if enter pressed at end of command (example with <C-S> for save)
vim.keymap.set("n", "<CR>", "<Nop>")
