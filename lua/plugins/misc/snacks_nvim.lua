return {

  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      input = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      image = { enabled = true },
      dim = { enabled = true },

      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
          easing = 'linear',
        },
        animate_repeat = {
          delay = 100,
          duration = { step = 5, total = 50 },
          easing = 'linear',
        },
        filter = function(buf)
          return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= 'terminal'
        end,
      },

      terminal = { enabled = true },
    },

    keys = {
      {
        '<leader>t',
        function()
          Snacks.terminal()
        end,
        mode = { 'n', 't' }, -- n = normal, t = terminal
        desc = 'Toggle Terminal',
      },
    },
  },
}
