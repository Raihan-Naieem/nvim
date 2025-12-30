--fold
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = true
vim.o.foldlevel = 99 -- Prevent everything from starting folded

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for autoindent
vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true

-- vim.o.mouse = 'a'
vim.o.showmode = false

vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.smartcase = true
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.scroll = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.confirm = true
