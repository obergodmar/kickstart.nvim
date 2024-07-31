---@param c  string
local function rgb(c)
  c = string.lower(c)
  return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
local function blend(foreground, alpha, background)
  alpha = type(alpha) == 'string' and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background)
  local fg = rgb(foreground)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format('#%02x%02x%02x', blendChannel(1), blendChannel(2), blendChannel(3))
end

local function darken(hex, amount, bg)
  return blend(hex, amount, bg or '#000000')
end

---@type LazyPluginSpec
local P = {
  'Mofiqul/dracula.nvim',
  opts = {},
  config = function()
    local dracula = require('dracula')
    local colors = dracula.colors()

    dracula.setup({
      italic_comment = true,
      overrides = {
        DiffAdd = { bg = darken(colors.bright_green, 0.15) },
        DiffDelete = { fg = colors.bright_red },
        DiffChange = { bg = darken(colors.comment, 0.15) },
        DiffText = { bg = darken(colors.comment, 0.50) },
        illuminatedWord = { bg = darken(colors.comment, 0.65) },
        illuminatedCurWord = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordText = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordRead = { bg = darken(colors.comment, 0.65) },
        IlluminatedWordWrite = { bg = darken(colors.comment, 0.65) },
      },
    })

    vim.cmd.colorscheme('dracula')
  end,
}

return P
