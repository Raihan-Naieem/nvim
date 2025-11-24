return {
  'meanderingprogrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  opts = {
    render_modes = { 'n', 'c', 't' },

    -- make it work like obsidian
    file_types = { 'markdown', 'md', 'html' },

    -- render html blocks inside markdown

    html = {
      enabled = true,
      render = 'all',
    },

    -- inline images / obsidian-style embedding

    image = {
      enabled = true,
      provider = 'wezterm',
      show_label = true,
      show_size = true,
      max_width = 60,
      max_height = 40,
      types = { 'png', 'jpg', 'jpeg', 'svg', 'webp', 'gif' },
    },
    -- headings similar to obsidian’s clean look
    heading = {
      enabled = true,
      sign = false,
      border = false,
      icons = { '', '', '', '', '', '' },
    },

    -- lists that look closer to obsidian
    bullet = {
      enabled = true,
      icons = { '•', '◦', '▪' },
    },

    -- code blocks with better background
    code = {
      enabled = true,
      background = 'none',
    },
  },
}
