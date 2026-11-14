local M = {}

local active = nil

-- Two cells that share their middle border, so the result looks like:
--   ╭─ Old ─┬─ New ─╮
--   │ text  │ text  │
--   ╰───────┴───────╯
local BORDER_LEFT = { '╭', '─', '┬', '│', '┴', '─', '╰', '│' }
local BORDER_RIGHT = { '┬', '─', '╮', '│', '╯', '─', '┴', '│' }
local WINHIGHLIGHT = 'NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle'

local function cell_width()
  return math.max(10, math.min(50, math.floor((vim.o.columns - 3) / 2) - 2))
end

local function left_col()
  local total = 2 * cell_width() + 3
  return math.max(0, math.floor((vim.o.columns - total) / 2) + 1)
end

local function right_col()
  return left_col() + cell_width() + 1
end

local function cell_text(cell)
  return cell:lines(1, -1)[1] or ''
end

local function visual_prefill()
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' and mode ~= '\22' then
    return nil
  end

  local ok, lines = pcall(vim.fn.getregion, vim.fn.getpos 'v', vim.fn.getpos '.', { type = mode })
  local esc = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(esc, 'nx', false)

  if not ok or not lines or #lines == 0 then
    return nil
  end

  local text = table.concat(lines, '\n')
  if text:find '\n' then
    return nil
  end

  return text
end

--- Replace a literal string in a buffer.
--- The old/new strings are matched exactly and case-sensitively. An empty
--- replacement is valid and deletes the matches. No substitution message is
--- shown and no confirmation is requested.
local function apply(old, new, bufnr)
  if old == '' then
    return
  end

  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local pattern = '\\V' .. vim.fn.escape(old, '\\/') .. '\\C'
  local replacement = vim.fn.escape(new, '\\/&~')
  local cmd = ('silent keepjumps keeppatterns %%s/%s/%s/g'):format(pattern, replacement)

  vim.api.nvim_buf_call(bufnr, function()
    local view = vim.fn.winsaveview()
    if pcall(vim.cmd, cmd) then
      pcall(vim.fn.winrestview, view)
    end
  end)
end

M.apply = apply

function M.open()
  if active then
    return
  end

  local Snacks = require 'snacks'
  local parent_win = vim.api.nvim_get_current_win()
  local parent_buf = vim.api.nvim_get_current_buf()

  local old_text = visual_prefill() or vim.fn.expand '<cword>'

  local left, right
  local augroup

  local function focus_cell(cell)
    if not cell or not cell:valid() then
      return
    end

    cell:focus()
    vim.api.nvim_win_set_cursor(cell.win, { 1, #cell_text(cell) })
    vim.cmd 'startinsert!'
  end

  local function close()
    local state = active
    if not state then
      return
    end
    active = nil

    if state.augroup then
      pcall(vim.api.nvim_del_augroup_by_id, state.augroup)
    end

    vim.cmd 'stopinsert'
    pcall(function()
      state.left:close()
    end)
    pcall(function()
      state.right:close()
    end)

    if state.parent_win and vim.api.nvim_win_is_valid(state.parent_win) then
      pcall(vim.api.nvim_set_current_win, state.parent_win)
    end
  end

  local function confirm()
    local state = active
    if not state then
      return
    end

    local old = cell_text(state.left)
    local new = cell_text(state.right)

    if old == '' then
      focus_cell(state.left)
      vim.api.nvim_echo({ { 'Old string cannot be empty', 'WarningMsg' } }, false, {})
      return
    end

    local buf = state.buf
    close()

    vim.schedule(function()
      apply(old, new, buf)
    end)
  end

  local actions = {
    cancel = close,
    confirm = confirm,
    -- Tab/Shift-Tab wrap around, so either key always moves to the other cell.
    focus_new = function()
      if vim.api.nvim_get_current_win() == right.win then
        focus_cell(left)
      else
        focus_cell(right)
      end
    end,
    focus_old = function()
      if vim.api.nvim_get_current_win() == left.win then
        focus_cell(right)
      else
        focus_cell(left)
      end
    end,
  }

  local keys = {
    q = 'cancel',
    n_esc = { '<esc>', 'cancel', mode = 'n' },
    i_esc = { '<esc>', 'cancel', mode = 'i' },
    n_cr = { '<cr>', 'confirm', mode = 'n' },
    i_cr = { '<cr>', 'confirm', mode = 'i' },
    n_tab = { '<tab>', 'focus_new', mode = 'n' },
    i_tab = { '<tab>', 'focus_new', mode = 'i' },
    n_s_tab = { '<s-tab>', 'focus_old', mode = 'n' },
    i_s_tab = { '<s-tab>', 'focus_old', mode = 'i' },
    n_c_l = { '<c-l>', 'focus_new', mode = 'n' },
    i_c_l = { '<c-l>', 'focus_new', mode = 'i' },
    n_c_h = { '<c-h>', 'focus_old', mode = 'n' },
    i_c_h = { '<c-h>', 'focus_old', mode = 'i' },
    n_c_c = { '<c-c>', 'cancel', mode = 'n' },
    i_c_c = { '<c-c>', 'cancel', mode = 'i' },
  }

  local function win_opts(title, col, border, text)
    return {
      relative = 'editor',
      position = 'float',
      row = 2,
      col = col,
      width = cell_width,
      height = 1,
      border = border,
      title = title,
      title_pos = 'center',
      enter = false,
      show = false,
      backdrop = false,
      minimal = true,
      zindex = 60,
      wo = {
        winhighlight = WINHIGHLIGHT,
        cursorline = false,
        number = false,
        relativenumber = false,
        signcolumn = 'no',
        wrap = false,
        winblend = 0,
      },
      bo = {
        buftype = 'nofile',
        bufhidden = 'wipe',
        swapfile = false,
        modifiable = true,
        filetype = 'replace_input',
      },
      b = { completion = false },
      text = { text },
      keys = keys,
      actions = actions,
    }
  end

  left = Snacks.win(win_opts(' Old ', left_col, BORDER_LEFT, old_text))
  right = Snacks.win(win_opts(' New ', right_col, BORDER_RIGHT, ''))

  left:show()
  right:show()

  active = {
    left = left,
    right = right,
    parent_win = parent_win,
    buf = parent_buf,
  }

  augroup = vim.api.nvim_create_augroup('ReplaceStringInput', { clear = true })
  active.augroup = augroup

  -- Clicking a cell should put us straight back into insert mode, without
  -- moving the cursor away from the position that was clicked.
  for _, cell in ipairs { left, right } do
    vim.api.nvim_create_autocmd('BufEnter', {
      group = augroup,
      buffer = cell.buf,
      callback = function()
        local buf = cell.buf
        if not active or vim.api.nvim_get_current_buf() ~= buf then
          return
        end

        vim.schedule(function()
          if not active or vim.api.nvim_get_current_buf() ~= buf then
            return
          end
          if not vim.fn.mode():find '[iR]' then
            vim.cmd 'startinsert'
          end
        end)
      end,
    })
  end

  -- If one of the floating windows is closed from the outside, close the other.
  vim.api.nvim_create_autocmd('WinClosed', {
    group = augroup,
    callback = function(event)
      if not active then
        return
      end
      if tonumber(event.match) == left.win or tonumber(event.match) == right.win then
        vim.schedule(close)
      end
    end,
  })

  if old_text ~= '' then
    focus_cell(right)
  else
    focus_cell(left)
  end
end

vim.api.nvim_create_user_command('ReplaceString', function()
  M.open()
end, { desc = 'Replace a literal string in the current buffer' })

return M
