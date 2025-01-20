local ts_parsers = require('defaults').ts_parsers
return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        lazy = vim.fn.argc(-1) == 0, -- Load treesiter early when opening a file from the cmdline
        -- cmd = {
        --    "TSUpdateSync",
        --    "TSUpdate",
        --    "TSInstall",
        -- },
        ft = ts_parsers,
        config = function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = ts_parsers,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = true,
                },
                indent = { enable = true },
            })
        end,
    },
}
