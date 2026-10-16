return {
  'rmagatti/auto-session',
  lazy = false,

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = {
      '~/',
      '~/Projects',
      '~/Downloads',
      '/',
    },

    auto_save = true,
    auto_restore = true,

    -- Save sessions in a dedicated directory
    session_lens = {
      load_on_setup = false,
    },
  },

  keys = {
    {
      'sss',
      '<cmd>SessionSave<CR>',
      desc = 'Save Session',
    },
    {
      'ssr',
      '<cmd>SessionRestore<CR>',
      desc = 'Restore Session',
    },
    {
      'ssd',
      '<cmd>SessionDelete<CR>',
      desc = 'Delete Session',
    },
    {
      'ssf',
      '<cmd>Autosession search<CR>',
      desc = 'Find Sessions',
    },
  },
}
