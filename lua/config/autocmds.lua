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

if not vim.g.vscode then
  -- Change LuaSnip session logic so tab doesn't go back to previous snippet
  vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
      if
        ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
        and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
    end,
  })
end

-- Change cursor when leaving Neovim
vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
  pattern = "*",
  command = "set guicursor=a:ver25-blinkwait700-blinkoff400-blinkon250",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- local auto = require("functions.bars").getLualineTheme()
    -- require("lualine").setup({
    --   options = {
    --     theme = auto,
    --   },
    -- })

    if package.loaded["incline"] then
      -- NOTE: Needed, because otherwise it weirdly inverts some colors
      require("incline").setup({
        render = require("functions.bars").inclineRender,
      })
    end

    -- The component for plugin updates and recording messages doesn't update
    -- automatically, so force this update.
    require("functions.bars").updateLualineSectionX()
    vim.opt.showtabline = 1
  end,
})

-- Disable minipairs completing `` in some files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "tex" },
  callback = function(event)
    vim.keymap.set("i", "`", "`", { buffer = event.buf })
  end,
})
