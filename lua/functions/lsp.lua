local M = {}

---Set Ltex LSP server to run or stop
---Inverted because the toggle function assumes the start state to be true
---@param stop boolean Whether to stop the server (true) or start it (false)
function M.setLtex(stop)
  if stop then
    vim.lsp.stop_client(vim.lsp.get_clients({ name = "ltex" }))
  else
    vim.cmd("LspStart ltex")
  end
end

--- If Ltex is running, returns false.
--- If Ltex is stopped, returns true.
---@return boolean
function M.getLtex()
  local clients = vim.lsp.get_clients({ name = "ltex" })
  local stopped = #clients == 0
  return stopped
end

return M
