---@return boolean
local function is_win()
  if vim.fn.has('win32') ~= 1 then
    return false
  else
    return true
  end
end

---@return string
local function get_shell()
  if is_win() then
    return vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
  end

  return vim.shell
end

return {
  is_win = is_win,
  get_shell = get_shell,
}
