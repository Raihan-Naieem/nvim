return { -- Auto-close and auto-rename JSX/HTML tags via treesitter
  'windwp/nvim-ts-autotag',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    opts = { -- General options
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
    per_filetype = { html = { enable_close = false } }, -- available if ever needed
  },
}
