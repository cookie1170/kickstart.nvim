-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Discard search highlight' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Turn off Q to perform last macro, footgun when recording macros
vim.keymap.set('n', 'Q', '<nop>')

-- Turn off yanking to main system clipboard when using `d` and `x`, because i think it's stupid
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { desc = 'Delete' })
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete character' })

-- Allow yanking to main clipboard via `D` and `X`
vim.keymap.set({ 'n', 'v' }, 'D', 'd', { desc = 'Delete and yank' })
vim.keymap.set({ 'n', 'v' }, 'X', 'x', { desc = 'Delete and yank character' })
