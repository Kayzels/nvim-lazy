local M = {}

local clone = require("functions.util").clone

local cmp_buffers = {
  name = "buffer",
  group_index = 1,
  option = {
    get_bufnrs = function()
      local bufs = vim.api.nvim_list_bufs()
      --- @type integer[]
      local new_bufs = {}

      ---Check if the buffer is valid
      ---@param bufnr number
      ---@return number | nil
      local function valid_bufnr(bufnr)
        if vim.api.nvim_buf_get_name(bufnr) == "" or not vim.api.nvim_buf_is_loaded(bufnr) then
          return
        end

        local ignore_patterns = { "out", "pygtex", "gz", "fdb_latexmk", "fls", "aux", "log" }

        -- local filename = vim.fn.bufname(bufnr)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local extension = vim.fn.fnamemodify(filename, ":e")
        if extension == "" or extension == nil then
          return
        end
        for _, pattern in ipairs(ignore_patterns) do
          if string.find(string.lower(extension), pattern, 1) == nil then
            return bufnr
          end
        end
      end

      for _, bufnr in pairs(bufs) do
        local num = valid_bufnr(bufnr)
        if num ~= nil then
          new_bufs[#new_bufs + 1] = num
        end
      end

      return new_bufs
    end,
  },
}

local default_sources = {
  { name = "nvim_lsp" },
  { name = "path" },
  cmp_buffers,
  { name = "luasnip" },
}

local sources = clone(default_sources)
M.sources = sources

return M
