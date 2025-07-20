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
        'isakbm/gitgraph.nvim',
        opts = {
            symbols = {
                merge_commit = 'M',
                commit = '*',
            },
            format = {
                timestamp = '%H:%M:%S %d-%m-%Y',
                fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
            },
            hooks = {
                -- Check diff of a commit
                on_select_commit = function(commit)
                    vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
                    vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
                end,
                -- Check diff from commit a -> commit b
                on_select_range_commit = function(from, to)
                    vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
                    vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
                end,
            },
        },
        keys = {
            {
                "<leader>gl",
                function()
                    require('gitgraph').draw({}, { all = true, max_count = 5000 })
                end,
                desc = "[g]it [l]ines (gitgraph)",
            },
        },
    },
    
    {
        'lewis6991/gitsigns.nvim',
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        opts = function ()
            icons = require('util.icons')
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
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'ibhagwan/fzf-lua',
        },
        lazy = true,
        opts = {
            integrations = {
                diffview = true,
                fzf_lua = true,
            },
            graph_style = 'unicode',
        },
        keys = {
            { '<leader>gg', '<cmd>Neogit<cr>', desc = '[g]it [g]ui (neogit)'},
        },
    },
}
