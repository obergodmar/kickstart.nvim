---@type LazyPluginSpec
local P = {
  -- Useful plugin to show you pending keybinds.
  'obergodmar/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local lmu = require('langmapper.utils')
    local view = require('which-key.view')
    local execute = view.execute

    -- wrap `execute()` and translate sequence back
    view.execute = function(prefix_i, mode, buf)
      -- Translate back to English characters
      prefix_i = lmu.translate_keycode(prefix_i, 'default', 'ru')
      execute(prefix_i, mode, buf)
    end

    -- If you want to see translated operators, text objects and motions in
    -- which-key prompt
    -- local presets = require('which-key.plugins.presets')
    -- presets.operators = lmu.trans_dict(presets.operators)
    -- presets.objects = lmu.trans_dict(presets.objects)
    -- presets.motions = lmu.trans_dict(presets.motions)
    -- etc

    require('which-key').setup({
      plugins = {
        marks = false,
        registers = false,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      triggers_blacklist = {
        o = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k' }),
        i = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k' }),
        n = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k' }),
        v = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k' }),
      },
    })
  end,
}

return P
