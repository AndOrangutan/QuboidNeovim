return function ()
    local lsp = require('util.lsp')
    require('lspconfig').clangd.setup({
        cmd = {
            "clangd",
            "--fallback-style=google",
            "--offset-encoding=utf-16",
            "--compile-commands-dir=build",
        },
        capabilities = lsp.gen_capabilities(),
    })
end
