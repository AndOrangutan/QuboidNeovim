return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'echasnovski/mini.icons',
        },
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        config = function()
            local icons = require('util.icons')
            local lsp = require('util.lsp')
            local defaults = require("defaults")
            local lspconfig = require("lspconfig")

            -- Override border
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or defaults.border
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            -- Set up kind icons
            local kinds = vim.lsp.protocol.CompletionItemKind
            for i, kind in ipairs(kinds) do
                kinds[i] = MiniIcons.get('lsp', kind) or kind
            end

            -- Setup diagnostic icons
            for type, icon in pairs(icons.lsp_diag) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({
                -- prefix = '■', -- Could be '●', '▎', 'x'
                virtual_text = false,
                float = {
                    source = "always",
                },
                signs = true,
                underline = true,
                update_in_insert = true,
                severity_sort = true,
            })

            for lspconfig_name, lsp_name in pairs(defaults.lspconfig_to_lsp_name) do
                local has_lsp_config, lsp_config = pcall(require, "lsp."..lspconfig_name)

                if has_lsp_config then
                    lsp_config()
                else
                    lspconfig[lsp_name].setup({
                        capabilities = lsp.gen_capabilities(),
                    })
                end
            end

        end,
        keys = {
            {"<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", desc = "LSP [e]pand Diagnostics"},
            {"[d", "<cmd>lua vim.diagnostic.goto_prev({float = true})<cr>", desc = "Goto Prev [d]iagnostic (lsp)"},
            {"[d", "<cmd>lua vim.diagnostic.goto_next({float = true})<cr>", desc = "Goto prev [d]iagnostic (lsp)"},
        },
    },
}
