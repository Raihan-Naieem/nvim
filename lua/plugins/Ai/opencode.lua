return {
  {
    'NickvanDyke/opencode.nvim',
    version = '*',

    dependencies = {
      {
        'folke/snacks.nvim',
        opts = {
          input = {},
          picker = {},
          terminal = {},
        },
      },
    },

    config = function()
      vim.o.autoread = true

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = 'wezterm',
          wezterm = {},
        },

        events = {
          reload = true,
        },

        server = {
          start = false,
          stop = false,
          toggle = false,
        },
      }

      local opencode = require 'opencode'

      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        opencode.ask('@this: ', { submit = true })
      end, { desc = 'OpenCode Ask' })

      vim.keymap.set({ 'n', 'x' }, '<leader>op', function()
        opencode.prompt '@this'
      end, { desc = 'OpenCode Prompt' })

      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        opencode.select()
      end, { desc = 'OpenCode Select' })

      -- Operator: go{motion} to send range to opencode
      vim.keymap.set({ 'n', 'x' }, 'go', function()
        return opencode.operator '@this '
      end, { desc = 'Send range to OpenCode', expr = true })

      -- Operator: goo to send current line
      vim.keymap.set('n', 'goo', function()
        return opencode.operator '@this ' .. '_'
      end, { desc = 'Send line to OpenCode', expr = true })

      vim.keymap.set('n', '<leader>oo', function()
        opencode.command 'terminal.focus'
      end, { desc = 'Focus OpenCode' })

      vim.keymap.set('n', '<leader>ou', function()
        opencode.command 'session.half.page.up'
      end, { desc = 'Scroll up' })

      vim.keymap.set('n', '<leader>od', function()
        opencode.command 'session.half.page.down'
      end, { desc = 'Scroll down' })

      vim.keymap.set('x', '<leader>oD', function()
        opencode.ask(
          [[@this

Find the official documentation links for this selected text.
Include:
- Official documentation
- API references
- Examples
- Related resources]],
          { submit = true }
        )
      end, { desc = 'Find Documentation' })
    end,
  },
}
