local function GetOutputDir()
  local file_name = vim.fn.expand("%:t")
  if file_name == "notes.tex" then
    return "./out/"
  else
    return "../out/chapters/"
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
    end,
  },
}
