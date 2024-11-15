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

return M
