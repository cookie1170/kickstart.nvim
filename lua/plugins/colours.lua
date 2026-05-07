return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('gruvbox').setup {
      contrast = 'soft',
    }

    -- load the colourscheme
    vim.cmd.colorscheme 'gruvbox'
  end,
}
