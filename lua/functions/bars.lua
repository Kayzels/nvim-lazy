local M = {}

---Gets the color that should be used for the bars, based on mode
---@param active boolean
---@return fun() : string
function M.getModeColor(active)
  ---@type string
  local lualine_index
  if active then
    lualine_index = "a"
  else
    lualine_index = "b"
  end
  ---@return string
  return function()
    local suffix = require("lualine.highlight").get_mode_suffix()
    return "lualine_" .. lualine_index .. suffix
  end
end

---@alias RenderProp {buf: number, win:number, focused: boolean}

--- Sets the way that incline.nvim displays its winbar.
--- Needs to be external because called in multiple places.
---@param props RenderProp
---@return table
function M.inclineRender(props)
  local lualine_highlight = require("lualine.highlight")
  local devicons = require("nvim-web-devicons")
  local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  -- vim.print("Filename for incline is " .. filename)
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

  local h_group = M.getModeColor(props.focused)()
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

  table.insert(res, { "", guifg = colors.bg, guibg = "none" })

  return res
end

--- Taken almost entirely from the trouble source code.
--- Only real difference is adding the dot between components,
--- no easy way to do that with existing code.
---@param _lines TextSegment[][]
---@param hl_group string
local function troubleComponents(_lines, hl_group)
  local lines = {} ---@type string[]
  for _, line in ipairs(_lines) do
    local parts = {}
    for _, segment in ipairs(line) do
      local str = segment.str:gsub("%%", "%%%%")
      if segment.hl then
        str = ("%%#%s#%s%%*"):format(segment.hl, str)
      end
      parts[#parts + 1] = str
    end
    if #parts > 1 then
      table.insert(lines, table.concat(parts))
    end
  end
  local result = table.concat(lines, " • ")
  -- if hl_group then
  --   result = require("trouble.config.highlights").fix_statusline(result, hl_group)
  -- end
  return result
end

---@param opts? trouble.Mode|string|{hl_group?:string}
function M.troubleStatusLine(opts)
  local Spec = require("trouble.spec")
  local Section = require("trouble.view.section")
  local Render = require("trouble.view.render")
  local Config = require("trouble.config")
  opts = Config.get(opts)
  -- opts.indent_guides = false
  opts.icons.indent.ws = ""
  local renderer = Render.new(opts, {
    multiline = false,
    indent = false,
  })
  local status = nil ---@type string?

  ---@cast opts trouble.Mode
  local s = Spec.section(opts)
  s.max_items = s.max_items or opts.max_items
  local section = Section.new(s, opts)
  section.on_update = function()
    status = nil
    if package.loaded["lualine"] then
      vim.schedule(function()
        require("lualine").refresh()
      end)
    else
      vim.cmd.redrawstatus()
    end
  end
  section:listen()
  section:refresh()
  return {
    has = function()
      return section.node and section.node:count() > 0
    end,
    get = function()
      if status then
        return status
      end
      renderer:clear()
      renderer:sections({ section })
      status = troubleComponents(renderer._lines, opts.hl_group)
      return status
    end,
  }
end

--- Update the X component colours for plugin updates and recording messages
function M.updateLualineSectionX()
  local current_x = require("lualine").get_config().sections.lualine_x
  current_x[1].color = LazyVim.ui.fg("Constant") -- recording
  current_x[2].color = LazyVim.ui.fg("Debug") -- debug
  current_x[3].color = LazyVim.ui.fg("Special") -- plugin updates
  require("lualine").setup({
    sections = {
      lualine_x = current_x,
    },
  })
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
function M.trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  --- @param str string
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width then
      local stripped = str:gsub("%%#.-#(.-)%%%*", "%1")
      if #stripped < trunc_len then
        return str
      end
      local shortened = stripped:sub(1, trunc_len)

      --- Find the number of separators.
      --- We need to keep up to the last one.
      local _, count = shortened:gsub("•", "•")
      local counted = 0
      --- @type integer | nil
      local dot_index = 1
      while counted ~= count and dot_index do
        dot_index = str:find("•", dot_index + 1)
        counted = counted + 1
      end
      local final = str:sub(1, dot_index - 1)
      return final
    end
    return str
  end
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
function M.lualineTrunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      -- vim.print("Matched shortening requirement")
      vim.print(str:sub(1, trunc_len) .. (no_ellipsis and "" or "..."))
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

return M
