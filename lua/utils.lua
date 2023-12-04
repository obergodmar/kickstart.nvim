---@return boolean
local function is_win()
  return vim.fn.has('win32') == 1
end

---@return boolean
local function is_mac()
  return jit.os == 'OSX'
end

---@return string
local function get_shell()
  local pwsh = 'pwsh.exe -nologo -WorkingDirectory ' .. vim.loop.cwd()

  if is_win() then
    return vim.fn.executable('pwsh') and pwsh or 'powershell.exe'
  end

  return vim.shell
end

return {
  is_mac = is_mac,
  is_win = is_win,
  get_shell = get_shell,
}
