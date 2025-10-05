return {
  'zaldih/themery.nvim',
  config = function()
    require('themery').setup {
      themes = {
        'gruber-darker',
        'tokyonight',
        'citruszest',
        'neofusion',
      },
      livePreview = true, -- preview before applying
    }

    -- Keymap: <leader>ct to open Themery
    vim.keymap.set('n', '<leader>st', '<cmd>Themery<CR>', { desc = '[S]elect [T]heme' })
  end,
}
