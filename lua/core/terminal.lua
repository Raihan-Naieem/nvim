-- Shared floating terminal used by both the terminal plugin config and
-- opencode.nvim, so `<leader>tf` and OpenCode always reuse the same window.
local M = {}

local floating

local function create_float(opts)
  local Terminal = require('toggleterm.terminal').Terminal

  return Terminal:new(vim.tbl_deep_extend('force', {
    count = 4,
    direction = 'float',
    hidden = true,
    float_opts = {
      border = 'curved',
    },
  }, opts or {}))
end

---@return toggleterm.Terminal
function M.floating()
  if not floating then
    floating = create_float { cmd = 'opencode' }
  end

  return floating
end

---Open the OpenCode TUI, focusing it if it is already open.
function M.open()
  local term = M.floating()

  if term:is_open() then
    term:focus()
  else
    term:open()
  end
end

---Toggle the OpenCode TUI.
function M.toggle()
  M.floating():toggle()
end

---Send raw keys to the OpenCode TUI.
---@param keys string
function M.send(keys)
  M.open()

  local term = M.floating()
  if term.job_id then
    vim.api.nvim_chan_send(term.job_id, keys)
  end
end

return M
