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

    image = {
      enabled = true,
      provider = 'wezterm',
      show_label = true,
      show_size = true,

      max_width = function()
        return vim.api.nvim_win_get_width(0)
      end,

      max_height = function()
        return vim.api.nvim_win_get_height(0)
      end,

      types = { 'png', 'jpg', 'jpeg', 'svg', 'webp', 'gif' },
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
