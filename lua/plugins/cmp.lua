---@diagnostic disable: missing-fields
return {
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = {
          draw = {
            columns = {
              { "kind_icon", "split_icon" },
              { "label", "label_description", gap = 1 },
              { "kind" },
              -- { "source_name" },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  return ctx.kind_icon
                end,
              },
              split_icon = {
                ellipsis = false,
                text = function(_)
                  return "│"
                end,
                highlight = "BlinkCmpKindDefault",
              },
              kind = {
                ellipsis = true,
                text = function(ctx)
                  return ctx.icon_gap .. ctx.icon_gap .. "⟨" .. ctx.kind .. "⟩"
                end,
              },
              source_name = {
                text = function(ctx)
                  return "[" .. ctx.source_name .. "]"
                end,
                highlight = "BlinkCmpKindDefault",
              },
            },
          },
        },
        documentation = {
          window = {
            border = "rounded",
          },
        },
      },
      signature = {
        enabled = true,
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            fallbacks = {},
          },
          buffer = {
            score_offset = -10,
          },
        },
      },
      keymap = {
        preset = "default",
        ["<S-CR>"] = { "select_and_accept" },
        ["<S-Space>"] = { "hide" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
    },
  },
}
