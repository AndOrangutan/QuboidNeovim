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


_M.ft_exclude = {
    '', -- disable for empty buffer
    'fugitive',
    'Lazy',
    'NeogitCommitMessage',
    'NeogitDiffView',
    'NeogitStatus',
}

_M.bt_exclude = {
    'nofile',
    'quickfix',
    'prompt',
}

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
