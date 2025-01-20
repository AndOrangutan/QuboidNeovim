return {
    {
        'jinh0/eyeliner.nvim',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        opts = {
            highlight_on_key = true,
        },
    },
    {
        'RRethy/vim-illuminate',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        config = function ()
            require('illuminate').configure({
                filetypes_denylist = require('defaults').ft_exclude
            })
        end,

    },
}
