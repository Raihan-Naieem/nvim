-- Transparent background + borders that stay visible, colorscheme-safe.
-- Real see-through still comes from the terminal (kitty/wezterm/alacritty/tmux);
-- Neovim itself only needs to stop painting a background over it.
--
-- Usage: require('transparency').setup()

local M = {}

local defaults = {
  -- accent used for every border / separator
  border_fg = '#5eacd3',

  -- statusline: 'bar' (subtle opaque bar), 'transparent', or false
  statusline = 'bar',
  -- force the bar background (nil = derive it from the colorscheme)
  statusline_bg = nil,
  -- force the bar foreground (nil = keep the colorscheme's visible color)
  statusline_fg = nil,

  -- backgrounds that must stay opaque (selection / search / diff feedback)
  keep_bg = {
    'Visual',
    'Search',
    'IncSearch',
    'CurSearch',
    'MatchParen',
    'PmenuSel',
    'PmenuThumb',
    'DiffAdd',
    'DiffChange',
    'DiffDelete',
    'DiffText',
    'StatusLine',
    'StatusLineNC',
    'TabLineSel',
  },

  extra = {}, -- extra groups to make transparent
  extra_borders = {}, -- extra groups to paint with border_fg
}

local opts = vim.deepcopy(defaults)
local normal_bg_cache -- remembered between re-applications

-- Groups that hard-code a background in most colorschemes. Anything else is
-- caught by the sweep below, so this list only needs the common offenders.
local transparent_groups = {
  'Normal',
  'NormalNC',
  'NormalFloat',
  'SignColumn',
  'LineNr',
  'CursorLineNr',
  'CursorLine',
  'CursorColumn',
  'ColorColumn',
  'Folded',
  'FoldColumn',
  'EndOfBuffer',
  'Pmenu',
  'PmenuSbar',
  'MsgArea',
  'MsgSeparator',
  'WinSeparator',
  'TabLine',
  'TabLineFill',
  'TelescopeNormal',
  'TelescopePrompt',
  'TelescopeResults',
  'TelescopePreview',
  'WhichKey',
  'WhichKeyFloat',
  'WhichKeyNormal',
  'NeoTreeNormal',
  'NeoTreeNormalNC',
  'SnacksPicker',
  'SnacksPickerList',
  'SnacksPickerInput',
  'SnacksPickerPreview',
  'BlinkCmpMenu',
  'BlinkCmpDoc',
  'BlinkCmpSignatureHelp',
}

local function resolve(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if not ok or type(hl) ~= 'table' or next(hl) == nil then
    return nil
  end
  return hl
end

local function is_link(name)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
  return ok and type(hl) == 'table' and hl.link ~= nil
end

local function set(name, hl)
  pcall(vim.api.nvim_set_hl, 0, name, hl)
end

local function strip_bg(hl)
  hl.bg, hl.ctermbg = nil, nil
  return hl
end

local function clear(name)
  if is_link(name) then
    return -- transparent through its target
  end
  local hl = resolve(name)
  if hl then
    set(name, strip_bg(hl))
  end
end

local function luma(c)
  local r = math.floor(c / 65536) % 256
  local g = math.floor(c / 256) % 256
  local b = c % 256
  return (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255
end

-- Panels that are already slightly lighter than the editor background.
local function derive_bar_bg()
  for _, name in ipairs { 'TabLineFill', 'Folded', 'Pmenu', 'ColorColumn' } do
    local hl = resolve(name)
    if hl and hl.bg and hl.bg ~= normal_bg_cache then
      return hl.bg
    end
  end
  return vim.o.background == 'dark' and '#1e1e2e' or '#e6e6e6'
end

local function border_names()
  local seen, out = {}, {}
  local function add(name)
    if not seen[name] then
      seen[name] = true
      out[#out + 1] = name
    end
  end

  add 'WinSeparator'
  add 'VertSplit'
  add 'FloatBorder'
  for _, name in ipairs(opts.extra_borders) do
    add(name)
  end
  -- auto-discover: WhichKeyBorder, TelescopeBorder, SnacksPickerBorder,
  -- BlinkCmpMenuBorder, LspInfoBorder, PmenuBorder, NeoTreeWinSeparator, ...
  for name in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:match 'Border$' or name:match 'Separator$' then
      add(name)
    end
  end
  return out
end

local function paint_borders()
  for _, name in ipairs(border_names()) do
    local hl = resolve(name) -- nil when the owning plugin isn't loaded yet
    if hl then
      hl.fg, hl.ctermfg = opts.border_fg, nil
      set(name, strip_bg(hl))
    end
  end
end

local function fix_statusline()
  if opts.statusline == false then
    return
  end

  local normal_fg = (resolve 'Normal' or {}).fg

  for _, name in ipairs { 'StatusLine', 'StatusLineNC' } do
    local hl = resolve(name)
    if hl then
      -- fold `reverse` into real colors before touching the background
      if hl.reverse then
        hl.fg, hl.bg = hl.bg, hl.fg
        hl.reverse = nil
      end
      if hl.cterm then
        hl.cterm.reverse = nil
      end

      if opts.statusline == 'transparent' then
        strip_bg(hl)
      else
        local bg = opts.statusline_bg or hl.bg
        if not bg or bg == normal_bg_cache then
          bg = derive_bar_bg()
        end
        hl.bg, hl.ctermbg = bg, nil
      end

      local fg = opts.statusline_fg or hl.fg or normal_fg
      if fg and hl.bg and math.abs(luma(fg) - luma(hl.bg)) < 0.25 then
        fg = normal_fg -- theme color would be unreadable on the bar
      end
      hl.fg = fg
      set(name, hl)
    end
  end
end

local function apply_all()
  local normal = resolve 'Normal'
  if normal and normal.bg then
    normal_bg_cache = normal.bg
  end

  local keep = {}
  for _, name in ipairs(opts.keep_bg) do
    keep[name] = true
  end

  for _, name in ipairs(transparent_groups) do
    clear(name)
  end
  for _, name in ipairs(opts.extra) do
    clear(name)
  end

  -- catch every plugin group painted with the Normal background
  if normal_bg_cache then
    for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
      if not hl.link and not keep[name] and hl.bg == normal_bg_cache then
        set(name, strip_bg(hl))
      end
    end
  end

  paint_borders()
  if opts.statusline then
    fix_statusline()
  end
end

function M.setup(user)
  opts = vim.tbl_deep_extend('force', vim.deepcopy(defaults), user or {})
  apply_all()

  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = apply_all,
    desc = 'Re-apply transparency and border colors after :colorscheme',
  })

  -- Re-apply whenever lazy.nvim finishes loading a plugin: telescope, snacks,
  -- blink, which-key, ... define their highlight groups at load time, which can
  -- happen long after startup. Coalesce bursts of loads into one pass.
  local queued = false
  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyLoad',
    callback = function()
      if queued then
        return
      end
      queued = true
      vim.schedule(function()
        queued = false
        apply_all()
      end)
    end,
    desc = 'Re-apply transparency after a plugin defines its highlights',
  })
end

M.apply = apply_all

return M
