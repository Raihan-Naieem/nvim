return {
  'Godswill-255/colorviewer.nvim',
  ft = 'css',
  config = function()
    require('colorviewer').setup {
      symbol = '■',
    }
  end,
}
