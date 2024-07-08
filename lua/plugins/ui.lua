local Util = require("lazyvim.util")

local MIN_WIDTH = 120

local conditions = {
  hide_in_width = function()
    return vim.opt.co:get() > MIN_WIDTH
  end,
}

local lsp = {
  ---@return string
  function()
    local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #buf_clients == 0 then
      return "LSP Inactive"
    end

    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
      table.insert(buf_client_names, client.name)
    end

    if #buf_client_names == 1 then
      local language_servers = buf_client_names[1]
      return language_servers
    end

    local unique_client_names = table.concat(buf_client_names, ", ")
    local language_servers = string.format("[%s]", unique_client_names)

    return language_servers
  end,
  -- color = { gui = "bold" },
  cond = conditions.hide_in_width,
}

return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      window = {
        border = "rounded",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons
      local custom_auto = require("lualine.themes.auto")
      custom_auto.normal.c.bg = "None"
      custom_auto.inactive.c.bg = "None"
      opts.options = {
        theme = custom_auto,
        section_separators = { left = "", right = "" },
        component_separators = "▎",
        disabled_filetypes = {
          tabline = { "neo-tree", "dashboard" },
          winbar = { "neo-tree", "dashboard" },
        },
      }

      ---@diagnostic disable-next-line: assign-type-mismatch
      local root = require("lazyvim.util").lualine.root_dir({ cwd = true })
      root.padding = { left = 1, right = 2 }
      root.color = nil

      opts.sections["lualine_b"] = {
        root,
        { "branch", padding = { left = 1, right = 1 } },
      }
      opts.sections["lualine_c"] = {
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        {
          require("lazyvim.util").lualine.pretty_path(),
          ---@param s string
          ---@return string
          fmt = function(s)
            local subbed = s:gsub("\\", "/")
            return subbed
          end,
        },
      }
      opts.sections["lualine_x"] = {
        -- show @recording messages
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = Util.ui.fg("Constant"),
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = Util.ui.fg("Debug"),
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = Util.ui.fg("Special"),
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
        {
          function()
            return "venv: " .. vim.fn.fnamemodify(require("venv-selector").get_active_venv(), ":h:t")
          end,
          cond = function()
            return conditions.hide_in_width
              and package.loaded["venv-selector"]
              and require("venv-selector").get_active_venv() ~= nil
          end,
        },
        lsp,
        { "filetype", padding = { left = 1, right = 1 }, icon = { align = "right" }, cond = conditions.hide_in_width },
      }
      opts.sections["lualine_y"] = { "progress" }
      opts.sections["lualine_z"] = { "location" }
      opts.tabline = {
        lualine_a = {
          {
            "tabs",
            cond = function()
              return #vim.fn.gettabinfo() > 1
            end,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            "windows",
            cond = function()
              return #vim.fn.gettabinfo() > 1
            end,
          },
        },
      }
    end,
  },
  {
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- init = function()
    --   vim.api.nvim_create_autocmd("BufEnter", {
    --     -- make a group to be able to delete it later
    --     group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
    --     callback = function()
    --       local f = vim.fn.expand("%:p")
    --       if vim.fn.isdirectory(f) ~= 0 then
    --         vim.cmd("Neotree current dir=" .. f)
    --         -- neo-tree is loaded now, delete the init autocmd
    --         vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
    --       end
    --     end,
    --   })
    -- end,
    opts = {
      popup_border_style = "rounded",
      filesystem = {
        hijack_netrw_behaviour = "open_current",
      },
    },
  },
  {
    "b0o/incline.nvim",
    -- TODO: Inactive winbar shouldn't have color
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lualine/lualine.nvim",
    },
    opts = function(_, opts)
      local devicons = require("nvim-web-devicons")
      local lualine_highlight = require("lualine.highlight")

      opts.window = {
        padding = 0,
        margin = { horizontal = 0 },
      }

      opts.render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        local ft_icon = ""
        if filename == "" then
          filename = "[No Name]"
        else
          ft_icon = devicons.get_icon(filename)
          if ft_icon == nil then
            ft_icon = ""
          end
        end
        if ft_icon ~= "" then
          ft_icon = " " .. ft_icon .. " "
        end
        local modified = vim.bo[props.buf].modified

        local h_group = "lualine_a" .. lualine_highlight.get_mode_suffix()
        local colors = lualine_highlight.get_lualine_hl(h_group)

        local res = {
          { "", guifg = colors.bg, guibg = colors.fg },
          ft_icon,
          { filename .. " ", gui = "bold" },
          guibg = colors.bg,
          guifg = colors.fg,
        }

        if modified then
          table.insert(res, { " ● " })
        end

        return res
      end
    end,
    event = "VeryLazy",
  },
}
