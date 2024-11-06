local M = {}

---Gets the color that should be used for the bars, based on mode
---@param active boolean
---@return fun() : string
function M.getModeColor(active)
  local lualine_index = active and "a" or "b"

  ---@return string
  return function()
    local suffix = require("lualine.highlight").get_mode_suffix()
    return "lualine_" .. lualine_index .. suffix
  end
end

--- Update the X component colours for plugin updates and recording messages
function M.updateLualineSectionX()
  local current_x = require("lualine").get_config().sections.lualine_x
  current_x[1].color = LazyVim.ui.fg("Constant") -- recording
  current_x[2].color = LazyVim.ui.fg("Debug") -- debug
  current_x[3].color = LazyVim.ui.fg("Special") -- plugin updates
  require("lualine").setup({
    sections = {
      lualine_x = current_x,
    },
  })
end

return M
