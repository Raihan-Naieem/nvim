return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      ts.setup {}
      local install = ts.install or require('nvim-treesitter.install').install
      install {
        'bash',
        'c',
        'cpp',
        'python',
        'lua',
        'luadoc',
        'javascript',
        'typescript',
        'jsx',
        'tsx',
        'html',
        'css',
        'xml',
        'go',
        'rust',
        'java',
        'json',
        'yaml',
        'toml',
        'regex',
        'markdown',
        'markdown_inline',
        'gitignore',
        'diff',
        'query',
        'vim',
        'vimdoc',
        'dockerfile',
      }
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
