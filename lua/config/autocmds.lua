-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Move help window to the right when opened
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == "help" then
      vim.cmd.winc("L")
    end
  end,
})

-- Change cursor when leaving and entering Neovim
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  pattern = "*",
  command = "set guicursor=a:ver25-blinkwait700-blinkoff400-blinkon250",
})
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
  pattern = "*",
  command = "set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
})

-- Disable minipairs completing `` in some files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function(event)
    ---@diagnostic disable-next-line: missing-fields
    vim.keymap.set("i", "`", "`", { buffer = event.buf })
  end,
})

-- sync with the clipboard on focus
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  pattern = { "*" },
  command = [[call setreg("@", getreg("+"))]],
})

-- sync with system clipboard on focus
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  pattern = { "*" },
  command = [[call setreg("+", getreg("@"))]],
})
