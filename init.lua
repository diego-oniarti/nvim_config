require("die")
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
    print('Installing lazy.nvim....')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'L3MON4D3/LuaSnip'},
    {'nvim-telescope/telescope.nvim', tag = '0.1.6'},
    {'rose-pine/neovim', name = 'rose-pine' },
    {'rakr/vim-one', name = 'one' },
    { "nvim-lua/plenary.nvim", lazy = true },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {'https://github.com/preservim/vim-indent-guides'},
    {
        'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    },
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {'aznhe21/actions-preview.nvim'},
    {'vim-airline/vim-airline'},
    {'vim-airline/vim-airline-themes'},
    {'bling/vim-bufferline'}
})


vim.cmd.colorscheme('one')
--vim.opt.background="light"

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)

-- to learn how to use mason.nvim with lsp-zero
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
    }
})

function ColorMyPencils(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", {bg="none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg="none"})
end

--ColorMyPencils()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-s>f', builtin.find_files, {})
vim.keymap.set('n', '<C-s>s', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<C-s>c', builtin.live_grep, {})

local harpoon = require("harpoon")
harpoon.setup()
vim.g.mapleader = ' '
vim.keymap.set("n", "<C-s>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-s>d", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-s>q", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-s>e", function() harpoon:list():next() end)

vim.keymap.set("n", "<C-s>z", function()
    require("actions-preview").code_actions()
end, { noremap = true, silent = true })

vim.opt.expandtab = true
vim.opt.guicursor = 'i:ver50'



