return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  opts = function()
    local ok, opencode = pcall(require, 'opencode')
    if not ok then
      return {}
    end
    return {
      sections = {
        lualine_z = { opencode.statusline },
      },
    }
  end,
}
