return {
  {
    'jiaoshijie/undotree',
    dependencies = 'nvim-lua/plenary.nvim',
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
        layout = 'left_bottom',
        ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt' },
        window = {
          winblend = 20,
          width = 20,
        },
      }
    end,
  },
}
