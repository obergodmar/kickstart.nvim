local M = {}

---@return boolean
function M.is_win()
  return vim.fn.has('win32') == 1
end

---@return boolean
function M.is_mac()
  return jit.os == 'OSX'
end

---@return boolean
function M.is_neovide()
  return vim.g.neovide
end

---@return string
function M.get_shell()
  local pwsh = 'pwsh.exe -nologo -WorkingDirectory ' .. vim.loop.cwd()

  if M.is_win() then
    return vim.fn.executable('pwsh') and pwsh or 'powershell.exe'
  end

  return vim.shell
end

return M
