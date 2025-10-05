return {
  {
    'blazkowolf/gruber-darker.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('gruber-darker').setup {
        styles = {},
      }

      vim.cmd.colorscheme 'gruber-darker'
    end,
  },
}
