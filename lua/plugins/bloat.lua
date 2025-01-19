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
}
