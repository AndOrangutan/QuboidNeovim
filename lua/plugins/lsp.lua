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

            lsp.setup_on_attach()

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
                    thing = "test",
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            for lspconfig_name, tbl in pairs(require('supporter').get('lsp')) do
                local has_lsp_config, lsp_config = pcall(require, "lsp."..lspconfig_name)

                if has_lsp_config then
                    lsp_config()
                else
                    lspconfig[tbl.alt].setup({
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
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        priority = 1000,
        config = function()
            local ex = require('util.excludeinator')
            require('tiny-inline-diagnostic').setup({
                preset = "simple",
                disabled_ft = ex:cur('smart-split'):out(),
                -- options = {
                --     multilines = {
                --         -- Enable multiline diagnostic messages
                --         enabled = true,
                --
                --         -- Always show messages on all lines for multiline diagnostics
                --         always_show = false,
                --     },
                -- },
            })
        end
    },
}
