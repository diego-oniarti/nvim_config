require("pre")

-- Lazy.nvim setup
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    print('Installing lazy.nvim...')
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    -------------------- UI --------------------
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "nvim-lualine/lualine.nvim", event = "VeryLazy" },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}, event = "BufReadPre" },
    { "nvim-mini/mini.nvim" },
    { "karb94/neoscroll.nvim", event = "VeryLazy", config = function() require('neoscroll').setup() end },

    -------------------- Editing --------------------
    { "tpope/vim-surround", event = "BufReadPre" },
    { "tpope/vim-repeat", event = "BufReadPre" },
    { "tpope/vim-fugitive" },
    { "junegunn/gv.vim", lazt = true},
    { "airblade/vim-gitgutter", event = "BufReadPre" },

    -------------------- LSP & Completion --------------------
    { "VonHeikemen/lsp-zero.nvim", branch = "v4.x", dependencies = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim", build = ":MasonUpdate" },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
        {
            'aznhe21/actions-preview.nvim',
            event = "BufReadPre",
            keys = { {"<C-s>z", function() require("actions-preview").code_actions() end, desc = "Code Actions"} }
        }

    }},

    -------------------- Syntax & Highlighting --------------------
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = { "BufReadPost", "BufNewFile" } },
    { "norcalli/nvim-colorizer.lua", event = "BufReadPre" },
    { "MeanderingProgrammer/render-markdown.nvim", opts = {}, ft = { "markdown" } },

    -------------------- Telescope --------------------
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, cmd = "Telescope" },
    { "nvim-telescope/telescope-file-browser.nvim", cmd = "Telescope" },
    { "nvim-telescope/telescope-media-files.nvim" },

    -------------------- Utilities --------------------
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<C-s>a", function() require("harpoon").setup(); require("harpoon").list():add() end, desc = "Harpoon Add" },
            { "<C-s>d", function() require("harpoon").ui:toggle_quick_menu(require("harpoon").list()) end, desc = "Harpoon Toggle" },
            { "<C-s>h", function() require("harpoon").list():prev() end, desc = "Harpoon Prev" },
            { "<C-s>l", function() require("harpoon").list():next() end, desc = "Harpoon Next" },
        }
    },
    { "lervag/vimtex", ft = { "tex" } },
    -- { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, cmd = "Trouble" },
    -- { "azabiong/vim-highlighter", event = "BufReadPre" },
    { "folke/which-key.nvim", event = "VeryLazy", opts = { delay = 5000 } },
    { "nvzone/volt", lazy = true },
    { "nvzone/minty", event = "VeryLazy", cmd = { "Shades", "Huefy" } },
    { "nvzone/showkeys", event = "VeryLazy", cmd = "ShowkeysToggle", opts = { timeout = 1, maxkeys = 5  } },

    -------------------- Colors --------------------
    { "rose-pine/neovim", name = "rose-pine", lazy = true },
    { "rakr/vim-one", name = "one", lazy = true },
    { "rjshkhr/shadow.nvim", lazy = true, config = function() vim.opt.termguicolors = true vim.cmd.colorscheme("shadow") end },
    { "ku1ik/vim-monokai", lazy = true },
    { "rebelot/kanagawa.nvim", lazy = true },
    { "andreasvc/vim-256noir", lazy = true },
    { "Alligator/accent.vim", lazy = true },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

require("mini.sessions").setup()
require("mini.starter").setup()

-- UI tweaks
require("neoscroll").setup({})
require("luasnip.loaders.from_vscode").lazy_load()
require('telescope').load_extension('media_files')

local highlight = {
    "RainbowViolet",
    "RainbowCyan",
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
}

-- Rainbow indent
local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#F09EA7" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FAFABE" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#C7CAFF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#F6CA94" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#C1EBC0" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CDABEB" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#F6C2F3" })
end)

-- Lualine
require('lualine').setup {
    tabline = {
        lualine_a = {{ 'buffers', show_filename_only = false }},
        lualine_z = {'tabs'}
    }
}

-- Colorscheme
vim.cmd.colorscheme("kanagawa-dragon")

-- LSP-zero + Mason setup
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

require('mason').setup()
require('mason-lspconfig').setup({
    automatic_installation = false,
    handlers = {
        lsp.default_setup,
    }
})

lsp.setup()

-- CMP + LuaSnip setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),
        ['<CR>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip', priority = 900 },
    }),
})

-- Filetype-specific CMP overrides
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "tex", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
        vim.opt_local.spelllang = { 'en', 'it' }
        cmp.setup.buffer({
            sources = cmp.config.sources({
                { name = 'spell', priority = 1000 },
                { name = 'buffer', priority = 800 },
            })
        })
    end
})

vim.g.do_filetype_lua = 1
vim.filetype.add({ extension = { cnf = "dimacs", icnf = "icnf", p = "tptp", smt2 = "smt2", zf = "zf" } })

-- Color helpers
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

require("post")
