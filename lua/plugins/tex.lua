return {
  {
    "lervag/vimtex",
    init = function()
      vim.g.vimtex_compiler_latexmk = {
        callback = 1,
        continuous = 0,
        executable = "latexmk",
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
    end,
  },
}
