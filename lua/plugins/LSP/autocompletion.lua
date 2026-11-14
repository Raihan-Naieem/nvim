return {
  -- Autocompletion
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',

    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end

          return 'make install_jsregexp'
        end)(),

        dependencies = {
          'rafamadriz/friendly-snippets',
        },

        opts = {},
      },
    },

    opts = {
      keymap = {
        preset = 'default',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 1000,
        },
      },

      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
        },

        per_filetype = {
          opencode_ask = { 'lsp' },
        },

        -- providers ={
        --    snippets = {
        --     score_offset = 200,
        --   },
        --
        --   buffer = {
        --     score_offset = 160,
        --   },
        --
        --   lsp = {
        --     score_offset = 130,
        --   },
        --
        --   path = {
        --     score_offset = 80,
        --   },
        --
        --   omni = {
        --     score_offset = 30,
        --   },
        -- },
      },

      snippets = {
        preset = 'luasnip',
      },

      fuzzy = {
        implementation = 'lua',
        sorts = {
          'exact',
          'score',
          'sort_text',
        },
      },

      signature = {
        enabled = true,
      },
    },

    config = function(_, opts)
      local luasnip = require 'luasnip'

      -- Extend JavaScript snippets to TypeScript filetypes
      luasnip.filetype_extend('typescript', { 'javascript' })
      luasnip.filetype_extend('typescriptreact', {
        'javascriptreact',
        'typescript',
      })

      -- Load friendly-snippets (found via package.json manifests in runtimepath)
      require('luasnip.loaders.from_vscode').lazy_load()

      -- Load custom snippets from snippets/*.json as standalone collections.
      -- Each snippet file's "scope" field (e.g. "http", "prisma") restricts it
      -- to that filetype, so they do NOT leak into other buffers.
      -- Drop a new .json file in snippets/ and it's picked up on restart.
      local snippet_dir = vim.fn.stdpath 'config' .. '/snippets'
      for _, file in ipairs(vim.fn.glob(snippet_dir .. '/*.json', false, true)) do
        require('luasnip.loaders.from_vscode').load_standalone {
          path = file,
          lazy = true, -- also pick up files created after startup
        }
      end

      require('blink.cmp').setup(opts)
    end,
  },
}
