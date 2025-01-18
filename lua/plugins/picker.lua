return {
    {
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            hls               = {
                normal = 'NormalFloat',
                border = 'NormalFloat',
                title = 'NormalFloat',
                previewBorder = 'Normal',
                previewNormal = 'Normal',
                cursor = 'Normal',
                cursorLine = 'Normal',
            },
            winopts = {
                border = require('defaults').border,
                preview = {
                    border = require('defaults').border,
                },
            }
        },
        cmd = {
            'FzfLua'
        },
        keys = {
            {'<leader>pf', '<cmd>lua require("fzf-lua").files()<cr>', desc = '[p]icker [f]iles (fzf-lua)' },
            {'<leader>pg', '<cmd>lua require("fzf-lua").live_grep()<cr>', desc = '[p]icker [g]rep (fzf-lua)' },
            {'<leader>ph', '<cmd>lua require("fzf-lua").helptags()<cr>', desc = '[p]icker [h]elp (fzf-lua)' },
            {'<leader>pa', '<cmd>lua require("fzf-lua").builtin()<cr>', desc = '[p]icker All (fzf-lua)' },
        },
    },
}
