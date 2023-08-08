local opt = vim.opt

opt.inccommand = 'split'
opt.smarttab = true
opt.backspace = { 'start', 'eol', 'indent' }
opt.title = true
opt.titlestring = '%F'
opt.cursorline = true
opt.expandtab = true -- Use spaces instead of tabs
opt.pumblend = 10 -- Popup blend
opt.mouse = 'a' -- Enable mouse mode
opt.clipboard = 'unnamedplus'
opt.breakindent = true -- Enable break indent
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.undofile = true -- Save undo history
opt.ignorecase = true
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.updatetime = 250
opt.timeout = true
opt.timeoutlen = 300
opt.completeopt = 'menuone,noselect'
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

if vim.fn.has 'win32' == 1 then
  vim.api.nvim_exec('language en_US', true)
  opt.ff = 'unix'
else
  opt.shell = 'zsh'
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
