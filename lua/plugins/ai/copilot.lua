return {
  {
    "nvim-lualine/lualine.nvim",
    -- NOTE: This is literally the same as what is in LazyVim, but it doesn't work when called that way.
    -- Maybe because the event there is VeryLazy?
    opts = function(_, opts)
      table.insert(
        opts.sections.lualine_x,
        2,
        LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
          local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
          if #clients > 0 then
            local status = require("copilot.status").data.status
            return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
          end
        end)
      )
    end,
  },
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

      local snacks = require("snacks")
      snacks
        .toggle({
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
        })
        :map("<leader>at")
      vim.cmd("silent! Copilot disable")
      -- TODO: Technically, I only want to disable completion, not Copilot entirely.
      -- Otherwise it might need to be manually enabled before using CodeCompanion chat with it.
    end,
  },
}
