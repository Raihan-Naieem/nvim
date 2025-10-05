return {
  {
    'diegoulloao/neofusion.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('neofusion').setup {
        styles = {},
      }

      vim.cmd.colorscheme 'neofusion'
    end,
  },
}
