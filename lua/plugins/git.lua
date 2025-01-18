return {
    {
        'sindrets/diffview.nvim',
        lazy = true,
        cmd = {
            'DiffviewOpen',
            'DiffviewClose',
            'DiffviewToggleFiles',
            'DiffviewFocusFiles',
            'DiffviewRefresh',
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        opts = function ()
            icons = require("util.icons")
            return {
                signs = {
                    add          = { text = icons.ui.bar_thick },
                    change       = { text = icons.ui.bar_thick },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = icons.ui.bar_thick_split },
                },
                signs_staged = {
                    add          = { text = icons.ui.bar_thick },
                    change       = { text = icons.ui.bar_thick },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = icons.ui.bar_thick_split },
                },
            }
        end,
    },
}
