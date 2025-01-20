return {
    {
        'echasnovski/mini.notify',
        version = false,
        priority = 1000,
        opts = function()

            local opts = { ERROR = { duration = 10000 } }
            vim.notify = require('mini.notify').make_notify(opts)

            vim.api.nvim_create_user_command('NotifyHistory', function()
                vim.cmd [[split]]
                require('mini.notify').show_history()
            end, {})

            return {
                content = {
                    format = nil,
                    sort = function(notif_arr)
                       table.sort(
                           notif_arr,
                           function(a, b) return a.ts_update > b.ts_update end
                       )
                       return notif_arr
                    end,
                },
                lsp_progress = {
                    enable = true,
                    duration_last = 500,
                },
                window = {
                    config = {
                        border = require('defaults').border,
                    },
                },
            }
        end,
    },
}
