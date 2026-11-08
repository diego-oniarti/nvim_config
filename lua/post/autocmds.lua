vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argc() == 0 and vim.fn.filereadable("Session.vim") == 1 then
            vim.cmd("source Session.vim")
            vim.cmd("filetype detect")
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    local ft = vim.bo[buf].filetype
                    if ft ~= "" then
                        vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
                    end
                end
            end
        end
    end,
})

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

vim.api.nvim_create_autocmd("FileType", {
    pattern = "coq",
    callback = function()
        -- vim.cmd.colorscheme("rose-pine-dawn")
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.bo.formatprg="clang-format"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.bo.formatprg = "black -"
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        -- vim.cmd.colorscheme("rose-pine-dawn")
        -- vim.opt.background = "light"
        vim.opt.concealcursor = "n"
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

