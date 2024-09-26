local toggleLight = require("functions.theme").toggleLight
vim.api.nvim_create_user_command("ToggleLight", toggleLight, {})
vim.keymap.set("n", "<leader>ub", "<cmd>ToggleLight<cr>", { desc = "Toggle Light Mode" })

local toggleBackgroundImage = require("functions.theme").toggleBackgroundImage
vim.api.nvim_create_user_command("ToggleBackgroundImage", toggleBackgroundImage, {})
vim.keymap.set("n", "<leader>up", "<cmd>ToggleBackgroundImage<cr>", { desc = "Toggle Background Image" })
