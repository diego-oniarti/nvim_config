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
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    },
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
    },
    {"https://github.com/rebelot/kanagawa.nvim"},
    {"https://github.com/airblade/vim-gitgutter"},
    {"https://github.com/mhinz/vim-startify"},
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            -- Smear cursor when switching buffers
            smear_between_buffers = true,
            -- Smear cursor when moving within line or to neighbor lines
            smear_between_neighbor_lines = false,
            -- Use floating windows to display smears outside buffers.
            -- May have performance issues with other plugins.
            use_floating_windows = false,
            -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
            -- Smears will blend better on all backgrounds.
            legacy_computing_symbols_support = true,
            -- Attempt to hide the real cursor when smearing.
            hide_target_hack = true,
        },
    },
    {"https://github.com/karb94/neoscroll.nvim"},
    {
        "atiladefreitas/dooing",
        config = function()
            require("dooing").setup({
                -- your custom config here (optional)
            })
        end,
    },
    {
        "rjshkhr/shadow.nvim",
        config = function()
            vim.opt.termguicolors = true
            vim.cmd.colorscheme("shadow")
        end,
    },
    {"https://github.com/ku1ik/vim-monokai"},
    { "nvzone/timerly", dependencies = {
        "nvzone/volt",
    }},
    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },
    {
        "nvzone/showkeys",
        cmd = "ShowkeysToggle",
        opts = {
            timeout = 1,
            maxkeys = 5,
            -- more opts
        }
    },
    {
        "nvzone/typr",
        cmd = "TyprStats",
        dependencies = "nvzone/volt",
        opts = {}
    },
    {"https://github.com/andreasvc/vim-256noir"},
    {"https://github.com/Alligator/accent.vim"},
    {"https://github.com/junegunn/gv.vim"},
    {"https://github.com/mfussenegger/nvim-jdtls"},
    {"https://github.com/preservim/vim-colors-pencil"},
    {"https://github.com/kien/ctrlp.vim"},
    {"https://github.com/bohlender/vim-smt2"},
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        build = "make install_jsregexp"
    },
    {
        "L3MON4D3/LuaSnip",
        requires = { "rafamadriz/friendly-snippets" },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "f3fora/cmp-spell", -- Spell suggestions
        },
    },
})

require("neoscroll").setup {}
require("luasnip.loaders.from_vscode").lazy_load() -- For friendly-snippets

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
-- require("ibl").setup { indent = { highlight = highlight } }


require('lualine').setup {
    -- options = {
    --     theme = 'horizon' -- onedark powerline_dark
    -- },
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
--vim.cmd.colorscheme('one')
--vim.cmd.colorscheme('wildcharm')
--vim.opt.background="light"
--vim.cmd.colorscheme("kanagawa-dragon")
vim.cmd.colorscheme("rose-pine")
--vim.cmd.colorscheme("monokai")
--vim.cmd.colorscheme("shadow")
--vim.cmd.colorscheme("256_noir")

vim.g.accent_colour = 'magenta'
vim.g.accent_darken = 1
vim.g.nofrils_heavylinenumbers = 1

-- vim.cmd.colorscheme("accent")
-- vim.cmd.colorscheme("nofrils-light")

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
function ClearBg()
    vim.api.nvim_set_hl(0, "Normal", {bg="none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg="none"})
    vim.api.nvim_set_hl(0, "LineNr", {bg="none"})
    vim.api.nvim_set_hl(0, "StatusLike", {bg="none"})
    vim.api.nvim_set_hl(0, "VertSplit", {bg="none"})
end

vim.opt.expandtab = true
vim.opt.guicursor = 'i:ver50'

vim.o.wrap = false
-- Enable wrap only for .tex files

vim.g.startify_session_persistence = 1
vim.g.startify_session_autoload = 1
vim.g.startify_change_to_dir = 1
-- vim.g.startify_disable_at_vimenter = 1

require 'nvim-treesitter.install'.prefer_git = false
require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

-- require('showkeys').toggle()
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Default configuration (for code files)
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),
        ['<CR>'] = cmp.mapping.abort(),

        -- Snippet navigation (reintroduced)
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip', priority = 900 },
        { name = 'buffer', priority = 800 },
        { name = 'path', priority = 700 },
    })
})

-- Text file overrides (markdown, tex, txt)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { 'en', 'it' }

        cmp.setup.buffer({
            sources = cmp.config.sources({
                -- LaTeX gets LSP first, others get spell first
                vim.bo.filetype == 'tex' and { name = 'nvim_lsp', priority = 1000 } or { name = 'spell', priority = 1000 },
                vim.bo.filetype == 'tex' and { name = 'spell', priority = 900 } or { name = 'nvim_lsp', priority = 900 },
                { name = 'buffer', priority = 800 },
                { name = 'luasnip', priority = 700 },
                { name = 'path', priority = 600 },
            }),
            mapping = cmp.mapping.preset.insert({
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end),
            })
        })
    end
})

vim.g.do_filetype_lua = 1

-- Add custom filetypes
vim.filetype.add({
    extension = {
        cnf = "dimacs",
        icnf = "icnf",
        p = "tptp",
        smt2 = "smt2",
        zf = "zf"
    }
})

local lsp = require('lsp-zero')
lsp.configure('dolmenls', {})
lsp.setup_servers({'dolmenls'})

require("post")

print("Diego Oniarti")
