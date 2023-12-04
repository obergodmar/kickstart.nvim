local devicons = require('nvim-web-devicons')
local entry_display = require('telescope.pickers.entry_display')
local make_entry = require('telescope.make_entry')
local plenary_strings = require('plenary.strings')
local utils = require('telescope.utils')

local icon_width = plenary_strings.strdisplaywidth(devicons.get_icon('fname', { default = true }))

---@param fileName string
---@return string tail, string display_path
local function get_tail_and_path(fileName)
  local tail = utils.path_tail(fileName)
  local path = require('plenary.strings').truncate(fileName, #fileName - #tail, '')

  local display_path = utils.transform_path({
    path_display = { 'truncate' },
  }, path)

  return tail, display_path
end

---@param picker_and_options { picker: 'find_files' | 'git_files' | 'oldfiles', options: {}}
local function custom_files_picker(picker_and_options)
  if type(picker_and_options) ~= 'table' or picker_and_options.picker == nil then
    print("Incorrect argument format. Correct format is: { picker = 'name', (optional) options = { ... } }")
    return
  end

  local files_picker_types = { ['find_files'] = true, ['git_files'] = true, ['oldfiles'] = true }
  local picker = picker_and_options.picker
  if not files_picker_types[picker] then
    if picker == '' then
      print('Picker was not specified')
      return
    end

    print('Picker ' .. picker .. ' is not supported')
    return
  end

  local options = picker_and_options.options or {}

  local entry_maker = make_entry.gen_from_file(options)
  options.entry_maker = function(line)
    local entry_table = entry_maker(line)
    local displayer = entry_display.create({
      separator = ' ', -- Telescope will use this separator between each entry item
      items = {
        { width = icon_width },
        { width = nil },
        { remaining = true },
      },
    })

    entry_table.display = function(entry)
      local tail, path = get_tail_and_path(entry.value)
      local display_tail = tail .. ' '

      local icon, icon_highlighted = utils.get_devicons(tail)

      return displayer({
        { icon, icon_highlighted },
        display_tail,
        { path, 'TelescopeResultsComment' },
      })
    end

    return entry_table
  end

  if picker == 'find_files' then
    require('telescope.builtin').find_files(options)
  elseif picker == 'git_files' then
    require('telescope.builtin').git_files(options)
  elseif picker == 'oldfiles' then
    require('telescope.builtin').oldfiles(options)
  end
end

---@param picker_and_options { picker: 'live_grep' | 'grep_string' | 'live_grep_args', options: {}}
local function custom_grep_picker(picker_and_options)
  if type(picker_and_options) ~= 'table' or picker_and_options.picker == nil then
    print("Incorrect argument format. Correct format is: { picker = 'name', (optional) options = { ... } }")
    return
  end

  local files_picker_types = { ['live_grep'] = true, ['grep_string'] = true, ['live_grep_args'] = true }
  local picker = picker_and_options.picker
  if not files_picker_types[picker] then
    if picker == '' then
      print('Picker was not specified')
      return
    end

    print('Picker ' .. picker .. ' is not supported')
    return
  end

  local options = picker_and_options.options or {}

  local entry_maker = make_entry.gen_from_vimgrep(options)
  options.entry_maker = function(line)
    local entry_table = entry_maker(line)

    local displayer = entry_display.create({
      separator = ' ', -- Telescope will use this separator between each entry item
      items = {
        { width = icon_width },
        { width = nil },
        { width = nil }, -- Maximum path size, keep it short
        { remaining = true },
      },
    })

    entry_table.display = function(entry)
      local tail, path = get_tail_and_path(entry.filename)

      local icon, icon_highlighted = utils.get_devicons(tail)

      local coordinates = ''
      if not options.disable_coordinates then
        if entry.lnum then
          if entry.col then
            coordinates = string.format(' -> %s:%s', entry.lnum, entry.col)
          else
            coordinates = string.format(' -> %s', entry.lnum)
          end
        end
      end

      -- Append coordinates to tail
      tail = tail .. coordinates .. ' '

      -- Encode text if necessary
      ---@diagnostic disable-next-line: param-type-mismatch
      local text = options.file_encoding and vim.iconv(entry.text, options.file_encoding, 'utf8') or entry.text

      return displayer({
        { icon, icon_highlighted },
        tail,
        { path, 'TelescopeResultsComment' },
        text,
      })
    end

    return entry_table
  end

  if picker == 'live_grep' then
    require('telescope.builtin').live_grep(options)
  elseif picker == 'grep_string' then
    require('telescope.builtin').grep_string(options)
  elseif picker == 'live_grep_args' then
    require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy(options))
  end
end

return {
  custom_files_picker = custom_files_picker,
  custom_grep_picker = custom_grep_picker,
}
