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
local wk = require("which-key")
wk.add({ "<leader>ub", hidden = true })

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
  name = "LTex",
  get = require("functions.lsp").getLtex,
  set = require("functions.lsp").setLtex,
}):map("<leader>ux")

Snacks:toggle({
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

Snacks:toggle({
  name = "Codeium Completion",
  get = function()
    local status, _ = require("neocodeium").get_status()
    return status == 0
  end,
  set = function(_)
    require("neocodeium.commands").toggle()
  end,
}):map("<leader>ua")

Snacks:toggle({
  name = "Codeium Server",
  get = function()
    local _, server_status = require("neocodeium").get_status()
    return server_status == 0
  end,
  set = function(state)
    local _, server_status = require("neocodeium").get_status()
    if state then
      if server_status == 2 then
        require("neocodeium.commands").restart()
      end
    else
      require("neocodeium.commands").disable(true)
    end
  end,
}):map("<leader>uA")

-- Yank line on `dd` only if not empty
vim.keymap.set("n", "dd", function()
  if vim.fn.getline("."):match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- Stop going to new line if enter pressed at end of command (example with <C-S> for save)
vim.keymap.set("n", "<CR>", "<Nop>")
