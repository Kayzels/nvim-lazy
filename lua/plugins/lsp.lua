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
                ignoredPatterns = { "Underfull", "Overfull" },
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
