local utils = require('helpers.utils')

if utils.is_neovide() then
  if utils.is_mac() then
    vim.o.guifont = 'Iosevka Nerd Font:b:h15'
  else
    vim.o.guifont = 'Iosevka Nerd Font:b:h12'
  end
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true

  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  if utils.is_mac() or utils.is_win() then
    vim.g.neovide_scale_factor = 1.0
  else
    -- 0.65 because linux x11 fractonal scaling is enabled and
    -- global scale is 175%
    vim.g.neovide_scale_factor = 0.65
  end

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set('n', '<C-=>', function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set('n', '<C-->', function()
    change_scale_factor(1 / 1.25)
  end)
end
