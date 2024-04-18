---@alias FileInfo {jobname: string, root: string, target: string, target_basename: string, target_name: string }

---Create tex output directory
---@param file_info FileInfo
---@return string
local function GetOutputDir(file_info)
  local root_patterns = { "Notes", "Exercises", "Assignment", "Assessment" }
  for _, pattern in ipairs(root_patterns) do
    if string.find(string.lower(file_info.jobname), string.lower(pattern), 1) ~= nil then
      return "./out/"
    else
      local subdir_root = file_info.root
      ---@diagnostic disable-next-line: cast-local-type
      subdir_root = vim.fn.fnamemodify(subdir_root, ":t")
      return "../out/" .. subdir_root
    end
  end
end

return {
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_compiler_latexmk = {
        callback = 1,
        continuous = 0,
        executable = "latexmk",
        out_dir = GetOutputDir,
        options = {
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-shell-escape",
          "-interaction=nonstopmode",
        },
      }
      vim.g.vimtex_quickfix_ignore_filters = {
        "Overfull",
        "Underfull",
        "You have requested",
      }
      vim.g.vimtex_syntax_custom_cmds = {
        {
          name = "concept",
          conceal = true,
          opt = false,
          argstyle = "bold",
        },
      }
      vim.g.vimtex_indent_lists = {
        "itemize",
        "description",
        "enumerate",
        "thebibliography",
        "descriptimize",
        "descriptenum",
      }
      vim.g.vimtex_view_method = "sioyek"
    end,
  },
}
