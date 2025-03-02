require('lspconfig').clangd.setup({
    cmd = {
        "clangd",
        "--query-driver=/usr/bin/g++",  -- Critical for system includes
        "--background-index",
        "--clang-tidy",
    }
})
