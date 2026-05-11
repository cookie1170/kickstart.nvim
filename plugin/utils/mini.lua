-- collection of various small independent plugins/modules

vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- better Around/Inside textobjects
--
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup { n_lines = 500 }

-- add/delete/replace surroundings (brackets, quotes, etc)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- adds extra operators
--
-- - g=  - evaluate lua  and replace with output
-- - gxx - exchange lines
require('mini.operators').setup()

-- jump to a word (<CR>)
require('mini.jump2d').setup()

-- move lines
require('mini.move').setup()

-- complete character pairs
require('mini.pairs').setup()

-- a snippet engine
local loader = require('mini.snippets').gen_loader
require('mini.snippets').setup {
  snippets = {
    loader.from_lang(),
  },
}

-- special key  mappings
--
-- - <Tab>   - increase indent (when on indent)
-- - <S-Tab> - decrease indent (when on indent)
-- - <BS>    - hungry backspace (remove all whitespace before it)
local map = require('mini.keymap').map_multistep
map('i', '<Tab>', { 'increase_indent' })
map('i', '<S-Tab>', { 'decrease_indent' })
map('i', '<BS>', { 'hungry_bs', 'minipairs_bs' })

-- higlights colours in text
-- - #ffffff
-- - #4421b0
-- - #dc6625
local hipatterns = require 'mini.hipatterns'
local opts = {
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
}

-- set up hipatterns to highlight bevy `Color` structs
require('hipatterns_bevy').bevy_hipatterns(opts)
hipatterns.setup(opts)

-- simple and easy statusline
local statusline = require 'mini.statusline'
-- set use_icons to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }

-- set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end
