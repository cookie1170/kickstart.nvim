-- some miscellanious utilities

vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- a session manager
vim.pack.add { gh 'olimorris/persisted.nvim' }
require('persisted').setup {}

vim.api.nvim_create_autocmd('User', {
  pattern = 'PersistedSavePre',
  callback = function()
    -- close all snacks picker buffers (such as the explorer) as they mess with the saving
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local filetype = vim.bo[buf].filetype
      if filetype == 'snacks_layout_box' or filetype == 'snacks_picker_input' or filetype == 'snacks_picker_list' then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
})

-- useful plugin to show pending keybinds
vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  -- delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },

  -- document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
    { '<leader>gh', group = '[G]it[H]ub', mode = { 'n' } },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
  },
}
vim.keymap.set({ 'n', 'v', 'i' }, '<C-?>', ':WhichKey<CR>', { silent = true })

-- plugin for resolving git merge conflicts
vim.pack.add { gh 'akinsho/git-conflict.nvim' }

require('git-conflict').setup {}

-- highlight todo, notes, etc in comments:
-- PERF:
-- TEST:
-- TODO:
-- NOTE:
-- WARN:
-- HACK:
-- FIXME:
-- REMOVE:
-- SAFETY:
vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup {
  keywords = {
    FIX = { icon = ' ', color = 'error', alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' } },
    TODO = { icon = ' ', color = 'info' },
    HACK = { icon = ' ', color = 'warning' },
    WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
    PERF = { icon = ' ', color = 'test', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
    TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
    NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
    SAFETY = { color = 'error' },
    REMOVE = { icon = ' ', color = 'error' },
  },
}

-- use `:terminal` in a floating window
vim.pack.add { gh 'voldikss/vim-floaterm' }
vim.keymap.set({ 'n', 't' }, '<M-t>', '<C-\\><C-n>:FloatermToggle<CR>', {
  desc = 'Toggle the floating [T]erminal',
  silent = true,
})

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>:FloatermKill<CR>', {
  desc = 'Exit floating terminal',
  silent = true,
})
