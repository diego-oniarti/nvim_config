require("pre")
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
    -- {'preservim/vim-indent-guides'},
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
    },
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    {
        "lervag/vimtex",
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "zathura"  -- Set Zathura as PDF viewer
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.qf_auto_open_quickfix=0
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    }
})

local highlight = {
    "RainbowViolet",
    "RainbowCyan",
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#F09EA7" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FAFABE" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#C7CAFF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#F6CA94" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#C1EBC0" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CDABEB" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#F6C2F3" })
end)

require("ibl").setup { indent = { highlight = highlight } }


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


require("post")
