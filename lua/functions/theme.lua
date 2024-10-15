local M = {}

M.currentMode = require("config.colormode").colormode
M.useBack = require("config.colormode").useBack

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
  end
  if opts ~= nil and opts.update then
    local cmd = "Set-ColorMode " .. mode
    vim.fn.system(cmd)
  end
  M.currentMode = mode
end

---Sets the color scheme based on variable in custom file (changed with sed).
---Done this way to avoid needing to call nvim with a cmd.
function M.setColorScheme()
  local background = require("config.colormode").colormode
  local call_update = false
  -- Do a nil check in case the variable isn't defined or the file doesn't exist
  if background == nil or (background ~= "dark" and background ~= "light") then
    background = "dark"
    call_update = true
  end
  _setScheme(background, { update = call_update })
end

function M.toggleLight()
  ---@type "light" | "dark"
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
  M.useBack = not M.useBack
end

return M
