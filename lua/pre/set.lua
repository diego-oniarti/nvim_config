vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "85"
-- vim.opt.textwidth = 85

vim.g.mapleader = " "

vim.opt.foldcolumn = "1"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
vim.opt.foldnestmax = 4
vim.opt.foldtext = ""
vim.opt.foldminlines = 4

vim.opt.guicursor = 'i:ver50'
vim.opt.cursorline = true

vim.opt.conceallevel = 0
vim.o.exrc = true

vim.opt.list = true
vim.opt.listchars = {
    trail = "·",
    tab   = "│-",
    nbsp  = "+",
}

vim.opt.spell = true
vim.opt.spelllang = { 'en', 'it' }
