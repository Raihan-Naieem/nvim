-- save, quit
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'save' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit Neovim' })

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'open project view' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'open diagnostic [q]uickfix list' })
vim.keymap.set({ 'n', 'x' }, 'grS', function()
  require('core.replace').open()
end, { desc = 'Replace a literal string in the buffer' })
-- vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'exit terminal mode' })
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'move focus to the left window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'move focus to the right window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'move focus to the lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'move focus to the upper window' })
vim.keymap.set('n', '<c-s-h>', '<c-w>h', { desc = 'move window to the left' })
vim.keymap.set('n', '<c-s-l>', '<c-w>l', { desc = 'move window to the right' })
vim.keymap.set('n', '<c-s-j>', '<c-w>j', { desc = 'move window to the lower' })
vim.keymap.set('n', '<c-s-k>', '<c-w>k', { desc = 'move window to the upper' })

-- Alternative window navigation: Alt/Ctrl + hjkl and arrow keys (Normal + Terminal mode)
-- <C-h/j/k/l> are already mapped above (normal mode) and in
-- plugins/dev/terminal.lua (terminal mode), so they are not repeated here.
local window_nav = {
  { '<A-h>', 'h', 'left' },
  { '<A-j>', 'j', 'lower' },
  { '<A-k>', 'k', 'upper' },
  { '<A-l>', 'l', 'right' },
  { '<A-Left>', 'h', 'left' },
  { '<A-Down>', 'j', 'lower' },
  { '<A-Up>', 'k', 'upper' },
  { '<A-Right>', 'l', 'right' },
  { '<C-Left>', 'h', 'left' },
  { '<C-Down>', 'j', 'lower' },
  { '<C-Up>', 'k', 'upper' },
  { '<C-Right>', 'l', 'right' },
}

for _, nav in ipairs(window_nav) do
  local lhs, dir, name = nav[1], nav[2], nav[3]

  vim.keymap.set('n', lhs, '<C-w>' .. dir, { desc = 'move focus to the ' .. name .. ' window' })

  vim.keymap.set('t', lhs, function()
    -- Leave terminal-mode synchronously, then move to the adjacent window
    local escape = vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true)
    vim.api.nvim_feedkeys(escape, 'x', false)
    vim.cmd('wincmd ' .. dir)
    -- If the target window is another terminal, resume terminal input there
    if vim.bo.buftype == 'terminal' then
      vim.cmd 'startinsert'
    end
  end, { desc = 'move focus to the ' .. name .. ' window from terminal' })
end

-- Send x and c to the black-hole register (content discarded)
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'c', '"_c', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'C', '"_C', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
-- vim.keymap.set({ 'n', 'v' }, 'D', '"_D', { noremap = true })

-- makes cursor fixed in middle when using j and k to scroll
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'j', 'jzz', opts)
vim.api.nvim_set_keymap('n', 'k', 'kzz', opts)
