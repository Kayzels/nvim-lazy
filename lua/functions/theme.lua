local M = {}

---@param mode "light" | "dark"
---@param opts? { update: boolean? }
local function _setScheme(mode, opts)
  local light_theme = "catppuccin"
  local dark_theme = "tokyonight"
  vim.opt.background = mode
  if mode == "dark" then
    vim.cmd.colorscheme(dark_theme)
  else
    vim.cmd.colorscheme(light_theme)
    vim.cmd("Catppuccin latte")
  end
  if opts ~= nil and opts.update then
    local cmd = "Set-ColorMode " .. mode
    vim.fn.system(cmd)
  end
end

function M.setColorScheme()
  local background = vim.opt.background:get()
  if background ~= "light" and background ~= "dark" then
    return
  end
  _setScheme(background)
end

function M.toggleLight()
  local background = vim.opt.background:get()
  if background ~= "light" and background ~= "dark" then
    return
  end
  ---@type "light" | "dark"
  local new_background = (background == "dark") and "light" or "dark"
  _setScheme(new_background, { update = true })
end

function M.toggleBackgroundImage()
  vim.fn.system("Switch-UseBack")
end

return M
