-- a plugin for multiple cursors
vim.pack.add { gh 'brenton-leighton/multiple-cursors.nvim' }

require('multiple-cursors').setup {
  -- incompatible with `mini.pairs`
  pre_hook = function() vim.g.minipairs_disable = true end,
  post_hook = function() vim.g.minipairs_disable = false end,
  custom_key_maps = {
    -- compatibility with `mini.move`
    { 'n', { '<A-k>', '<A-Up>' }, function() MiniMove.move_line 'up' end },
    { 'n', { '<A-j>', '<A-Down>' }, function() MiniMove.move_line 'down' end },
    { 'n', { '<A-h>', '<A-Left>' }, function() MiniMove.move_line 'left' end },
    { 'n', { '<A-l>', '<A-Right>' }, function() MiniMove.move_line 'right' end },

    { 'x', { '<A-k>', '<A-Up>' }, function() MiniMove.move_selection 'up' end },
    { 'x', { '<A-j>', '<A-Down>' }, function() MiniMove.move_selection 'down' end },
    { 'x', { '<A-h>', '<A-Left>' }, function() MiniMove.move_selection 'left' end },
    { 'x', { '<A-l>', '<A-Right>' }, function() MiniMove.move_selection 'right' end },
    -- compatibility with `nvim-spider`
    -- w
    {
      { 'n', 'x' },
      'w',
      function(_, count)
        if count ~= 0 and vim.api.nvim_get_mode().mode == 'n' then vim.cmd('normal! ' .. count) end
        require('spider').motion 'w'
      end,
    },

    -- e
    {
      { 'n', 'x' },
      'e',
      function(_, count)
        if count ~= 0 and vim.api.nvim_get_mode().mode == 'n' then vim.cmd('normal! ' .. count) end
        require('spider').motion 'e'
      end,
    },

    -- b
    {
      { 'n', 'x' },
      'b',
      function(_, count)
        if count ~= 0 and vim.api.nvim_get_mode().mode == 'n' then vim.cmd('normal! ' .. count) end
        require('spider').motion 'b'
      end,
    },
  },
}

vim.keymap.set({ 'n', 'x' }, '<M-J>', '<Cmd>MultipleCursorsAddDown<CR>', { silent = true, desc = 'Add cursor and move down' })
vim.keymap.set({ 'n', 'x' }, '<M-K>', '<Cmd>MultipleCursorsAddUp<CR>', { silent = true, desc = 'Add cursor and move up' })

vim.keymap.set({ 'n', 'i', 'x' }, '<C-Up>', '<Cmd>MultipleCursorsAddUp<CR>', { silent = true, desc = 'Add cursor and move up' })
vim.keymap.set({ 'n', 'i', 'x' }, '<C-Down>', '<Cmd>MultipleCursorsAddDown<CR>', { silent = true, desc = 'Add cursor and move down' })
vim.keymap.set({ 'n', 'i' }, '<C-LeftMouse>', '<Cmd>MultipleCursorsMouseAddDelete<CR>', { silent = true, desc = 'Add or remove cursor' })

vim.keymap.set({ 'x' }, '<Leader>m', '<Cmd>MultipleCursorsAddVisualArea<CR>', { silent = true, desc = 'Add cursors to the lines of the visual area' })
vim.keymap.set({ 'n', 'x' }, '<Leader>l', '<Cmd>MultipleCursorsLock<CR>', { silent = true, desc = '[L]ock virtual cursors' })

-- useful for placing cursors in specific spots
vim.keymap.set({ 'n', 'i', 'x' }, '<S-CR>', function()
  vim.cmd 'MultipleCursorsAddDown'
  MiniJump2d.start()
end, { silent = true, desc = 'Add cursor and jump to label' })
