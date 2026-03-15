require("pre")

local sysname = vim.loop.os_uname().sysname

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

local highlight = {
    "RainbowViolet",
    "RainbowCyan",
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
}

-- Plugins
require("lazy").setup({
    -------------------- UI --------------------
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function ()
            require('lualine').setup {
                tabline = {
                    lualine_a = { { 'buffers', show_filename_only = false }, },
                    lualine_z = {'tabs'}
                }
            }
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",

        opts = {
            indent = {
                highlight = "IblIndent",
            },
            scope = {
                enabled = true,
                highlight = highlight,
            },
        },

        config = function(_, opts)
            local hooks = require "ibl.hooks"

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                -- rainbow colors
                vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#F09EA7" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FAFABE" })
                vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#C7CAFF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#F6CA94" })
                vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#C1EBC0" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CDABEB" })
                vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#F6C2F3" })
                vim.api.nvim_set_hl(0, "IblIndent",     { fg = "#535353" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup(opts)

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    { "nvim-mini/mini.nvim" },
    { "karb94/neoscroll.nvim", event = "VeryLazy", config = function() require('neoscroll').setup() end },

    -------------------- Editing --------------------
    { "tpope/vim-surround", event = "VeryLazy" },
    { "tpope/vim-repeat", event = "VeryLazy" },
    {
        "junegunn/vim-easy-align",
        event = "VeryLazy",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "x" },
            { "ga", "<Plug>(EasyAlign)", mode = "n" },
        },
    },
    { "tpope/vim-fugitive" },
    { "junegunn/gv.vim", lazt = true},
    { "airblade/vim-gitgutter", event = { "BufReadPre", "BufNewFile" } },

    -------------------- LSP & Completion --------------------
    { "VonHeikemen/lsp-zero.nvim", branch = "v4.x", dependencies = {
        { "neovim/nvim-lspconfig" },
        { "williamboman/mason.nvim", build = ":MasonUpdate" },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "f3fora/cmp-spell" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
        { "saadparwaiz1/cmp_luasnip" },
        { "rafamadriz/friendly-snippets" },
        {
            'aznhe21/actions-preview.nvim',
            event = "VeryLazy",
            keys = { {"<C-s>z", function() require("actions-preview").code_actions() end, desc = "Code Actions"} }
        }
    }},

    -------------------- Syntax & Highlighting --------------------
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = { "BufReadPost", "BufNewFile" } },
    { "norcalli/nvim-colorizer.lua", event = "VeryLazy" },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        config = function()
            require('render-markdown').setup({
                checkbox = {
                    enabled = true,
                    bullet = true,
                    unchecked = {
                        icon = '󰄱 ',
                        highlight = 'RenderMarkdownUnchecked',
                    },
                    checked = {
                        icon = '󰱒 ',
                        highlight = 'RenderMarkdownChecked',
                    },
                    custom = {
                        todo   = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
                        reject = { raw = '[!]', rendered = '✗ ',   highlight = 'RenderMarkdownReject' },
                    },
                },
            })
        end,
    },
    { "azabiong/vim-highlighter" },
    -------------------- Telescope --------------------
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        config = function ()
            require('telescope').setup({
                pickers = {
                    find_files = {
                        -- hidden = true,
                        -- no_ignore = true,
                    }
                }
            })
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        cmd = 'Telescope',
        config = function ()
            require("telescope").load_extension "file_browser"
        end,
    },

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
    {
        "lervag/vimtex", ft = { "tex" }, config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_version_check=0
            vim.g.vimtex_compiler_method = "latexmk"
            if sysname == "Windows_NT" then
                vim.g.vimtex_view_method = "general"
                vim.g.vimtex_view_general_viewer = "SumatraPDF"
                vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
            elseif sysname == "Linux" then
                vim.g.vimtex_view_method = "zathura"
            end
        end
    },
    -- { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, cmd = "Trouble" },
    -- { "azabiong/vim-highlighter", event = "VeryLazy" },
    { "folke/which-key.nvim", event = "VeryLazy", opts = { delay = 5000 } },
    { "nvzone/volt", lazy = true },
    { "nvzone/minty", event = "VeryLazy", cmd = { "Shades", "Huefy" } },
    { "nvzone/showkeys", event = "VeryLazy", cmd = "ShowkeysToggle", opts = { timeout = 1, maxkeys = 5  } },
    {
        'derektata/lorem.nvim',
        config = function()
            require("lorem").opts {
                sentence_length = "mixed",
                comma_chance = 0.0,
                max_commas = 2,
                debounce_ms = 200,
            }
        end
    },

    -------------------- Colors --------------------
    { "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },
    { "rakr/vim-one", name = "one", lazy = false, priority = 1000 },
    { "rjshkhr/shadow.nvim", lazy = false, priority = 1000, config = function() vim.opt.termguicolors = true vim.cmd.colorscheme("shadow") end },
    { "ku1ik/vim-monokai", lazy = false, priority = 1000 },
    { "rebelot/kanagawa.nvim", lazy = false, priority = 1000 },
    { "andreasvc/vim-256noir", lazy = false, priority = 1000 },
    { "preservim/vim-colors-pencil", lazy = false, priority = 1000 },
    { "Alligator/accent.vim", lazy = false, priority = 1000 },
    { "hyperb1iss/silkcircuit-nvim", lazy = false, priority = 1000 },

    ----------------- Obsidian ---------------------
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "artempyanykh/marksman",
        },
        opts = function()
            local diary_path
            if sysname == "Windows_NT" then
                diary_path = "E:\\Documenti\\Diario2"
            elseif sysname == "Linux" then
                diary_path = "~/Desktop/diario"
            end

            return {
                legacy_commands = false,
                workspaces = {
                    { name = "diary", path = diary_path },
                },
                preferred_link_style = "wiki",
                daily_notes = {
                    folder = "days",
                    date_format = "%Y-%m-%d",
                },
            }
        end,
    },

    -- COQ --
    {
        "whonore/Coqtail",
        ft = "coq", -- only load for Coq files
        config = function()
            -- optional: Coqtail config
            vim.g.coqtail_noimap = 1     -- disable Coqtail's insert mode mappings
            vim.g.coqtail_nomap = 1      -- disable all default mappings
        end,
    },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "tarPlugin",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

require("mini.sessions").setup()
require("mini.starter").setup()

require("luasnip.loaders.from_vscode").lazy_load()

-- Colorscheme
vim.cmd.colorscheme("silkcircuit")

-- LSP-zero + Mason setup
local lsp_zero = require('lsp-zero')

-- Set up mason
require('mason').setup()

require('mason-lspconfig').setup({
    automatic_installation = false,
    handlers = {
        function(server_name)
            lsp_zero.configure(server_name, {
                on_attach = function(client, bufnr)
                    lsp_zero.default_keymaps({ buffer = bufnr })
                end,
            })
        end,
    },
})


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
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'luasnip', priority = 900 },
                { name = 'spell', priority = 800 },
                { name = 'buffer', priority = 700 },
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
    -- vim.cmd.colorscheme("kanagawa-dragon")
    vim.api.nvim_set_hl(0, "Normal", {bg="none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg="none"})
    vim.api.nvim_set_hl(0, "LineNr", {bg="none"})
    vim.api.nvim_set_hl(0, "StatusLike", {bg="none"})
    vim.api.nvim_set_hl(0, "VertSplit", {bg="none"})
    vim.api.nvim_set_hl(0, "CursorLine", {bg="#373836"})
end

-- ClearBg()

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function(ev)
        vim.api.nvim_buf_create_user_command(ev.buf, "PasteImage", function(opts)
            vim.fn.mkdir("images", "p")

            local function finalize(name)
                if not name or name == "" then
                    return
                end

                local filename = name .. ".png"
                local src = vim.fn.expand("~/Pictures/screenshot.png")
                local dst = "images/" .. filename

                vim.fn.system({ "cp", src, dst })

                local lines = {
                    "\\begin{figure}[h!]",
                    "    \\centering",
                    "    \\includegraphics[width=0.8\\linewidth]{images/" .. filename .. "}",
                    "    \\caption{fig:" .. name .. "}",
                    "\\end{figure}",
                }

                vim.api.nvim_put(lines, "l", true, true)
            end

            if opts.args ~= "" then
                finalize(opts.args)
            else
                vim.ui.input({ prompt = "Image name: " }, finalize)
            end
        end, {
        desc = "Paste an image in a LaTeX file",
        nargs = "?",
    })
end,
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.enable("lua_ls")

require("post")
