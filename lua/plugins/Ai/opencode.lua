return {

  {
    'NickvanDyke/opencode.nvim',
    dependencies = {
      {
        'folke/snacks.nvim',
        opts = { input = {}, picker = {}, terminal = {} },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- custom opts if needed
        provider = {
          enabled = 'wezterm',
          wezterm = {},
        },
      }

      -- Required for reload events
      vim.o.autoread = true

      local opencode = require 'opencode'

      -- Leader-based keymaps
      vim.keymap.set({ 'x' }, '<leader>oa', function()
        opencode.ask('@this: ', { submit = true })
      end, { desc = 'opencode: ask' })

      vim.keymap.set({ 'n', 'x', 'v' }, '<leader>os', function()
        opencode.select()
      end, { desc = 'opencode: select action' })

      vim.keymap.set({ 'n', 'x', 'v' }, '<leader>op', function()
        opencode.prompt '@this'
      end, { desc = 'opencode: add context' })

      vim.keymap.set({ 'n', 't' }, '<leader>oo', function()
        opencode.toggle()
      end, { desc = 'opencode: toggle panel' })

      vim.keymap.set('n', '<leader>ou', function()
        opencode.command 'session.half.page.up'
      end, { desc = 'opencode: half page up' })

      vim.keymap.set('n', '<leader>od', function()
        opencode.command 'session.half.page.down'
      end, { desc = 'opencode: half page down' })
    end,
  },
}
