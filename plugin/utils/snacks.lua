vim.pack.add { gh 'folke/snacks.nvim' }

require('snacks').setup {
  input = { -- replaces the default `vim.ui.input`
    enabled = true,
  },
  picker = { -- a picker, required as a dep for `gh` and `explorer`
    enabled = true,
  },
  gh = { -- browse and edit github issues and pull requests
    enabled = true,
  },
  explorer = { -- a file explorer in the sidebar
    enabled = true,
  },
  bigfile = { -- makes neovim better at beeg files
    enabled = true,
  },
  indent = { -- indent guides
    enabled = true,
  },
  notifier = { -- prettier `vim.notify()`
    enabled = true,
    timeout = 3000,
  },
  scratch = { -- scratch buffers
    enabled = true,
    win_by_ft = {
      lua = {
        keys = {
          ['source'] = { -- evaluate lua code with <C-CR>
            '<C-CR>',
            function(self)
              local name = 'scratch.' .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.buf), ':e')
              Snacks.debug.run { buf = self.buf, name = name }
            end,
            desc = 'Source buffer',
            mode = { 'n', 'x' },
          },
        },
      },
    },
  },

  dashboard = { -- a dashboard at startup
    enabled = true,
    preset = {
      pick = 'Telescope',
      keys = {
        { icon = ' ', key = 'f', desc = 'Find [F]ile', action = ':Telescope find_files' },
        { icon = '󰥨 ', key = 'd', desc = 'Find [D]irectory', action = ":lua require('telescope').extensions.zoxide.list()" },
        { icon = ' ', key = 'n', desc = '[N]ew File', action = ':ene | startinsert' },
        { icon = ' ', key = 'r', desc = '[R]ecent Files', action = ':Telescope oldfiles' },
        { icon = ' ', key = 'c', desc = '[C]onfig', action = ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath 'config' })" },
        { icon = ' ', key = 's', desc = 'Restore [S]ession', action = ':Persisted load_last' },
        { icon = ' ', key = 'q', desc = '[Q]uit', action = ':qa' },
      },
    },
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },

  styles = {
    input = {
      -- show the input under the cursor
      relative = 'cursor',
      row = 1,
      col = 0,
    },
  },
}

vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File [E]xplorer' })
vim.keymap.set('n', '<leader>ghi', function() Snacks.picker.gh_issue() end, { desc = '[G]it[H]ub [I]ssues (open)' })
vim.keymap.set('n', '<leader>ghI', function() Snacks.picker.gh_issue { state = 'all' } end, { desc = '[G]it[H]ub [I]ssues (all)' })
vim.keymap.set('n', '<leader>ghp', function() Snacks.picker.gh_pr() end, { desc = '[G]it[H]ub [P]ull requests (open)' })
vim.keymap.set('n', '<leader>ghP', function() Snacks.picker.gh_pr { state = 'all' } end, { desc = '[G]it[H]ub [P]ull requests (all)' })
vim.keymap.set('n', '<leader>ts', function() Snacks.scratch() end, { desc = '[T]oggle [S]cratch buffer' })
vim.keymap.set('n', '<leader>sS', function() Snacks.scratch.select() end, { desc = '[S]earch [S]cratch buffer' })
