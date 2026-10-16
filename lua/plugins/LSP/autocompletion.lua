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
          if vim.fn.has('win32') == 1
            or vim.fn.executable('make') == 0
          then
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
          auto_show_delay_ms = 500,
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

        transform_items = function(ctx, items)
          -- Suppress snippet templates inside member expressions,
          -- such as app., app.get, user.name, and object.method().
          local before_cursor = ctx.line:sub(1, ctx.cursor[2])

          local in_member_expression =
            before_cursor:match('%.[%w_]*$') ~= nil

          if in_member_expression then
            local kinds =
              require('blink.cmp.types').CompletionItemKind

            items = vim.tbl_filter(function(item)
              return item.kind ~= kinds.Snippet
            end, items)
          end

          return items
        end,

        providers = {
          snippets = {
            score_offset = 200,
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

    config = function(_, opts)
      require('luasnip.loaders.from_vscode').lazy_load()
      require('blink.cmp').setup(opts)
    end,
  },
}
