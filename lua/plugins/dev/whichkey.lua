return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 0,
    icons = {
      mappings = vim.g.have_nerd_font,
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        C = '<C-…> ',
        M = '<M-…> ',
        D = '<D-…> ',
        S = '<S-…> ',
        CR = '<CR> ',
        Esc = '<Esc> ',
        ScrollWheelDown = '<ScrollWheelDown> ',
        ScrollWheelUp = '<ScrollWheelUp> ',
        NL = '<NL> ',
        BS = '<BS> ',
        Space = '<Space> ',
        Tab = '<Tab> ',
        F1 = '<F1>',
        F2 = '<F2>',
        F3 = '<F3>',
        F4 = '<F4>',
        F5 = '<F5>',
        F6 = '<F6>',
        F7 = '<F7>',
        F8 = '<F8>',
        F9 = '<F9>',
        F10 = '<F10>',
        F11 = '<F11>',
        F12 = '<F12>',
      },
    },
    spec = {
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle terminal' },
      { 'M-h', group = '[H]arpoon' },
      { '<leader>p', group = '[P]roject' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>o', group = '[O]pencode', mode = { 'n', 'x' } },
      { '<leader>r', group = '[R]un cpp' },
      { '<leader>l', group = '[L]azy git' },
      { '<leader>l', group = '[L]azy git' },
      { '<leader>o', group = '[O]penCode' },

      -- tmux stuff ctrl-b
      {
        '<C-b>',
        group = '[T]mux',
        mode = 'n',
        {
          name = 'Sessions',
          '<C-b>s',
          desc = 'List sessions',
        },
        { '<C-b>d', desc = 'Detach session' },

        { '<C-b>c', desc = 'Create window' },
        { '<C-b>w', desc = 'List windows' },
        { '<C-b>n', desc = 'Next window' },
        { '<C-b>p', desc = 'Previous window' },
        { '<C-b>&', desc = 'Kill window' },

        { '<C-b>%', desc = 'Split vertical' },
        { '<C-b>"', desc = 'Split horizontal' },
        { '<C-b>o', desc = 'Next pane' },
        { '<C-b>x', desc = 'Kill pane' },
        { '<C-b>z', desc = 'Zoom pane' },
        { '<C-b>q', desc = 'Show pane numbers' },
      },
    },
  },
}

-----------------------------------------------------
