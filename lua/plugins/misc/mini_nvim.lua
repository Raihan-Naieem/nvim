return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      --  - saiw - [S]urround
      require('mini.surround').setup()

      -- dot repeat

      -- mini.operators keymap summary:
      --  g=  → evaluate expression and replace with result
      --  gx  → exchange two text regions (like swap)
      --  gm  → multiply (duplicate) selected text
      --  gr  → replace selection with register content
      --  gs  → sort lines or text blocks
      --
      -- Works in:
      --  • Normal mode: operates on textobjects (like `gqap`)
      --  • Visual mode: operates on selection
      --
      -- Default behavior:
      --  - `gx` remapped to `gX` (swap)
      --  - `gr*` disables default LSP rename mappings
      --  - `reindent_linewise = true` keeps indentation consistent
      require('mini.operators').setup()

      require('mini.comment').setup()
      require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }

      -- cursor location to line:column
      require('mini.statusline').section_location = function()
        return '%2l:%-2v'
      end

      require('mini.pairs').setup()
      require('mini.align').setup()
      require('mini.animate').setup {
        scroll = {
          enable = false,
          -- timing = require('mini.animate').gen_timing.linear { duration = 80 },
        },
      }

      -- Basic mappings (better 'jk', save with Ctrl+S, ...)
      -- Window navigation with <C-hjkl>, resize with <C-arrow>
      -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
      -- Autocommands. Set field to `false` to disable
      -- autocommands = {
      -- -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
      -- basic = true,
      -- -- Set 'relativenumber' only in linewise and blockwise Visual mode
      --   relnum_in_visual_mode = false,
      require('mini.basics').setup()

      require('mini.bracketed').setup {
        buffer = { suffix = 'b', options = {} },
        comment = { suffix = 'c', options = {} },
        conflict = { suffix = 'x', options = {} },
        diagnostic = { suffix = 'd', options = {} },
        file = { suffix = 'f', options = {} },
        indent = { suffix = 'i', options = {} },
        jump = { suffix = 'j', options = {} },
        location = { suffix = 'l', options = {} },
        oldfile = { suffix = 'o', options = {} },
        quickfix = { suffix = 'q', options = {} },
        treesitter = { suffix = 't', options = {} },
        undo = { suffix = 'u', options = {} },
        window = { suffix = 'w', options = {} },
        yank = { suffix = 'y', options = {} },
      }

      require('mini.bufremove').setup()

      require('mini.icons').setup()
      -- require('mini.snippets').setup()
      -- require('mini.completion').setup()

      require('mini.cursorword').setup() -- doesnt work

      require('mini.indentscope').setup()

      require('mini.misc').setup()
      require('mini.notify').setup()

      require('mini.move').setup {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move current line in Normal mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },

        -- Options which control moving behavior
        options = {
          -- Automatically reindent selection during linewise vertical move
          reindent_linewise = true,
        },
      }

      require('mini.starter').setup {
        -- Whether to open starter buffer on VimEnter. Not opened if Neovim was
        -- started with intent to show something else.
        autoopen = true,

        -- Whether to evaluate action of single active item
        evaluate_single = false,

        -- Items to be displayed. Should be an array with the following elements:
        -- - Item: table with <action>, <name>, and <section> keys.
        -- - Function: should return one of these three categories.
        -- - Array: elements of these three types (i.e. item, array, function).
        -- If `nil` (default), default items will be used (see |mini.starter|).
        items = nil,

        -- Header to be displayed before items. Converted to single string via
        -- `tostring` (use `\n` to display several lines). If function, it is
        -- evaluated first. If `nil` (default), polite greeting will be used.
        header = table.concat({
          [[  /\ \▔\___  ___/\   /(●)_ __ ___  ]],
          [[ /  \/ / _ \/ _ \ \ / / | '_ ` _ \ ]],
          [[/ /\  /  __/ (_) \ V /| | | | | | |]],
          [[\_\ \/ \___|\___/ \_/ |_|_| |_| |_|]],
          [[───────────────────────────────────]],
        }, '\n'),

        -- Footer to be displayed after items. Converted to single string via
        -- `tostring` (use `\n` to display several lines). If function, it is
        -- evaluated first. If `nil` (default), default usage help will be shown.
        footer = nil,

        -- Array  of functions to be applied consecutively to initial content.
        -- Each function should take and return content for 'Starter' buffer (see
        -- |mini.starter| and |MiniStarter.content| for more details).
        content_hooks = nil,

        -- Characters to update query. Each character will have special buffer
        -- mapping overriding your global ones. Be careful to not add `:` as it
        -- allows you to go into command mode.
        query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',

        -- Whether to disable showing non-error feedback
        silent = false,
      }
    end,
  },
}
