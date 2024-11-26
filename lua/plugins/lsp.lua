local win = require("lspconfig.ui.windows")
win.default_options.border = "rounded"

return {
  {
    "neovim/nvim-lspconfig",
    commit = "27008519562f16453813c19dcc6ee97f505e0b1c",
    optional = true,
    opts = {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = false,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
                setType = true,
                arrayIndex = "Disable",
              },
            },
          },
        },
        pyright = {
          enabled = false,
        },
        basedpyright = {
          enabled = true,
          settings = {
            basedpyright = {
              analysis = {
                diagnosticSeverityOverrides = {
                  reportMissingSuperCall = "none",
                  reportPrivateUsage = "none",
                  reportUnusedCallResult = "none",
                  reportAny = "none",
                  reportUninitializedInstanceVariable = "none",
                  reportUnusedVariable = "none",
                },
              },
            },
          },
        },
        html = {
          filetypes = {
            "html",
            "xhtml",
          },
          settings = {
            html = {
              format = {
                wrapLineLength = 0,
                indentInnerHtml = false,
                maxPreserveNewLines = 2,
                -- wrapLineWidth = 9999,
              },
            },
          },
        },
        texlab = {
          keys = {
            { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
          },
          settings = {
            texlab = {
              diagnostics = {
                ignoredPatterns = { "Underfull", "Overfull", "You have requested", "dynindent" },
              },
              experimental = {
                labelReferenceCommands = { "nameref" },
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
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            local storeschemas = require("schemastore").json.schemas()
            vim.list_extend(new_config.settings.json.schemas, storeschemas)
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
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
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
      -- keys[#keys + 1] = { "<c-i>", vim.lsp.buf.signature_help, mode = "i" }
      keys[#keys + 1] = { "]]", false }
      -- stylua: ignore
      keys[#keys + 1] = { "]r", function() LazyVim.lsp.words.jump(vim.v.count1) end, has = "documentHighlight", desc = "Next Reference" }
      keys[#keys + 1] = { "[[", false }
      -- stylua: ignore
      keys[#keys + 1] = { "[r", function() LazyVim.lsp.words.jump(-vim.v.count1) end, has = "documentHighlight", desc = "Prev Reference" }
      -- stylua: ignore
      keys[#keys + 1] = { "K", function() vim.lsp.buf.hover() end, "Hover" }
      -- stylua: ignore
      keys[#keys + 1] = { "gK", function() vim.lsp.buf.signature_help() end, "Signature Help" }
    end,
  },
  {
    "barreiroleo/ltex-extra.nvim",
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
}
