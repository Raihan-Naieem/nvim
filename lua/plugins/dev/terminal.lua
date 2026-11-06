return {
  'akinsho/toggleterm.nvim',

  config = function()
    local TerminalModule = require 'toggleterm.terminal'
    local Terminal = TerminalModule.Terminal
    local map = vim.keymap.set

    -- =====================================================
    -- CONFIGURATION VARIABLES
    -- =====================================================

    local horizontal_size = 10
    local vertical_size = 40

    -- =====================================================
    -- TOGGLETERM SETUP
    -- =====================================================

    require('toggleterm').setup {
      size = horizontal_size,
      direction = 'horizontal',
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,

      float_opts = {
        border = 'curved',
      },
    }

    -- =====================================================
    -- THREE INDEPENDENT HORIZONTAL TERMINALS
    -- =====================================================

    local horizontal = {
      [1] = Terminal:new {
        count = 1,
        direction = 'horizontal',
        size = horizontal_size,
        hidden = true,
      },

      [2] = Terminal:new {
        count = 2,
        direction = 'horizontal',
        size = horizontal_size,
        hidden = true,
      },

      [3] = Terminal:new {
        count = 3,
        direction = 'horizontal',
        size = horizontal_size,
        hidden = true,
      },
    }

    -- Track terminal slots that the user has opened.
    local used_horizontal = {}

    -- Open or toggle an individual horizontal terminal.
    local function toggle_horizontal(index)
      used_horizontal[index] = true
      horizontal[index]:toggle()
    end

    map('n', '<leader>t1', function()
      toggle_horizontal(1)
    end, { desc = 'Toggle Horizontal Terminal 1' })

    map('n', '<leader>t2', function()
      toggle_horizontal(2)
    end, { desc = 'Toggle Horizontal Terminal 2' })

    map('n', '<leader>t3', function()
      toggle_horizontal(3)
    end, { desc = 'Toggle Horizontal Terminal 3' })

    -- Toggle only previously used horizontal terminals.
    -- Never open unused terminal slots.
    local function toggle_used_horizontal()
      local used = {}

      for i = 1, 3 do
        if used_horizontal[i] then
          used[#used + 1] = horizontal[i]
        end
      end

      -- First invocation opens terminal 1 only.
      if #used == 0 then
        toggle_horizontal(1)
        return
      end

      -- If any used terminal is open, close the open ones.
      -- If all used terminals are hidden, reopen them.
      local any_open = false

      for _, term in ipairs(used) do
        if term:is_open() then
          any_open = true
          break
        end
      end

      for _, term in ipairs(used) do
        if any_open then
          if term:is_open() then
            term:close()
          end
        else
          term:open()
        end
      end
    end

    map('n', '<leader>t', toggle_used_horizontal, {
      desc = 'Toggle Used Horizontal Terminals',
    })

    map('n', '<leader>tt', toggle_used_horizontal, {
      desc = 'Toggle Used Horizontal Terminals',
    })

    -- =====================================================
    -- KILL THE FOCUSED TERMINAL PROCESS
    -- =====================================================

    local function kill_focused_terminal()
      local buf = vim.api.nvim_get_current_buf()
      local job_id = vim.b[buf].terminal_job_id

      if not job_id then
        vim.notify('No terminal process in the current buffer', vim.log.levels.WARN)
        return
      end

      local term

      for _, candidate in ipairs(TerminalModule.get_all()) do
        if candidate.bufnr == buf then
          term = candidate
          break
        end
      end

      if term then
        term:shutdown()
      else
        vim.fn.jobstop(job_id)
      end
    end

    map('t', '<leader>tq', function()
      vim.cmd 'stopinsert'
      kill_focused_terminal()
    end, {
      desc = 'Kill Focused Terminal Process',
    })

    -- Also allow killing the focused terminal from normal mode
    map('n', '<leader>tq', kill_focused_terminal, {
      desc = 'Kill Focused Terminal Process',
    })

    -- =====================================================
    -- PERSISTENT FLOATING TERMINAL
    -- =====================================================

    local floating = Terminal:new {
      count = 4,
      direction = 'float',
      hidden = true,

      float_opts = {
        border = 'curved',
      },
    }

    map({ 'n', 't' }, '<leader>tf', function()
      floating:toggle()
    end, {
      desc = 'Toggle Floating Terminal',
    })

    -- =====================================================
    -- PERSISTENT VERTICAL TERMINAL
    -- =====================================================

    local vertical = Terminal:new {
      count = 5,
      direction = 'vertical',
      size = vertical_size,
      hidden = true,
    }

    map({ 'n', 't' }, '<leader>tv', function()
      vertical:toggle()
    end, {
      desc = 'Toggle Vertical Terminal',
    })

    -- =====================================================
    -- TERMINAL MODE MAPPINGS
    -- =====================================================

    -- Exit terminal mode without closing the terminal.
    map('t', '<Esc>', [[<C-\><C-n>]], {
      desc = 'Exit Terminal Mode',
    })

    -- Navigate between Neovim windows from terminal mode.
    map('t', '<C-h>', [[<C-\><C-n><C-w>h]], {
      desc = 'Move to Left Window',
    })

    map('t', '<C-j>', [[<C-\><C-n><C-w>j]], {
      desc = 'Move to Lower Window',
    })

    map('t', '<C-k>', [[<C-\><C-n><C-w>k]], {
      desc = 'Move to Upper Window',
    })

    map('t', '<C-l>', [[<C-\><C-n><C-w>l]], {
      desc = 'Move to Right Window',
    })
  end,
}
