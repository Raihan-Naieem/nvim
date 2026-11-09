return {
  {
    'NickvanDyke/opencode.nvim',
    branch = 'main',

    dependencies = {
      {
        'folke/snacks.nvim',
        opts = {
          input = {},
          picker = {},
        },
      },
    },

    config = function()
      vim.o.autoread = true

      local terminal = require 'core.terminal'

      ---@type opencode.Opts
      vim.g.opencode_opts = {
        server = {
          start = function()
            terminal.open()
          end,
        },
      }

      local opencode = require 'opencode'

      vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
        terminal.open()
        opencode.ask '@this: '
      end, { desc = 'OpenCode Ask' })

      vim.keymap.set({ 'n', 'x' }, '<leader>op', function()
        terminal.open()
        opencode.prompt '@this'
      end, { desc = 'OpenCode Prompt' })

      vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
        terminal.open()
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
        terminal.open()
      end, { desc = 'Focus OpenCode' })

      -- OpenCode v2 has no TUI command API; send PageUp/PageDown to the TUI.
      vim.keymap.set('n', '<leader>ou', function()
        terminal.send '\27[5~'
      end, { desc = 'Scroll OpenCode up' })

      vim.keymap.set('n', '<leader>od', function()
        terminal.send '\27[6~'
      end, { desc = 'Scroll OpenCode down' })

      vim.keymap.set('x', '<leader>oD', function()
        terminal.open()
        opencode.ask [[@this

Find the official documentation links for this selected text.
Include:
- Official documentation
- API references
- Examples
- Related resources]]
      end, { desc = 'Find Documentation' })

      -- Show the OpenCode TUI when it starts executing a prompt.
      vim.api.nvim_create_autocmd('User', {
        pattern = 'OpencodeEvent:session.execution.started',
        callback = function()
          local term = terminal.floating()
          if not term:is_open() then
            term:open()
          end
        end,
        desc = 'Show OpenCode floating terminal on execution',
      })
    end,
  },
}
