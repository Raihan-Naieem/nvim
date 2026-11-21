return {
  {
    'rest-nvim/rest.nvim',
    version = false,
    build = false,

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
    },

    opts = {},

    keys = {
      {
        '<leader>r',
        '<cmd>Rest run<cr>',
        ft = 'http',
        desc = 'Run HTTP Request',
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'http', 'json' },
    },
  },
}
