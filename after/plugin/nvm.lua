local is_mac = vim.fn.has "macunix" == 1
local home_dir = "/home/obergodmar"

if not is_mac then
  local node_bin = "/.nvm/versions/node/v16.19.0/bin"
  vim.g.node_host_prog = home_dir .. node_bin .. "/node"

  -- for mason.nvim
  -- prereq - install lsp server in that node/bin npm i -g typescript-language-server
  -- (handled by :Mason currently)
  vim.cmd("let $PATH = '" .. home_dir .. node_bin .. ":' . $PATH")
end
