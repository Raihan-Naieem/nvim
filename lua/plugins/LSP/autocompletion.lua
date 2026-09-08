return {
  { -- Autocompletion
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
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },

    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        per_filetype = { opencode_ask = { 'lsp' } },

        transform_items = function(ctx, items)
          if ctx.line:sub(ctx.cursor[2], ctx.cursor[2]) == '.' then
            local kinds = require('blink.cmp.types').CompletionItemKind

            items = vim.tbl_filter(function(item)
              return item.kind ~= kinds.Snippet
            end, items)
          end

          return items
        end,

        providers = {
          snippets = {
            score_offset = 120,
          },

          lazydev = {
            module = 'lazydev.integrations.blink',
            score_offset = 90,
          },

          lsp = {
            score_offset = 100,
          },

          path = {
            score_offset = 80,
          },
        },
      },

      snippets = {
        preset = 'luasnip',
      },

      fuzzy = {
        implementation = 'lua',
      },

      signature = {
        enabled = true,
      },
    },
  },
}
