return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
  },
  config = function()
    require('telescope').load_extension 'lazygit'

    -- Neovim's global terminal-mode <Esc> mapping (plugins/dev/terminal.lua)
    -- would swallow Esc before LazyGit sees it. Re-map it buffer-locally to
    -- itself so the key is forwarded to the LazyGit process instead.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'lazygit',
      callback = function(event)
        vim.keymap.set('t', '<Esc>', '<Esc>', {
          buffer = event.buf,
          desc = 'Send Esc to LazyGit',
        })
      end,
    })
  end,
}
