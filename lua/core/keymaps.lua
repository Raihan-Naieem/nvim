-- save, quit
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'save' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'quit' })

vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'open project view' })
vim.keymap.set('n', '<leader>Q', vim.diagnostic.setloclist, { desc = 'open diagnostic [q]uickfix list' })
-- vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'exit terminal mode' })
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'move focus to the left window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'move focus to the right window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'move focus to the lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'move focus to the upper window' })
vim.keymap.set('n', '<c-s-h>', '<c-w>h', { desc = 'move window to the left' })
vim.keymap.set('n', '<c-s-l>', '<c-w>l', { desc = 'move window to the right' })
vim.keymap.set('n', '<c-s-j>', '<c-w>j', { desc = 'move window to the lower' })
vim.keymap.set('n', '<c-s-k>', '<c-w>k', { desc = 'move window to the upper' })

-- makes cursor fixed in middle when using j and k to scroll

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', 'j', 'jzz', opts)
vim.api.nvim_set_keymap('n', 'k', 'kzz', opts)
