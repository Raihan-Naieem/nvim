-- MUST LOAD BEFORE EVERYTHING ELSE!!
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- temp2

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true

require 'core'
require 'plugins'
require('transparency').setup()
