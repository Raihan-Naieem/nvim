-- MUST LOAD BEFORE EVERYTHING ELSE!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'core'
require 'plugins'
require('transparency').setup()

-- temp

vim.keymap.set('n', '<leader>r', function()
  vim.cmd 'write' -- save file
  local file = vim.fn.expand '%:p'
  local out = vim.fn.expand '%:p:r'
  vim.cmd('vsplit | terminal bash -c "g++ \'' .. file .. "' -o '" .. out .. "' && '" .. out .. "' ; read -p 'Press enter to exit...'\"")
end, { noremap = true, silent = true })
