vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Put the current buffer path in the terminal title so tmux can display it.
-- 'autochdir' is on, so we resolve against the directory nvim was launched in.
local launch_cwd = vim.fn.getcwd()

local function vim_relative_path()
  local name = vim.api.nvim_buf_get_name(0)
  if name == '' then
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
  end
  name = name:gsub('^%a[%w+.-]*://', '') -- keep oil:// etc. out of the title
  local abs = vim.fn.fnamemodify(name, ':p'):gsub('/+$', '')
  if vim.fn.isdirectory(abs) == 1 then
    return vim.fn.fnamemodify(abs, ':~')
  end
  local prefix = launch_cwd .. '/'
  if abs:sub(1, #prefix) == prefix then
    return abs:sub(#prefix + 1)
  end
  return vim.fn.fnamemodify(abs, ':~')
end

vim.o.title = true
vim.api.nvim_create_autocmd({ 'BufEnter', 'DirChanged', 'VimEnter' }, {
  group = vim.api.nvim_create_augroup('tmux-title', { clear = true }),
  callback = function()
    vim.o.titlestring = vim_relative_path()
  end,
})
