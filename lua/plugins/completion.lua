return {
    {
        'saghen/blink.cmp',
        version = '*',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'rafamadriz/friendly-snippets',
            'saghen/blink.compat',
            "xzbdmw/colorful-menu.nvim",
            "L3MON4D3/LuaSnip",
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = function ()
            local border = require('defaults').border

            vim.opt.pumheight = 32

            return {
                -- 'default' for mappings similar to built-in completion
                -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                -- See the full "keymap" documentation for information on defining your own keymap.
                keymap = {
                    preset = 'enter',
                    ["<C-y>"] = { "select_and_accept" },

                },
                appearance = {
                    nerd_font_variant = 'mono',
                },
                sources = {
                    default = function(ctx)
                        local success, node = pcall(vim.treesitter.get_node)

                        if vim.bo.filetype == 'lua' then
                            return { 'lsp', 'path' }
                        elseif vim.bo.filetype == 'markdown' then
                            return { 'lsp', 'snippets', 'buffer' }
                        elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                            return { 'buffer' } -- Comments
                        else
                            return { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' }
                        end
                    end,
                    providers = {
                        buffer = {
                            opts = {
                                get_bufnrs = function()
                                    return vim.tbl_filter(function(bufnr)
                                        return vim.bo[bufnr].buftype == ''
                                    end, vim.api.nvim_list_bufs())
                                end
                            },
                            -- keep case of first char
                            transform_items = function (a, items)
                                local keyword = a.get_keyword()
                                local correct, case
                                if keyword:match('^%l') then

                                    correct = '^%u%l+$'
                                    case = string.lower
                                elseif keyword:match('^%u') then
                                    correct = '^%l+$'
                                    case = string.upper
                                else
                                    return items
                                end

                                -- avoid duplicates from the corrections
                                local seen = {}
                                local out = {}
                                for _, item in ipairs(items) do
                                    local raw = item.insertText
                                    if raw:match(correct) then
                                        local text = case(raw:sub(1,1)) .. raw:sub(2)
                                        item.insertText = text
                                        item.label = text
                                    end
                                    if not seen[item.insertText] then
                                        seen[item.insertText] = true
                                        table.insert(out, item)
                                    end
                                end
                                return out
                            end
                        },
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            -- make lazydev completions top priority (see `:h blink.cmp`)
                            score_offset = 100,
                        },
                        lsp = {
                            override = {
                                get_trigger_character = function(self)
                                    local trigger_characters = self:get_trigger_characters()
                                    vim.list_extend(trigger_characters, { '\n', '\t', ' ' })
                                    return trigger_characters
                                end
                            },
                        },
                        snippets = {
                            should_show_items = function (ctx)
                                return ctx.trigger.initial_kind ~= 'trigger_character'
                            end
                        },
                    },
                },
                completion = {
                    list = {
                        selection = {
                            preselect = function(ctx) return ctx.mode ~= 'cmdline' end,
                            auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end
                        }
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 0,
                        window = { border = border }
                    },
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
                                    ellipsis = false,
                                    text = function(ctx)
                                        local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                        return kind_icon..' '
                                    end,
                                    -- Optionally, you may also use the highlights from mini.icons
                                    highlight = function(ctx)
                                        local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                        return hl
                                    end,
                                }
                            },
                            treesitter = { 'lsp' },
                        }
                    },
                },
                snippets = {
                    preset = 'luasnip',
                    -- -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
                    -- expand = function(snippet)
                    --     require("luasnip").lsp_expand(snippet)
                    -- end,
                    -- active = function(filter)
                    --     if filter and filter.direction then
                    --         return require("luasnip").jumpable(filter.direction)
                    --     end
                    --     return require("luasnip").in_snippet()
                    -- end,
                    -- jump = function(direction)
                    --     require("luasnip").jump(direction)
                    -- end,
                },
                signature = {
                    enabled = true,
                    window = { border = border}
                },
            }
        end,
    },
    {
        "xzbdmw/colorful-menu.nvim",
        ft = require('supporter').get('plugins', 'colorful-menu'),
        event = { 'InsertEnter', 'CmdlineEnter' },
        config = function()
            -- You don't need to set these options.
            require("colorful-menu").setup({
                ls = {
                    lua_ls = {
                        -- Maybe you want to dim arguments a bit.
                        arguments_hl = "@comment",
                    },
                    gopls = {
                        -- By default, we render variable/function's type in the right most side,
                        -- to make them not to crowd together with the original label.

                        -- when true:
                        -- foo             *Foo
                        -- ast         "go/ast"

                        -- when false:
                        -- foo *Foo
                        -- ast "go/ast"
                        align_type_to_right = true,
                        -- When true, label for field and variable will format like "foo: Foo"
                        -- instead of go's original syntax "foo Foo".
                        add_colon_before_type = false,
                    },
                    -- for lsp_config or typescript-tools
                    ts_ls = {
                        extra_info_hl = "@comment",
                    },
                    vtsls = {
                        extra_info_hl = "@comment",
                    },
                    ["rust-analyzer"] = {
                        -- Such as (as Iterator), (use std::io).
                        extra_info_hl = "@comment",
                        -- Similar to the same setting of gopls.
                        align_type_to_right = true,
                    },
                    clangd = {
                        -- Such as "From <stdio.h>".
                        extra_info_hl = "@comment",
                    },
                    roslyn = {
                        extra_info_hl = "@comment",
                    },
                    -- The same applies to pyright/pylance
                    basedpyright = {
                        -- It is usually import path such as "os"
                        extra_info_hl = "@comment",
                    },

                    -- If true, try to highlight "not supported" languages.
                    fallback = true,
                },
                -- If the built-in logic fails to find a suitable highlight group,
                -- this highlight is applied to the label.
                fallback_highlight = "@variable",
                -- If provided, the plugin truncates the final displayed text to
                -- this width (measured in display cells). Any highlights that extend
                -- beyond the truncation point are ignored. When set to a float
                -- between 0 and 1, it'll be treated as percentage of the width of
                -- the window: math.floor(max_width * vim.api.nvim_win_get_width(0))
                -- Default 60.
                max_width = 60,
            })
        end,
    },

    {
        'saghen/blink.compat',
        version = '*',
        lazy = true,
        opts = {},
    },
    {

        "L3MON4D3/LuaSnip",
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        event = { 'InsertEnter', 'CmdlineEnter' },
        build = "make install_jsregexp",
        config = function ()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,

    },
}
