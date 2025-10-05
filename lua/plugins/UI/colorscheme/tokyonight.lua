return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        transparent = true,
        styles = {
          comments = { italic = true, fg = '#65806c' }, -- Disable italics in comments
        },
      }

      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },
}
