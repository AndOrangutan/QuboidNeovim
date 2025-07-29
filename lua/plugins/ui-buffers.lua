return {
    {
        'stevearc/oil.nvim',
        dependencies = {
            "echasnovski/mini.icons",
        },
        lazy = false,
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = function ()
            local border = require("defaults").border

            -- Declare a global function to retrieve the current directory
            function _G.get_oil_winbar()
                local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
                local dir = require("oil").get_current_dir(bufnr)
                if dir then
                    return vim.fn.fnamemodify(dir, ":~")
                else
                    -- If there is no current directory (e.g. over ssh), just show the buffer name
                    return vim.api.nvim_buf_get_name(0)
                end
            end

            return {
                win_options = {
                    winbar = "%!v:lua.get_oil_winbar()",
                    -- signcolumn = "yes:2",
                },
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                columns = {
                    "icon",
                    -- "permissions", "size", "mtime",
                },
                keymaps = {
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["<CR>"] = "actions.select",
                    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                    ["<C-t>"] = { "actions.select", opts = { tab = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = { "actions.close", mode = "n" },
                    ["<C-l>"] = "actions.refresh",
                    ["-"] = { "actions.parent", mode = "n" },
                    ["_"] = { "actions.open_cwd", mode = "n" },
                    ["`"] = { "actions.cd", mode = "n" },
                    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                    ["gs"] = { "actions.change_sort", mode = "n" },
                    ["gx"] = "actions.open_external",
                    ["g."] = { "actions.toggle_hidden", mode = "n" },
                    ["g\\"] = { "actions.toggle_trash", mode = "n" },
                    ["gd"] = {
                        desc = "Toggle file detail view",
                        callback = function()
                            detail = not detail
                            if detail then
                                require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                            else
                                require("oil").set_columns({ "icon" })
                            end
                        end,
                    },
                },
                float = {
                    border = border,
                },
                confirmation = {
                    border = border,
                },
                progress = {
                    border = border,
                },
                git = {
                    -- Return true to automatically git add/mv/rm files
                    add = function(path)
                        return true
                    end,
                    mv = function(src_path, dest_path)
                        return true
                    end,
                    rm = function(path)
                        return true
                    end,
                },
                ssh = {
                    border = border,
                },
                keymaps_help = {
                    border = border,
                },
            }
        end,
        keys = {
            { '-', '<cmd>Oil<cr>', desc = 'Edit Files' },
        },
    },
    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "stevearc/oil.nvim" },
        opts = function ()
            local icons = require('util.icons')
            return {
                diagnostic_symbols = {
                    error = icons.lsp_diag.Error,
                    warn  = icons.lsp_diag.Warn,
                    info  = icons.lsp_diag.Info,
                    hint  = icons.lsp_diag.Hint,
                },
            }
        end,
    },
}
