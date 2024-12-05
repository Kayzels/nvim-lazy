local M = {}

M.useBack = require("config.colormode").useBack

---Sets the color scheme and background option
---If called without an argument, uses the variable set in the colormode file.
---@param mode? "light" | "dark"
function M.setMode(mode)
  if not mode then
    mode = require("config.colormode").colormode
  end
  local light_theme = "catppuccin"
  local dark_theme = "tokyonight"
  vim.opt.background = mode
  if mode == "dark" then
    vim.cmd.colorscheme(dark_theme)
  else
    vim.cmd.colorscheme(light_theme)
  end
end

function M.toggleLight()
  vim.fn.system("setc")
end

function M.toggleBackgroundImage()
  vim.fn.system("Switch-UseBack")
  M.useBack = not M.useBack
end

return M
