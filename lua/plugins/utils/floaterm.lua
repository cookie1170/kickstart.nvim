return { -- Use :terminal in a floating window
  'voldikss/vim-floaterm',
  keys = {
    {
      '<M-t>',
      '<C-\\><C-n>:FloatermToggle<CR>',
      desc = 'Toggle the floating [T]erminal',
      mode = { 'n', 't' },
      silent = true,
    },
    {
      '<Esc><Esc>',
      '<C-\\><C-n>:FloatermKill<CR>',
      desc = 'Exit floating terminal',
      mode = 't',
      silent = true,
    },
  },
}
