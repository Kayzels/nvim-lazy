return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = function(_, opts)
      -- Stop the warning that copilot is disabled
      vim.schedule(function()
        local ok, logger = pcall(require, "copilot.logger")
        if ok then
          local orig_warn = logger.warn
          logger.warn = function(msg, ...)
            if msg:find("copilot is disabled", 1, true) then
              return
            end
            orig_warn(msg, ...)
          end
        end
      end)

      require("copilot").setup(opts)

      -- local snacks = require("snacks")
      Snacks.toggle({
        name = "Copilot",
        get = function()
          return not require("copilot.client").is_disabled()
        end,
        set = function(state)
          if state then
            require("copilot.command").enable()
          else
            require("copilot.command").disable()
          end
        end,
      }):map("<leader>at")
      vim.cmd("silent! Copilot disable")
      -- TODO: Technically, I only want to disable completion, not Copilot entirely.
      -- Otherwise it might need to be manually enabled before using CodeCompanion chat with it.
    end,
  },
}
