vim.g.mapleader = " "
vim.keymap.set("n", "<C-e>", vim.cmd.Ex)
vim.keymap.set("n", "<C-h>", vim.cmd.bp)
vim.keymap.set("n", "<C-l>", vim.cmd.bn)

--[[
vim.keymap.set('n', '<C-s>f', builtin.find_files, {})
vim.keymap.set('n', '<C-s>g', builtin.live_grep, {})
vim.keymap.set('n', '<C-s>b', builtin.buffers, {})
vim.keymap.set('n', '<C-s>h', builtin.help_tags, {})
--]]
