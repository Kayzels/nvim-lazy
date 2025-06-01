local ai_plugins = { "codecompanion", "copilot" }

local M

if vim.tbl_count(ai_plugins) > 0 then
  M = {
    {
      "which-key.nvim",
      opts = {
        spec = {
          {
            mode = { "n", "v" },
            { "<leader>a", group = "ai" },
          },
        },
      },
    },
  }
else
  M = {}
end

for _, plugin in ipairs(ai_plugins) do
  local vals = require("plugins.ai." .. plugin)
  vim.list_extend(M, vals)
end

return M
