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
            { 'linrongbin16/lsp-progress.nvim', config = true },
            { 'mawkler/modicator.nvim', config = true },
        },
        event = 'VeryLazy',
        opts = function()

            local icons = require('util.icons')

            local function min_window_width(width)
                return function() return vim.fn.winwidth(0) > width end
            end

            -- listen lsp-progress event and refresh lualine
            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
            local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment", link = false })

            local sections = {
                lualine_a = {
                    { 'mode', fmt = function(str) return string.lower(str:sub(1, 1)) end },
                },

                lualine_b = {
                    {
                        'branch',
                        -- cond = min_window_width(120),
                        icon = icons.gen.box_git,
                    },
                    {
                        'diff',
                        symbols = {
                            added = icons.gen.box_added,
                            modified = icons.gen.box_modified,
                            removed = icons.gen.box_deleted,
                        }, -- Changes the symbols used by the diff.
                        -- cond = min_window_width(120),
                        on_click = function() vim.cmd('Neogit') end,
                    },
                },
                lualine_c = {
                    {
                        'diagnostics',
                        update_in_insert = true,
                        symbols = {
                            error = icons.lsp_diag.Error,
                            warn = icons.lsp_diag.Warn,
                            info = icons.lsp_diag.Info,
                            hint = icons.lsp_diag.Hint
                        },
                        -- on_click = function() vim.cmd('TroubleToggle document_diagnostics') end,
                    },
                    {
                        require('lsp-progress').progress,
                        cond = min_window_width(80),
                        color = { fg = string.format("#%06x", comment_hl.fg) },
                        on_click = function() vim.cmd('LspInfo') end,
                    },
                },
                lualine_x = {
                    {
                        require('lazy.status').updates,
                        cond = require('lazy.status').has_updates,
                        color = { fg = string.format("#%06x", comment_hl.fg) },
                        on_click = function() vim.cmd('Lazy') end,
                    },
                },
                lualine_y = {
                    { 'filetype' },
                    { 'filesize' },
                    -- { 'encoding',
                    --     cond = min_window_width(120)
                    -- },
                },
                lualine_z = {
                    { 'location' },
                },
            }
            return {
                sections = sections,
                options = {
                    component_separators = { left = icons.ui.bar_thin, right = icons.ui.bar_thin },
                    section_separators = { left = ' ', right = ' ' },
                    globalstatus = true,
                },
            }
        end,
    },
    {
        'linrongbin16/lsp-progress.nvim',
        opts = function()
            local icons = require('util.icons')
            return {
                spinner = icons.spinner,
                client_format = function(client_name, spinner, series_messages)
                    if #series_messages == 0 then
                        return nil
                    end
                    return {
                        name = client_name,
                        body = spinner .. ' ' .. table.concat(series_messages, ', '),
                    }
                end,
                format = function(client_messages)
                    --- @param name string
                    --- @param msg string?
                    --- @return string
                    local function stringify(name, msg)
                        return msg and string.format('%s %s', name, msg) or name
                    end

                    local sign = icons.gen.server -- nf-fa-gear \uf013
                    local lsp_clients = vim.lsp.get_active_clients()
                    local messages_map = {}
                    for _, climsg in ipairs(client_messages) do
                        messages_map[climsg.name] = climsg.body
                    end

                    if #lsp_clients > 0 then
                        table.sort(lsp_clients, function(a, b)
                            return a.name < b.name
                        end)
                        local builder = {}
                        for _, cli in ipairs(lsp_clients) do
                            if
                                type(cli) == 'table'
                                and type(cli.name) == 'string'
                                and string.len(cli.name) > 0
                            then
                                if messages_map[cli.name] then
                                    table.insert(
                                        builder,
                                        stringify(cli.name, messages_map[cli.name])
                                    )
                                else
                                    table.insert(builder, stringify(cli.name))
                                end
                            end
                        end
                        if #builder > 0 then
                            return sign .. table.concat(builder, ', ')
                        end
                    end
                    return ''
                end,
            }
        end,
    },
}
