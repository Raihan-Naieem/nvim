-- Fedora's /etc/profile.d/wezterm.sh wraps its OSC sequences in tmux DCS
-- passthrough when $TMUX is set. Neovim's :terminal can't unwrap passthrough,
-- so the payload (1337;SetUserVar=..., OSC 7 cwd) is printed as literal text.
-- None of it is usable inside nvim anyway, so skip it for spawned processes.
vim.env.WEZTERM_SHELL_SKIP_ALL = '1'

--fold
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldenable = true
vim.o.foldlevel = 99 -- Prevent everything from starting folded

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.tabstop = 2 -- Number of spaces a tab counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for autoindent

vim.o.wrap = true
vim.o.breakindent = true -- wrap follows indent
vim.o.linebreak = true

vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true

vim.o.winborder = 'rounded'
vim.o.winbl = 100
vim.o.pumborder = 'rounded'
vim.o.pummaxwidth = 80

-- vim.o.mouse = 'a'
vim.o.showmode = false

-- Show the statusline for every window (2 = global statusline)
vim.o.laststatus = 2

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
vim.o.list = false
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.scroll = 15 -- Minimal number of screen lines to keep above (CTRL-U) and below (CTRL-D) the cursor.
vim.o.confirm = true

-- new shit
vim.bo.autoindent = true -- new line same indent as prev line
vim.bo.autoread = true -- auto read change outside of vim (thank allah!)s
vim.bo.autocomplete = false

-- vim.g.clipboard = 'osc52' -- works with ssh, tmux
