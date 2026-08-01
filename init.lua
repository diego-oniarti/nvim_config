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
        config = function()
            require('lualine').setup {
                tabline = {
                    lualine_a = { { 'buffers', show_filename_only = false }, },
                    lualine_z = { 'tabs' }
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
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#F09EA7" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FAFABE" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#C7CAFF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#F6CA94" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#C1EBC0" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CDABEB" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#F6C2F3" })
                vim.api.nvim_set_hl(0, "IblIndent", { fg = "#535353" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup(opts)

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    { "nvim-mini/mini.nvim" },
    --[[
    { "karb94/neoscroll.nvim", event = "VeryLazy", config = function() require('neoscroll').setup() end },
    {
        "sphamba/smear-cursor.nvim",
        opts = {
            smear_between_buffers = true,
            smear_between_neighbor_lines = true,
            scroll_buffer_space = true,
            legacy_computing_symbols_support = true,
            smear_insert_mode = true,
        }
    },
    --]]

    -------------------- Editing --------------------
    { "tpope/vim-surround", event = "VeryLazy" },
    { "tpope/vim-repeat",   event = "VeryLazy" },
    {
        "junegunn/vim-easy-align",
        event = "VeryLazy",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = "x" },
            { "ga", "<Plug>(EasyAlign)", mode = "n" },
        },
    },
    { "tpope/vim-fugitive" },
    { "junegunn/gv.vim",        lazt = true },
    { "airblade/vim-gitgutter", event = { "BufReadPre", "BufNewFile" } },

    -------------------- LSP & Completion --------------------
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim",          build = ":MasonUpdate" },
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
                keys = { { "<C-s>z", function() require("actions-preview").code_actions() end, desc = "Code Actions" } }
            }
        }
    },

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
                        reject = { raw = '[!]', rendered = '✗ ', highlight = 'RenderMarkdownReject' },
                    },
                },
            })
        end,
    },
    -------------------- Telescope --------------------
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        config = function()
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
        config = function()
            require("telescope").load_extension "file_browser"
        end,
    },

    -------------------- Utilities --------------------
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<C-s>a",
                function()
                    require("harpoon").setup(); require("harpoon").list():add()
                end,
                desc = "Harpoon Add"
            },
            { "<C-s>d", function() require("harpoon").ui:toggle_quick_menu(require("harpoon").list()) end, desc = "Harpoon Toggle" },
            { "<C-s>h", function() require("harpoon").list():prev() end,                                   desc = "Harpoon Prev" },
            { "<C-s>l", function() require("harpoon").list():next() end,                                   desc = "Harpoon Next" },
        }
    },
    {
        "lervag/vimtex",
        ft = { "tex" },
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_version_check = 0
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
    { "azabiong/vim-highlighter", event = "VeryLazy" },
    { "folke/which-key.nvim",    event = "VeryLazy", opts = { delay = 5000 } },
    { "nvzone/volt",             lazy = true },
    { "nvzone/minty",            event = "VeryLazy", cmd = { "Shades", "Huefy" } },
    { "nvzone/showkeys",         event = "VeryLazy", cmd = "ShowkeysToggle",     opts = { timeout = 1, maxkeys = 5 } },
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
    { "rakr/vim-one",     name = "one",       lazy = false, priority = 1000 },
    { "rjshkhr/shadow.nvim",         lazy = false, priority = 1000 },
    { "ku1ik/vim-monokai",           lazy = false, priority = 1000 },
    { "rebelot/kanagawa.nvim",       lazy = false, priority = 1000 },
    { "andreasvc/vim-256noir",       lazy = false, priority = 1000 },
    { "preservim/vim-colors-pencil", lazy = false, priority = 1000 },
    { "Alligator/accent.vim",        lazy = false, priority = 1000 },
    { "kepano/flexoki-neovim",       lazy = false, priority = 1000 },
    {
        'maxmx03/fluoromachine.nvim',
        lazy = false,
        priority = 1000,
        config = function ()
            local fm = require 'fluoromachine'

            fm.setup {
                glow = true,
                theme = 'delta',
                transparent = false,
            }
        end
    },
    {
        "zenbones-theme/zenbones.nvim",
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
        -- you can set set configuration options here
        -- config = function()
            --     vim.g.zenbones_darken_comments = 45
            --     vim.cmd.colorscheme('zenbones')
            -- end
        },

    -- COQ --
    {
        "whonore/Coqtail",
        ft = "coq", -- only load for Coq files
        config = function()
            -- optional: Coqtail config
            vim.g.coqtail_noimap = 1 -- disable Coqtail's insert mode mappings
            vim.g.coqtail_nomap = 1  -- disable all default mappings
        end,
    },

    -- Bullshit --
    { "alanfortlink/blackjack.nvim", event = "VeryLazy" },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "tarPlugin",
                -- "tutor",
                "zipPlugin",
            },
        },
    },
})

require("mini.sessions").setup()
local starter = require('mini.starter')
starter.setup( {
    autoopen = true,
    evaluate_single = false,
    header = "",
    items = {
        starter.sections.sessions(nil, true),
        starter.sections.builtin_actions(),
    },
    footer = "",
})

require("luasnip.loaders.from_vscode").lazy_load()

-- Colorscheme
vim.cmd.colorscheme("rose-pine")

-- LSP-zero + Mason setup
local lsp_zero = require('lsp-zero')

-- 1. Setup Mason
require('mason').setup()

-- 2. Configure Mason-LSPConfig
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            -- Let Mason handle everything EXCEPT Coq
            if server_name ~= "coq_lsp" then
                require('lspconfig')[server_name].setup({})
            end
        end,
    },
})

-- Coq LSP setup (modern Neovim 0.11+ style)
-- - Uses opam exec to find coq-lsp in the switch
-- - Root markers: _CoqProject or .git
vim.lsp.config('coq_lsp', {
    cmd = { 'opam', 'exec', '--', 'coq-lsp' },
    root_markers = { "_CoqProject", ".git" },
    on_attach = function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
    end,
})
vim.lsp.enable('coq_lsp')
vim.g.coqtail_build_system = 'coqproject'

-- Haskell LSP Setup (modern Neovim 0.11+ style)
vim.lsp.config('hls', {
    cmd = { 'haskell-language-server-wrapper', '--lsp' },
    root_markers = { '*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', '.git' },
    on_attach = function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
    end,
    settings = {
        haskell = {
            -- Prevents HLS from choking when there's no cabal/stack file
            checkProject = false 
        }
    }
})
vim.lsp.enable('hls')

-- CMP + LuaSnip setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = false }),
        -- ['<CR>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then luasnip.jump(-1) else fallback() end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp', priority = 1000 },
        { name = 'luasnip',  priority = 900 },
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
                { name = 'luasnip',  priority = 900 },
                { name = 'spell',    priority = 800 },
                { name = 'buffer',   priority = 700 },
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
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function ClearBg()
    -- vim.cmd.colorscheme("kanagawa-dragon")
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLike", { bg = "none" })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#373836" })
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

local box_buf_nr = -1

vim.api.nvim_create_user_command('Box', function()
    -- Check if the buffer exists and is valid
    if vim.api.nvim_buf_is_valid(box_buf_nr) then
        vim.api.nvim_set_current_buf(box_buf_nr)
    else
        -- Create a new unlisted scratch buffer
        box_buf_nr = vim.api.nvim_create_buf(false, true)

        -- Define the content
        local lines = {
            "═", "║", "",
            "╔╦╗", "╠╬╣", "╚╩╝", "",
            "╒╤╕", "╞╪╡", "╘╧╛", "",
            "╓╥╖", "╟╫╢", "╙╨╜"
        }

        -- Set lines in the new buffer
        vim.api.nvim_buf_set_lines(box_buf_nr, 0, -1, false, lines)

        -- Set buffer options: readonly and nomodifiable to protect the text
        vim.api.nvim_buf_set_option(box_buf_nr, 'buftype', 'nofile')
        vim.api.nvim_buf_set_option(box_buf_nr, 'readonly', true)
        vim.api.nvim_buf_set_option(box_buf_nr, 'modifiable', false)

        -- Open the newly created buffer in the current window
        vim.api.nvim_set_current_buf(box_buf_nr)
    end
end, {})


vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        io.stdout:write("\027[>1u")
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        io.stdout:write("\027[<1u")
    end,
})

vim.filetype.add({ extension = { cg = "cg", }, })
vim.filetype.add({ extension = { coq = "v", }, })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "v",
    callback = function()
        vim.cmd.colorscheme("rose-pine-dawn")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.opt.formatprg="clang-format"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cg",
    callback = function()
        vim.opt.formatprg   = "cg-format"
        vim.opt.textwidth   = 210
        vim.opt.colorcolumn = "210"
        vim.opt.spell       = true
        vim.opt.spelllang   = { 'en' }
        vim.opt.wrap        = true
        vim.opt.linebreak   = true
    end,
})

require("post")
