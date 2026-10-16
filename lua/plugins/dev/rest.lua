return {

  {
    'rest-nvim/rest.nvim',
    version = false,
    build = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
    },
    opts = {},
    keys = {
      { '<leader>r', '<cmd>Rest run<cr>', ft = 'http', desc = 'Run HTTP Request' },
    },
  },
}
