local M = {}

---@param mode "light" | "dark"
---@param opts? { update: boolean? }
local function _setScheme(mode, opts)
  -- local light_theme = "catppuccin-latte"
  local light_theme = "catppuccin"
  -- local dark_theme = "tokyonight-moon"
  local dark_theme = "tokyonight"
  vim.opt.background = mode
  if mode == "dark" then
    vim.cmd.colorscheme(dark_theme)
  else
    -- require("catppuccin").setup({ transparent_background = true })
    vim.cmd.colorscheme(light_theme)
    vim.cmd("Catppuccin latte")
  end
  if opts ~= nil and opts.update then
    local command = 'call system("SetColorMode ' .. mode .. '")'
    vim.cmd(command)
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
  local new_background
  if background == "dark" then
    new_background = "light"
  else
    new_background = "dark"
  end
  _setScheme(new_background, { update = true })
end

function M.toggleBackgroundImage()
  -- Keeping the old way commented, but added a Powershell command that should work
  vim.cmd([[call system("Switch-UseBack")]])

  -- Do it this way instead of using lua os.get_env
  -- Needed because its a user variable rather than host
  -- local backFull = vim.fn.system("[Environment]::GetEnvironmentVariable('WezBack', 'User')")
  -- local lines = {}
  -- for s in backFull:gmatch("[^\r\n]+") do
  --   table.insert(lines, s)
  -- end
  -- local backgroundSet = lines[#lines]
  --
  -- if backgroundSet == "true" then
  --   vim.cmd([[call system("setUseBack $false")]])
  -- else
  --   vim.cmd([[call system("setUseBack $true")]])
  -- end
end

return M
