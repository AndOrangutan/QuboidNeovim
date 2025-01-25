return {
    {
        'Bekaboo/dropbar.nvim',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.icons',

        },
        event = {'BufReadPost', 'BufNewFile', 'BufWritePre'},
        opts = function ()
            return {
                icons = {
                    kinds = {
                        symbols = MiniIcons.mock_nvim_web_devicons()
                    },
                },
                bar = {
                    enable = function(buf, win, _)
                        if
                            not vim.api.nvim_buf_is_valid(buf)
                            or not vim.api.nvim_win_is_valid(win)
                            or vim.fn.win_gettype(win) ~= ''
                            or vim.wo[win].winbar ~= ''
                            or vim.bo[buf].ft == 'help'
                            or vim.bo[buf].ft == 'NeogitCommitMessage'
                            -- TODO: add better excludes
                        then
                            return false
                        end

                        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
                        if stat and stat.size > 1024 * 1024 then
                            return false
                        end

                        return vim.bo[buf].ft == 'markdown'
                            or vim.bo[buf].ft == 'oil' -- enable in oil buffers
                            or vim.bo[buf].ft == 'fugitive' -- enable in fugitive buffers
                            or pcall(vim.treesitter.get_parser, buf)
                            or not vim.tbl_isempty(vim.lsp.get_clients({
                                bufnr = buf,
                                method = 'textDocument/documentSymbol',
                            }))
                    end,
                },
                sources = {
                    path = {
                        relative_to = function(buf, win)
                            -- Show full path in oil or fugitive buffers
                            local bufname = vim.api.nvim_buf_get_name(buf)
                            if
                                vim.startswith(bufname, 'oil://')
                                or vim.startswith(bufname, 'fugitive://')
                            then
                                local root = bufname:gsub('^%S+://', '', 1)
                                while root and root ~= vim.fs.dirname(root) do
                                    root = vim.fs.dirname(root)
                                end
                                return root
                            end

                            local ok, cwd = pcall(vim.fn.getcwd, win)
                            return ok and cwd or vim.fn.getcwd()
                        end,
                    },
                },
            }
        end,
        keys = function ()
            local dropbar_api = require('dropbar.api')
            return {
                { '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar (dropbar)' } },
                { '[;', dropbar_api.goto_context_start, desc = 'Go to start of current context (dropbar)' },
                { '];', dropbar_api.select_next_context, desc = 'Select next context (dropbar)' },
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'echasnovski/mini.icons',
            { 'mawkler/modicator.nvim', config = true },
        },
        opts = function()
            return {
                options = {
                    component_separators = { left = ' ', right = ' ' },
                    section_separators = { left = ' ', right = ' ' },
                    globalstatus = false,
                },
            }
        end,
    },
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
