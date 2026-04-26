-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Discard search highlight' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use ALT+<HJKL> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<M-H>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<M-L>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<M-J>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<M-K>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Turn off yanking to main system clipboard when using `d` and `x`, because i think it's stupid
vim.keymap.set('n', 'd', '"_d', { desc = 'Delete' })
vim.keymap.set('n', 'x', '"_x', { desc = 'Delete character' })

-- Allow yanking to main clipboard via `D` and `X`
vim.keymap.set('n', 'D', 'd', { desc = 'Delete and yank' })
vim.keymap.set('n', 'X', 'x', { desc = 'Delete and yank character' })
