return {
  { 'NMAC427/guess-indent.nvim', opts = {} },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      signs = {
        add = { text = '+' }, ---@diagnostic disable-line: missing-fields
        change = { text = '~' }, ---@diagnostic disable-line: missing-fields
        delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Next change' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Previous change' })

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]eset hunk' })

        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[S]tage hunk' })

        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = '[R]eset hunk' })

        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review hunk' })
        map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview hunk [I]nline' })

        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = '[B]lame line' })
        map('n', '<leader>hB', gitsigns.blame, { desc = 'Open [B]lame' })

        map('n', '<leader>hd', gitsigns.diffthis, { desc = '[D]iff this' })

        map('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = '[D]iff parent' })

        map('n', '<leader>hq', gitsigns.setqflist, { desc = '[Q]uickfix list' })
        map('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = '[Q]uickfix list all' })

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle line [B]lame' })
        map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle [W]ord diff' })

        -- Text object
        map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'inner hunk' })
      end,
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
    keys = {
      { '<C-?>', ':WhichKey<CR>', silent = true, mode = { 'n', 'v', 'i' } },
    },
  },

  {
    -- Highlight todo, notes, etc in comments:
    -- PERF:
    -- TEST:
    -- NOTE:
    -- TODO:
    -- WARN:
    -- HACK:
    -- FIXME:
    -- REMOVE:
    -- SAFETY:
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = {
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
    },
  },

  { -- Automatically close character pairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  {
    'norcalli/nvim-colorizer.lua',
    event = 'VimEnter',
    keys = { { '<leader>tc', ':ColorizerToggle<CR>', silent = true, mode = { 'n' }, desc = '[T]oggle [C]olorizer' } },
    opts = {},
  },
}
