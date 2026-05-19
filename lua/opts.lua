-- set <space> as the leader key
-- see `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- make line numbers default
vim.opt.number = true
-- relative line numbers, to help with jumping
vim.opt.relativenumber = true

-- enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- make `foldlevel` a very high number to have all folds open by default
vim.opt.foldlevel = 999

-- sync clipboard between OS and Neovim
-- schedule the setting after `UiEnter` because it can increase startup-time
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- enable break indent
vim.opt.breakindent = true

-- enable undo/redo changes even after closing and reopening a file
vim.opt.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- change indentation width
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- decrease update time
vim.opt.updatetime = 250

-- decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- sets how neovim will display certain whitespace characters in the editor
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- show which line your cursor is on
vim.opt.cursorline = true

-- minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- neovide (vim gui) options
-- set the font and font size
vim.opt.guifont = 'SauceCodePro Nerd Font:h11'

-- tweak the cursor animation a bit
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_cursor_trail_size = 0.75
