-- lua/core/transparent.lua
local M = {}

-- Only UI groups; do NOT touch Treesitter (@*) or syntax highlights
local groups = {
  'Normal',
  'NormalNC',
  'SignColumn',
  'VertSplit',
  'StatusLine',
  'StatusLineNC',
  'NormalFloat',
  'Pmenu',
  'PmenuSel',
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

local function clear_bg()
  for _, g in ipairs(groups) do
    -- Only clear background
    pcall(vim.api.nvim_set_hl, 0, g, { bg = 'NONE' })
  end
end

function M.setup()
  -- Apply immediately
  clear_bg()

  -- Re-apply transparency on colorscheme change
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = clear_bg,
    desc = 'Make normal areas transparent for any colorscheme',
  })
end

return M
