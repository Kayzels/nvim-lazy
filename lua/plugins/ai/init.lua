local ai_plugins = { "codecompanion", "copilot" }

local M = {}
for _, plugin in ipairs(ai_plugins) do
  local vals = require("plugins.ai." .. plugin)
  vim.list_extend(M, vals)
end

return M
