local _M = {}

_M.border = {
	{" ", "FloatBorder"},
	{" ", "FloatBorder"},
	{" ", "FloatBorder"},
	{" ", "FloatBorder"},
	{" ", "FloatBorder"},
	{" ", "FloatBorder"},
	{" ", "FloatBorder"},
	{" ", "FloatBorder"},
}

_M.colorscheme = "onedark"
_M.background = "dark"

_M.supporter = {
    lsp = {
        ['lua-language-server'] = {
            alt = 'lua_ls',
            ft = { 'lua' },
        },
        ['nil'] = {
            alt = 'nil_ls',
            ft = { 'nix' },
        },
        ['clangd'] = {
            alt = 'clangd',
            ft = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        },
    },
    config = {
        ft = {
            markdown = {
                'markdown',
            },
        },
        exclude = {
            ft = {
                '', -- disable for empty buffer
                'Lazy',
                'NeogitCommitMessage',
                'NeogitDiffView',
                'NeogitStatus',
                'fugitive',
                'oil',
            },
            bt = {
                'nofile',
                'quickfix',
                'prompt',
            },
        },
        images = {
            ft = {
                'jpg',
                'png',
                'oil',
            },
        },
    },

    plugins = {
        treesitter = {
            ft = {
                "c",
                "lua",
                "markdown",
                "markdown_inline",
                "nix",
                'python',
                "query",
                "vim",
                "vimdoc"
            },
        },
    },
}

return _M
