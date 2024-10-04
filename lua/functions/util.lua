local M = {}

function M.clone(org)
  table.unpack = unpack
  return { table.unpack(org) }
end

return M
