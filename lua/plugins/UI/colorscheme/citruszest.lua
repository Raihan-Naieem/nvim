return {
  {
    'zootedb0t/citruszest.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('citruszest').setup {
        styles = {},
      }

      vim.cmd.colorscheme 'citruszest'
    end,
  },
}
