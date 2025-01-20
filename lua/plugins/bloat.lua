return {
    {
        'echasnovski/mini.animate',
        version = false,
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        opts = function()
            animate = require("mini.animate")
            return {
                cursor = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
                },
                scroll = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
                },
                resize = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
                },
                open = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
                },
                close = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
                },
            }
        end,
        keys = {
            -- { '<C-d>', [[<Cmd>lua vim.cmd('normal! <C-d>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]], desc = 'Scroll [d]own' },
            -- { '<C-u>', [[<Cmd>lua vim.cmd('normal! <C-u>'); MiniAnimate.execute_after('scroll', 'normal! zvzz')<CR>]], desc = 'Scroll [u]p', },
        },
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        opts = function ()
            local icons = require('util.icons')
            local ex = require('util.excludeinator')

            vim.api.nvim_create_autocmd('FileType', {
            pattern = ex:cur('indentscope'):add({'markdown'}):out(),
            callback = function()
               vim.b.miniindentscope_disable = true
            end,
            })

            return {
                symbol = icons.bar_thick_split,
                options = {
                    try_as_border = true,
                },
            }
        end,
    },
    {
        'echasnovski/mini.map',
        version = '*',
        opts = function ()
            local icons = require('util.icons')
            local map = require('mini.map')

            vim.api.nvim_create_user_command('MiniMapOpen', function()
                require('mini.map').open()
            end, {})
            vim.api.nvim_create_user_command('MiniMapClose', function()
                require('mini.map').close()
            end, {})
            vim.api.nvim_create_user_command('MiniMapToggle', function()
                require('mini.map').toggle()
            end, {})
            vim.api.nvim_create_user_command('MiniMapFocus', function()
                require('mini.map').toggle_focus()
            end, {})
            vim.api.nvim_create_user_command('MiniMapSwitch', function()
                require('mini.map').toggle_side()
            end, {})
            vim.api.nvim_create_user_command('MiniMapRefresh', function()
                require('mini.map').refresh({}, { lines = false, scrollbar = false })
            end, {})


            return {
                symbols = {
                    scroll_ldine = icons.ui.bar_cursor,
                    scroll_view = icons.ui.bar_thick,
                },
                window = {
                    show_integration_count = true,
                },
                integrations = {
                    map.gen_integration.builtin_search({
                        search = 'ReverseSearch',
                    }),
                    map.gen_integration.diagnostic(),
                    map.gen_integration.gitsigns(),
                },
            }
        end,
        keys = {
            { '<leader>mm', '<cmd>MiniMapToggle<cr>',        desc = '[m]ini [m]ap' },
            { '<leader>mf', '<cmd>MiniMapFocus<cr>',         desc = 'Mini [m]ap Switch [f]ocus' },
            { '<leader>ms', '<cmd>MiniMapSwitch<cr>',        desc = 'Mini [m]ap Switch [s]ides' },
            { 'n',          'n' .. '<cmd>MiniMapRefresh<cr>' },
            { 'N',          'N' .. '<cmd>MiniMapRefresh<cr>' },
            { '*',          '*' .. '<cmd>MiniMapRefresh<cr>' },
            { '#',          '#' .. '<cmd>MiniMapRefresh<cr>' },
        },
    },
}
