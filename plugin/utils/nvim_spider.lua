-- improves w, e, b motions by skipping insignificant punctuation and navigating subwords
--
-- insignificant punctuation skipping:
-- foo == bar .. "baz"
--     ^      ^    significant punctuation
--  foo:find("a")
--     ^    ^  ^  insignificant punctuation
--
-- subword navigation:
-- positions vim's `w` will move to
-- local myVariableName = FOO_BAR_BAZ
--       ^              ^ ^
-- positions spider's `w` will move to
-- local myVariableName = FOO_BAR_BAZ
--       ^ ^       ^    ^ ^   ^   ^

vim.pack.add { gh 'chrisgrieser/nvim-spider' }
require('spider').setup {}

vim.keymap.set({ 'n', 'o', 'x' }, 'w', function() require('spider').motion 'w' end)
vim.keymap.set({ 'n', 'o', 'x' }, 'e', function() require('spider').motion 'e' end)
vim.keymap.set({ 'n', 'o', 'x' }, 'b', function() require('spider').motion 'b' end)
vim.keymap.set({ 'n', 'o', 'x' }, 'ge', function() require('spider').motion 'ge' end)
