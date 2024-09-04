local M = {}

---@alias RenderProp {buf: number, win:number, focused: boolean}

--- Defining this here, because it needs to be recalled when color schemes change,
--- otherwise it uses the wrong colors
---@param props RenderProp
---@return table
function M.inclineRender(props)
  local lualine_highlight = require("lualine.highlight")
  local devicons = require("nvim-web-devicons")
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

  local lualine_field = "lualine_"
  if props.focused == true then
    lualine_field = lualine_field .. "a"
  else
    lualine_field = lualine_field .. "b"
  end

  local h_group = lualine_field .. lualine_highlight.get_mode_suffix()
  local colors = lualine_highlight.get_lualine_hl(h_group)

  local res = {
    { "", guifg = colors.bg, guibg = "none" },
    { ft_icon, group = h_group },
    { filename .. " ", group = h_group },
  }

  local modified = vim.bo[props.buf].modified
  if modified then
    table.insert(res, { " ● ", group = h_group })
  end

  return res
end

---@return table
function M.getLualineAuto()
  ---@type string
  local scheme_name = vim.g.colors_name
  if not scheme_name:find("tokyonight") and not scheme_name:find("catppuccin") then
    scheme_name = "auto"
  end
  local autopath = "lualine.themes." .. scheme_name
  local auto = require(autopath)
  auto.normal.c = "NONE"
  auto.inactive.c = "NONE"
  return auto
end

function M.toggleLight()
  local light_theme = "catppuccin-latte"
  local dark_theme = "tokyonight-moon"
  if vim.opt.background:get() == "dark" then
    vim.opt.background = "light"
    vim.cmd.colorscheme(light_theme)
    vim.cmd([[call system("SetColorMode light")]])
  elseif vim.opt.background:get() == "light" then
    vim.opt.background = "dark"
    vim.cmd.colorscheme(dark_theme)
    vim.cmd([[call system("SetColorMode dark")]])
  end
end

return M
