return {
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = {
            'echasnovski/mini.icons',
            'rafamadriz/friendly-snippets'
        },
        event = { 'InsertEnter', 'CmdlineEnter' },

        -- use a release tag to download pre-built binaries
        --version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'enter' },
            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'normal'
            },


            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = false },
                menu = {
                    border = 'none',
                    draw = {
                        columns = { { "kind_icon" }, { "label", gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                            kind_icon = {
                                text = function(ctx)
                                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                    return kind_icon..' '
                                end,
                                -- (optional) use highlights from mini.icons
                                highlight = function(ctx)
                                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                    return hl
                                end,
                            },
                            kind = {
                                -- (optional) use highlights from mini.icons
                                highlight = function(ctx)
                                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                    return hl
                                end,
                            }
                        }
                    }
                }
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = function(ctx)
                    local success, node = pcall(vim.treesitter.get_node)
                    if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                        return { 'lsp', 'path', 'snippets', 'buffer' }
                    -- elseif vim.bo.filetype == 'lua' then
                    --     return { 'lsp', 'path' }
                    else
                        return { 'lsp', 'path', 'snippets', 'buffer' }
                    end
                end,
                providers = {
                    buffer = {
                        opts = {
                            get_bufnrs = function()
                                return vim.tbl_filter(function(bufnr)
                                    -- TODO: extend filter
                                    return vim.bo[bufnr].buftype == ''
                                end, vim.api.nvim_list_bufs())
                            end
                        }
                    }
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = {
                enabled = true,
                window = { border = require('defaults').border },
            },
        },
        --opts_extend = { "sources.default" }
    },
    {
        'xzbdmw/colorful-menu.nvim',
        config = true,
        event = { 'InsertEnter', 'CmdlineEnter' },

    },
}
