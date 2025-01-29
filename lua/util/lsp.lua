local _M = {}

_M.gen_capabilities = function(opts)
	local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

    -- local capabilitites = vim.tbl_deep_extend("force",
    --     {},
    --     vim.lsp.protocol.make_client_capabilities(),
    --     has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    --     opts or {})

    return vim.lsp.protocol.make_client_capabilities()
end

_M.setup_on_attach = function()
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP Goto [D]eclaration" })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP Goto [d]efinition"} )
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP [k]ick Hover" })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "LSP Goto [i]mplementation" })
            -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "LSP signature" })
            -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf})
            -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf})
            -- vim.keymap.set('n', '<space>wl', function()
            --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            -- end, { buffer = ev.buf})
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "LSP Goto [t]ype Def" })
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP [r]e[n]ame" })
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP [r]e[n]ame" })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP Goto [r]eferences" })
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
            end, { buffer = ev.buf, desc = "LSP [f]ormat" })
        end,
    })
end

return _M
