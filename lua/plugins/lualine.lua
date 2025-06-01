---Create winbar component for filename
---@param active boolean
---@return table
local function createFnameBar(active)
  local color = require("functions.bars").getModeColor(active)
  local values = {
    {
      "filetype",
      icon_only = true,
      separator = { left = "", right = "" },
      padding = { left = 1, right = 0 },
      colored = false,
      color = color,
    },
    {
      "filename",
      file_status = true,
      path = 0,
      symbols = {
        modified = "●",
        readonly = "󰌾",
      },
      separator = { left = "", right = "" },
      color = color,
    },
  }
  return values
end

---Create the tab shapes which are identical except for component names
---@param component_name string
---@return table
local function createTabComponent(component_name)
  return {
    {
      component_name,
      cond = function()
        return #vim.fn.gettabinfo() > 1
      end,
      separator = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      use_mode_colors = true,
      [component_name .. "_color"] = {
        active = require("functions.bars").getModeColor(true),
        inactive = require("functions.bars").getModeColor(false),
      },
    },
  }
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "folke/trouble.nvim",
    },
    opts = {
      options = {
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = "▎",
        disabled_filetypes = {
          tabline = { "neo-tree", "dashboard", "snacks_dashboard" },
          winbar = { "neo-tree", "dashboard", "snacks_dashboard" },
          statusline = { "dashboard", "snacks_dashboard" },
        },
        always_show_tabline = false,
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2, color = { gui = "bold" } },
        },
        -- Set lualine_b to always contain the cwd, and lualine_c to show when root is different from cwd
        -- Means that lualine_c config doesn't change from default LazyVim
        lualine_b = {
          {
            function()
              return vim.fs.basename(LazyVim.root.cwd())
            end,
            padding = { left = 2, right = 2 },
            color = nil,
          },
          { "branch", padding = { left = 1, right = 1 } },
        },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 1 } },
      },
      tabline = {
        lualine_a = createTabComponent("tabs"),
        lualine_z = createTabComponent("windows"),
      },
      winbar = {
        lualine_a = createFnameBar(true),
      },
      inactive_winbar = {
        lualine_b = createFnameBar(false),
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      ---@alias LualineSeparator {left?: string, right?: string}
      ---@param ext_name string
      ---@param section_separators table<string, LualineSeparator>
      local function setExtensionSeparators(ext_name, section_separators)
        for i, ext in ipairs(opts.extensions or {}) do
          if ext == ext_name then
            local ext_table = require("lualine.extensions." .. ext_name)
            for section, sep_tbl in pairs(section_separators) do
              if ext_table.sections and ext_table.sections[section] and ext_table.sections[section][1] then
                local orig = ext_table.sections[section][1]
                if type(orig) == "function" then
                  ext_table.sections[section] = {
                    {
                      orig,
                      separator = sep_tbl,
                    },
                  }
                end
              end
            end
            opts.extensions[i] = ext_table
          end
        end
      end

      setExtensionSeparators("lazy", { lualine_a = { left = "" } })
      setExtensionSeparators("neo-tree", { lualine_a = { left = "", right = "" } })
      setExtensionSeparators("fzf", { lualine_a = { left = "", right = "" }, lualine_z = { right = "" } })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
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
            if client.name ~= "copilot" then
              table.insert(buf_client_names, client.name)
            end
          end

          if #buf_client_names == 1 then
            local language_servers = buf_client_names[1]
            return language_servers
          end

          local unique_client_names = table.concat(buf_client_names, ", ")
          local language_servers = string.format("[%s]", unique_client_names)

          return language_servers
        end,
        cond = conditions.hide_in_width,
      }
      table.insert(opts.sections.lualine_x, lsp)
      local ft_table = {
        "filetype",
        padding = { left = 1, right = 1 },
        icon = { align = "right" },
        cond = conditions.hide_in_width,
      }
      table.insert(opts.sections.lualine_x, ft_table)
    end,
  },
}
