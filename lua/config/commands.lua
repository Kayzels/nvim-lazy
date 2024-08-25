local toggleLight = require("config.functions").toggleLight

vim.api.nvim_create_user_command("ToggleLight", toggleLight, {})
vim.keymap.set("n", "<leader>ub", "<cmd>ToggleLight<cr>", { desc = "Toggle Light Mode" })
