return {
    {
        'echasnovski/mini.ai',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        version = false,
        opts = function ()
            local gen_spec = require('mini.ai').gen_spec
            return {
                mappings = {
                    -- Main textobject prefixes
                    around = 'a',
                    inside = 'i',

                    -- Next/last variants
                    around_next = 'an',
                    inside_next = 'in',
                    around_last = 'al',
                    inside_last = 'il',

                    -- Move cursor to corresponding edge of `a` textobject
                    goto_left = 'g[',
                    goto_right = 'g]',
                },
                custom_textobjects = {
                    -- TODO: Fix
                    -- Function definition (needs treesitter queries with these captures)
                    -- F = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
                }
            }
        end,
    },
    {
        'echasnovski/mini.pairs',
        event = { 'InsertEnter', 'CmdlineEnter' },
        version = false,
        opts = {
            mappings = {
                [' '] = { action = 'open', pair = '  ', neigh_pattern = '[%(%[{][%)%]}]' },
                ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\`].', register = { cr = false } },
            },
        },
    },

    {
        'HiPhish/rainbow-delimiters.nvim',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
    }

}
