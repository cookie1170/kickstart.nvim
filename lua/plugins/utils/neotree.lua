return { -- A file picker
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false, -- neo-tree lazy loads itself!
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    window = {
      mappings = {
        ['<space>'] = {
          'open', -- by default it's toggle_node, which doesn't open the file
          nowait = false,
        },
      },
    },
  },
  keys = {
    {
      '<leader>n',
      '<cmd>Neotree<CR>',
      desc = 'Focus [n]eo-tree',
      silent = true,
    },
  },
}
