
local deus_vault = vim.fn.expand('~')..'/Sync/Notes/compendium'
local ft = require('supporter').get('ft', 'markup')

return {
    {
        'AckslD/nvim-FeMaco.lua',
        opts = {
            border = require('defaults').border,
            prepare_buffer = function(opts)
                vim.cmd('split')
                local win = vim.api.nvim_get_current_win()
                local buf = vim.api.nvim_create_buf(false, false)
                return vim.api.nvim_win_set_buf(win, buf)
            end,
            post_open_float = function(winnr)
                -- vim.wo.signcolumn = 'no'
                vim.wo.winhighlight = 'Nomral:NormalFloat'
            end
        },
        ft = ft,
        keys = {
            { '<leader>o', '<cmd>FeMaco<cr>', ft = ft, desc = 'FeMaco [o]pen Codeblock' }
        },
    },
    {
        'adamtajti/obsidian.nvim',
        version = '*',  -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = 'markdown',
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. 'BufReadPre ' .. vim.fn.expand '~' .. '/my-vault/*.md'
        --   -- refer to `:h file-pattern` for more examples
        --   'BufReadPre '..deus_vault..'/*.md',
        --   'BufNewFile '..deus_vault..'/*.md',
        -- },
        dependencies = {
            -- Required.
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'ibhagwan/fzf-lua',
            'saghen/blink.cmp',

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            workspaces = {
                -- TODO: Extract out
                {
                    name = 'personal',
                    path = deus_vault,
                },
            },
            picker = {
                name = 'fzf-lua'
            },
            completion = {
                -- Enables completion using nvim_cmp
                nvim_cmp = true,
                -- Enables completion using blink.cmp
                blink = true,
                -- Trigger completion at 2 chars.
                min_chars = 2,
                -- Set to false to disable new note creation in the picker
                create_new = true,
            },
            note_id_func = function (title) return title end,
        },
        keys = {
            { '<leader>nn', '<cmd>ObsidianNewFromTemplate<cr>', ft = ft, desc = '[n]otebook [n]ew From Template (obsidian)' },
            { '<leader>ni', '<cmd>ObsidianPasteImg<cr>', ft = ft, desc = '[n]otebook Paste [i]mg (obsidian)' },
            { '<leader>no', '<cmd>ObsidianOpen<cr>', ft = ft, desc = '[n]otebook [o]pen (obsidian)' },
            { '<leader>nb', '<cmd>ObsidianBacklinks<cr>', ft = ft, desc = '[n]otebook pick [b]acklinks (obsidian)' },
            { '<leader>nt', '<cmd>ObsidianTags<cr>', ft = ft, desc = '[n]otebook pick [t]ags (obsidian)' },
            { '<leader>nf', '<cmd>ObsidianSearch<cr>', ft = ft, desc = '[n]otebook pick Search (obsidian)' },
        },
    }
}
