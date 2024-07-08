local win = require("lspconfig.ui.windows")
win.default_options.border = "rounded"

local function toggle_ltex()
  local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, client in pairs(buf_clients) do
    if client.name == "ltex" then
      client.stop()
      return
    end
  end
  vim.cmd("LspStart ltex")
end

vim.api.nvim_create_user_command("ToggleLtex", toggle_ltex, {})
vim.keymap.set("n", "<leader>ux", "<cmd>ToggleLtex<cr>", { desc = "Toggle Ltex" })
return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        texlab = {
          keys = {
            { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
          },
          settings = {
            texlab = {
              diagnostics = {
                ignoredPatterns = { "Underfull", "Overfull", "You have requested" },
              },
            },
          },
        },
        ltex = {
          autostart = false,
          filetypes = {
            "gitcommit",
            "latex",
            "tex",
            "markdown",
            "pandoc",
            "text",
          },
          settings = {
            ltex = {
              language = "en-GB",
              checkFrequency = "save",
              disabledRules = {
                ["en-GB"] = { "OXFORD_SPELLING_Z_NOT_S" },
              },
            },
          },
        },
      },
      setup = {
        ltex = function()
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "ltex" then
                require("ltex_extra").setup({
                  load_langs = { "en-GB" },
                  path = ".vscode",
                })
              end
            end,
          })
        end,
      },
    },
  },
  {
    "barreiroleo/ltex-extra.nvim",
  },
}
