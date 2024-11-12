vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "100"
vim.g.autoformat = false
vim.opt_local.spell = true

local wk = require("which-key")
wk.add({
  { "]]", desc = "Next section end" },
  { "][", desc = "Next section start" },
  { "[]", desc = "Previous section end" },
  { "[[", desc = "Previous section start" },
  { "]m", desc = "Next env start" },
  { "]M", desc = "Next env end" },
  { "[m", desc = "Previous env start" },
  { "[M", desc = "Previous env end" },
  { "]n", desc = "Next math start" },
  { "]N", desc = "Next math end" },
  { "[n", desc = "Previous math start" },
  { "[N", desc = "Previous math end" },
  { "]r", desc = "Next frame start" },
  { "]R", desc = "Next frame end" },
  { "[r", desc = "Previous frame start" },
  { "[R", desc = "Previous frame end" },
  { "]/", desc = "Next LaTeX comment start" },
  { "]*", desc = "Next LaTeX comment end" },
  { "[/", desc = "Previous LaTeX comment start" },
  { "[*", desc = "Previous LaTeX comment end" },
})

local tex_objects = {
  { "$", desc = "Math environment" },
  { "d", desc = "Delimiter" },
  { "e", desc = "Environment" },
  { "m", desc = "Item" },
  { "P", desc = "Section" },
}
local obj_mapping = { mode = { "o", "x" } }
for prefix, name in pairs({
  i = "inside",
  a = "around",
}) do
  obj_mapping[#obj_mapping + 1] = { prefix, group = name }
  for _, obj in ipairs(tex_objects) do
    obj_mapping[#obj_mapping + 1] = { prefix .. obj[1], desc = obj.desc }
  end
end
obj_mapping[#obj_mapping + 1] = { "aC", "<Plug>(vimtex-ac)", "Command" }
obj_mapping[#obj_mapping + 1] = { "iC", "<Plug>(vimtex-ic)", "Command" }
wk.add(obj_mapping, { notify = false })

-- The mappings found after <localleader>l
local vimtex_local_mappings = {
  { "a", desc = "Context Menu" },
  { "C", desc = "Clean aux and output files" },
  { "c", desc = "Clean aux files" },
  { "e", desc = "View errors" },
  { "g", desc = "Compilation status for current" },
  { "G", desc = "Compilation status for all" },
  { "I", desc = "VimTeX Info for all" },
  { "i", desc = "VimTeX Info for current" },
  { "k", desc = "Stop compilation for current" },
  { "K", desc = "Stop compilation for all" },
  { "l", desc = "Compile current" },
  { "m", desc = "Show VimTeX created insert mode mappings" },
  { "o", desc = "View compiler output" },
  { "q", desc = "Open VimTeX Log" },
  { "s", desc = "Toggle LaTeX main or subfile" },
  { "T", desc = "Toggle table of contents" },
  { "t", desc = "Open table of contents" },
  { "v", desc = "View PDF for current" },
  { "X", desc = "Reload VimTeX buffer state" },
  { "x", desc = "Reload VimTex scripts" },
}
local local_mappings = {
  { "<localleader>l", group = "vimtex" },
}
for _, map in ipairs(vimtex_local_mappings) do
  local_mappings[#local_mappings + 1] = { "<localleader>l" .. map[1], desc = map.desc }
end
local_mappings[#local_mappings + 1] = { "<localleader>lL", desc = "Compile Selection", mode = { "n", "x" } }
wk.add(local_mappings)

wk.add({
  { "<F6>", desc = "VimTeX Surround", mode = { "n", "x" } },
  { "<F7>", desc = "VimTeX Create Command", mode = { "n", "x", "i" } },
  { "<F8>", desc = "VimTeX Add Modifiers", mode = { "n" } },
})

local mp = require("mini.pairs")
mp.map_buf(0, "i", "$", { action = "closeopen", pair = "$$" })
-- mp.map_buf(0, "i", "`", { action = "closeopen", pair = "`'" })

-- Change timeoutlen when opening tex file, otherwise can't type captial Vimtex imaps fast enough
vim.opt.timeoutlen = vim.g.vscode and 1000 or 400

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
