local M = {}

local groups = {
  'Normal',
  'NormalNC',
  'SignColumn',
  'VertSplit',
  'StatusLine',
  'StatusLineNC',
  'NormalFloat',
  'Pmenu',
  'LineNr',
  'CursorLineNr',
  'FloatBorder',
  'CursorLine',
  'CursorColumn',
  'TelescopeNormal',
  'TelescopePrompt',
  'TelescopeResults',
  'WhichKeyFloat',
  'WhichKey',
  'Folded',
  'CmpItemAbbr',
  'CmpItemAbbrDeprecated',
  'CmpItemKind',
  'CmpItemMenu',
}

-- add border highlight groups
local border_groups = {
  'WinSeparator',
  'FloatBorder',
  'TelescopeBorder',
  'WhichKeyBorder',
  'LspInfoBorder',
  'CmpBorder',
}

local function clear_bg()
  for _, g in ipairs(groups) do
    pcall(vim.api.nvim_set_hl, 0, g, { bg = 'NONE' })
  end
end

local function apply_borders()
  for _, g in ipairs(border_groups) do
    -- set visible border color with transparent background
    pcall(vim.api.nvim_set_hl, 0, g, { fg = '#5eacd3', bg = 'NONE' })
  end
end

function M.setup()
  clear_bg()
  apply_borders()

  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      clear_bg()
      apply_borders()
    end,
    desc = 'Re-apply transparency and borders on colorscheme change',
  })
end

return M
