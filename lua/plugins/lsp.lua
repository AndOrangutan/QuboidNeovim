local lsp_ft = require('util.supporter'):categories({'lsp'}):elements({ 'ft' }):crush()
local ex = require('util.excludinator')

return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'echasnovski/mini.icons',
        },
        ft = lsp_ft,
        --event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        config = function()
            local lspconfig = require("lspconfig")

            local icons = require('util.icons')
            local lsp = require('util.lsp')
            local defaults = require("defaults")

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
                kinds[i] = _G.MiniIcons.get('lsp', kind) or kind
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

            local support_tbl = require('util.supporter'):categories({'lsp'}):elements({'alt'}):out()
            for server_name, server_elements in pairs(support_tbl['lsp']) do
                local has_lsp_config, lsp_config = pcall(require, "lsp."..server_name)

                if has_lsp_config then
                    lsp_config()
                else
                    vim.lsp.config(server_elements['alt'],{
                        capabilities = lsp.gen_capabilities(),
                    })
                end
                vim.lsp.enable(server_elements['alt'])
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
        priority = 1000,
        event = { 'LspAttach' },
        ft = lsp_ft,
        opts = {
            preset = "simple",
            disabled_ft = ex:sel('tiny-inline-diagnostic', 'ft'):out(),
            options = {
                use_icons_from_diagnostic = true,
                set_arrow_to_diag_color = false,
                multilines = {
                    -- Enable multiline diagnostic messages
                    enabled = true,

                    -- Always show messages on all lines for multiline diagnostics
                    always_show = false,
                },
            },
        },
    }
}
