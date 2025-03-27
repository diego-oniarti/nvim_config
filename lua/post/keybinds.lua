vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<C-h>", vim.cmd.bp)
vim.keymap.set("n", "<C-l>", vim.cmd.bn)

vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>", { noremap = true, silent = true })  -- Compile the document
vim.keymap.set("n", "<leader>lv", ":VimtexView<CR>", { noremap = true, silent = true })    -- Open PDF in Zathura

vim.keymap.set("n", "<C-s>z", function()
    require("actions-preview").code_actions()
end, { noremap = true, silent = true })

local harpoon = require("harpoon")
harpoon.setup()
vim.g.mapleader = ' '
vim.keymap.set("n", "<C-s>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-s>d", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-s>q", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-s>e", function() harpoon:list():next() end)

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-s>f', builtin.find_files, {})
vim.keymap.set('n', '<C-s>c', builtin.live_grep, {})
vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>r', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, {})

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

vim.keymap.set('n', '<leader>bd', ':bp | sp | bn | bd!<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
