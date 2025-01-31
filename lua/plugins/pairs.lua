return {
    {
        'echasnovski/mini.pairs',
        event = { 'InsertEnter', 'CmdlineEnter' },
        version = false,
        opts = {
            mappings = {
                [' '] = { action = 'open', pair = '  ', neigh_pattern = '[%(%[{][%)%]}]' },
            },
        },
    },

    {
        'HiPhish/rainbow-delimiters.nvim',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
    }

}
