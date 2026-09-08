return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',

    opts = {
      ensure_installed = {
        -- Shell
        'bash',

        -- C/C++
        'c',
        'cpp',

        -- Python
        'python',

        -- Lua
        'lua',
        'luadoc',

        -- JavaScript ecosystem
        'javascript',
        'typescript',
        'jsx',
        'tsx',

        -- Web
        'html',
        'css',
        'scss',
        'xml',

        -- Backend / Systems
        'go',
        'rust',
        'java',

        -- Config / Data
        'json',
        'yaml',
        'toml',
        'regex',

        -- Markdown
        'markdown',
        'markdown_inline',

        -- Git
        'gitignore',
        'diff',

        -- Neovim
        'query',
        'vim',
        'vimdoc',

        -- Templates
        'jinja',

        -- Docker
        'dockerfile',
      },

      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },

      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },
  },
}
