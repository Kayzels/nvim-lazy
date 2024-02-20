vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "100"
vim.g.autoformat = false

local tex_motions = {
  ["]]"] = { "Next section end" },
  ["]["] = { "Next section start" },
  ["[]"] = { "Previous section end" },
  ["[["] = { "Previous section start" },
  ["]m"] = { "Next env start" },
  ["]M"] = { "Next env end" },
  ["[m"] = { "Previous env start" },
  ["[M"] = { "Previous env end" },
  ["]n"] = { "Next math start" },
  ["]N"] = { "Next math end" },
  ["[n"] = { "Previous math start" },
  ["[N"] = { "Previous math end" },
  ["]r"] = { "Next frame start" },
  ["]R"] = { "Next frame end" },
  ["[r"] = { "Previous frame start" },
  ["[R"] = { "Previous frame end" },
  ["]/"] = { "Next LaTeX comment start" },
  ["]*"] = { "Next LaTeX comment end" },
  ["[/"] = { "Previous LaTeX comment start" },
  ["[*"] = { "Previous LaTeX comment end" },
}
local tex_objects = {
  ["$"] = { "Math environment" },
  ["d"] = { "Delimiter" },
  ["e"] = { "Environment" },
  ["m"] = { "Item" },
  ["P"] = { "Section" },
}
local a_objects = vim.deepcopy(tex_objects)
local i_objects = vim.deepcopy(tex_objects)
a_objects["C"] = { "<Plug>(vimtex-ac)", "Command" }
i_objects["C"] = { "<Plug>(vimtex-ic)", "Command" }

-- The mappings found after <localleader>l
local vimtex_mappings = {
  ["a"] = { "Context Menu" },
  ["C"] = { "Clean aux and output files" },
  ["c"] = { "Clean aux files" },
  ["e"] = { "View errors" },
  ["g"] = { "Compilation status for current" },
  ["G"] = { "Compilation status for all" },
  ["I"] = { "VimTeX Info for all" },
  ["i"] = { "VimTeX Info for current" },
  ["k"] = { "Stop compilation for current" },
  ["K"] = { "Stop compilation for all" },
  ["l"] = { "Compile current" },
  ["m"] = { "Show VimTeX created insert mode mappings" },
  ["o"] = { "View compiler output" },
  ["q"] = { "Open VimTeX Log" },
  ["s"] = { "Toggle LaTeX main or subfile" },
  ["T"] = { "Toggle table of contents" },
  ["t"] = { "Open table of contents" },
  ["v"] = { "View PDF for current" },
  ["X"] = { "Reload VimTeX buffer state" },
  ["x"] = { "Reload VimTex scripts" },
}
local vimtex_nv_mappings = {
  ["L"] = { "Compile selection" },
}

local wk = require("which-key")
wk.register(tex_motions)
wk.register({
  mode = { "o", "x" },
  a = a_objects,
  i = i_objects,
})
wk.register({
  mode = { "n" },
  ["<localleader>l"] = vimtex_mappings,
})
wk.register({
  mode = { "n", "v" },
  ["<localleader>l"] = vimtex_nv_mappings,
})
