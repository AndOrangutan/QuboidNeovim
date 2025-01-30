
local deus_vault = vim.fn.expand('~')..'/Dropbox/obsidian/compendium'
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
        -- 'epwalsh/obsidian.nvim',
        branch = 'blink-support',
        version = '*',  -- recommended, use latest release instead of latest commit
        lazy = true,
        --ft = 'markdown',
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        event = {
          -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
          -- E.g. 'BufReadPre ' .. vim.fn.expand '~' .. '/my-vault/*.md'
          -- refer to `:h file-pattern` for more examples
          'BufReadPre '..deus_vault..'/*.md',
          'BufNewFile '..deus_vault..'/*.md',
        },
        dependencies = {
            -- Required.
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
            'ibhagwan/fzf-lua',

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            workspaces = {
                {
                    name = 'personal',
                    path = deus_vault,
                },
                -- {
                --     name = 'work',
                --     path = '~/vaults/work',
                -- },
            },
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
                -- A map for custom variables, the key should be the variable and the value a function
                substitutions = {},
            },
            completion = {
                nvim_cmp = false,
                blink = true,
                min_chars = 2,
            },
            picker = {
                -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
                name = "fzf-lua",
            },
            attachments = {
                -- The default folder to place images in via `:ObsidianPasteImg`.
                -- If this is a relative path it will be interpreted as relative to the vault root.
                -- You can always override this per image by passing a full path to the command instead of just a filename.
                img_folder = "assets/imgs",  -- This is the default

                -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
                ---@return string
                img_name_func = function()
                    -- Prefix image names with timestamp.
                    return string.format("%s-", os.time())
                end,

                -- A function that determines the text to insert in the note when pasting an image.
                -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
                -- This is the default implementation.
                ---@param client obsidian.Client
                ---@param path obsidian.Path the absolute path to the image file
                ---@return string
                img_text_func = function(client, path)
                    path = client:vault_relative_path(path) or path
                    return string.format("![%s](%s)", path.name, path)
                end,
            },
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
