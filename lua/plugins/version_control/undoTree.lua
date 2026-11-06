return {
  {
    'jiaoshijie/undotree',
    dependencies = { 'nvim-lua/plenary.nvim' },

    keys = {
      {
        '<leader>u',
        function()
          require('undotree').toggle()
        end,
        desc = 'Toggle Undotree',
        mode = 'n',
      },
    },

    config = function()
      require('undotree').setup {
        float_diff = true,
        layout = 'float',
        ignore_filetype = {
          'undotree',
          'undotreeDiff',
          'qf',
          'TelescopePrompt',
        },
        window = {
          winblend = 20,
          width = 30,
        },
      }
    end,
  },
}
