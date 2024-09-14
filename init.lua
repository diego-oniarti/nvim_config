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
    {'preservim/vim-indent-guides'},
    {'aznhe21/actions-preview.nvim'},
    {'tpope/vim-fugitive'},
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        --     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

    --{'vim-airline/vim-airline'},
    --{'vim-airline/vim-airline-themes'},
    {
        "lervag/vimtex",
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "zathura"  -- Set Zathura as PDF viewer
            vim.g.vimtex_compiler_method = "latexmk"
        end,
    },
})

require('lualine').setup {
    options = {
        theme = 'onedark'
    },
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'}
    }
}

vim.g["airline#extensions#bufferline#enabled"] = 1
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

--[[
vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''
vim.g.airline_symbols.branch = ''
vim.g.airline_symbols.colnr = ' ℅:'
vim.g.airline_symbols.readonly = ''
vim.g.airline_symbols.linenr = ' :'
vim.g.airline_symbols.maxlinenr = '☰ '
vim.g.airline_symbols.dirty='⚡'
--]]

vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>", { noremap = true, silent = true })  -- Compile the document
vim.keymap.set("n", "<leader>lv", ":VimtexView<CR>", { noremap = true, silent = true })    -- Open PDF in Zathura
