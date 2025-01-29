return {
    {
        'saghen/blink.cmp',
        version = '*',
        event = { 'InsertEnter', 'CmdlineEnter' },
        dependencies = {
            'rafamadriz/friendly-snippets',
            "L3MON4D3/LuaSnip",
        },
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = function ()
            local border = require('defaults').border
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
                        elseif success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
                            return { 'buffer' }
                        else
                            return { 'lsp', 'path', 'snippets', 'buffer' }
                        end
                    end,
                    providers = {
                        buffer = {
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
                        snippets = {
                            should_show_items = function (ctx)
                                return ctx.trigger.initial_kind ~= 'trigger_character'
                            end
                        },
                    },
                },
                completion = {
                    list = { selection = { preselect = false, auto_insert = true } },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 0,
                        window = { border = border }
                    },
                    menu = {
                        border = 'none',
                        draw = {
                            components = {
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
