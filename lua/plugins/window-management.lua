return {
    {
        'mrjones2014/smart-splits.nvim',
        dependencies = {
            { 'kwkarlwang/bufresize.nvim', config = true },
        },
        opts = function()
            local ex = require('util.excludeinator')
            return {
                resize_mode = {
                    hooks = {
                        on_leave = require('bufresize').register,
                    },
                },
                ignore_filetypes = ex:cur('smart-split'):out()
            }
        end,
        keys = {
            { '<C-A-h>', '<cmd>lua require("smart-splits").resize_left()<cr>',       desc = 'Resize Left (smart-split)' },
            { '<C-A-j>', '<cmd>lua require("smart-splits").resize_down()<cr>',       desc = 'Resize Down (smart-split)' },
            { '<C-A-k>', '<cmd>lua require("smart-splits").resize_up()<cr>',         desc = 'Resize Up (smart-split)' },
            { '<C-A-l>', '<cmd>lua require("smart-splits").resize_right()<cr>',      desc = 'Resize Right (smart-split)' },
            -- moving between splits
            { '<A-h>',   '<cmd>lua require("smart-splits").move_cursor_left()<cr>',  desc = 'Move Left (smart-split)' },
            { '<A-j>',   '<cmd>lua require("smart-splits").move_cursor_down()<cr>',  desc = 'Move Down (smart-split)' },
            { '<A-k>',   '<cmd>lua require("smart-splits").move_cursor_up()<cr>',    desc = 'Move Up (smart-split)' },
            { '<A-l>',   '<cmd>lua require("smart-splits").move_cursor_right()<cr>', desc = 'Move Right (smart-split)' },
            -- swapping buffers between windows
            { '<A-H>',   '<cmd>lua require("smart-splits").swap_buf_left()<cr>',     desc = 'Swap Left (smart-split)' },
            { '<A-J>',   '<cmd>lua require("smart-splits").swap_buf_down()<cr>',     desc = 'Swap Down (smart-split)' },
            { '<A-K>',   '<cmd>lua require("smart-splits").swap_buf_up()<cr>',       desc = 'Swap Up (smart-split)' },
            { '<A-L>',   '<cmd>lua require("smart-splits").swap_buf_right()<cr>',    desc = 'Swap Right (smart-split)' },
        },
    }
}
