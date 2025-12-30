-- MUST LOAD BEFORE EVERYTHING ELSE!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- temp2

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

-- use gy to system copy and gp to system paste
vim.opt.clipboard = ''

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
