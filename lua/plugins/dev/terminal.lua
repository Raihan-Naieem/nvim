return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup {
      size = 15,
      open_mapping = [[<C-\>]],
      direction = 'horizontal',
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      float_opts = {
        border = 'curved',
      },
    }

    local map = vim.keymap.set

    -- Toggle the default terminal
    map({ 'n', 't' }, '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' })

    -- Open a floating terminal
    map({ 'n', 't' }, '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Floating Terminal' })

    -- Open a vertical terminal
    map({ 'n', 't' }, '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Vertical Terminal' })

    -- Toggle specific terminals
    map({ 'n', 't' }, '<leader>t1', '<cmd>1ToggleTerm<CR>', { desc = 'Terminal 1' })
    map({ 'n', 't' }, '<leader>t2', '<cmd>2ToggleTerm<CR>', { desc = 'Terminal 2' })
    map({ 'n', 't' }, '<leader>t3', '<cmd>3ToggleTerm<CR>', { desc = 'Terminal 3' })

    -- Exit terminal mode with Escape
    map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit Terminal Mode' })

    -- Navigate between windows from terminal mode
    map('t', '<C-h>', [[<C-\><C-n><C-w>h]], { desc = 'Move to left window' })
    map('t', '<C-j>', [[<C-\><C-n><C-w>j]], { desc = 'Move to lower window' })
    map('t', '<C-k>', [[<C-\><C-n><C-w>k]], { desc = 'Move to upper window' })
    map('t', '<C-l>', [[<C-\><C-n><C-w>l]], { desc = 'Move to right window' })
  end,
}
