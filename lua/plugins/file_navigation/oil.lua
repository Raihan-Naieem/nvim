return {
  'stevearc/oil.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,

  keys = {
    {
      '\\',
      function()
        if vim.bo.filetype == 'oil' then
          vim.cmd 'bd'
        else
          require('oil').open()
        end
      end,
      desc = 'Toggle Oil',
    },
  },

  opts = {
    default_file_explorer = true,

    keymaps = {
      ['<BS>'] = 'actions.parent',
    },

    view_options = {
      show_hidden = true,
    },

    columns = {
      'icon',
    },
  },
}
