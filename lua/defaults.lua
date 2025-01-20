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
    'NeogitCommitMessage',
    'NeogitDiffView',
    'NeogitStatus',
}

_M.bt_exclude = {
    'nofile',
    'quickfix',
    'prompt',
}


_M.ts_parsers = {
    "c",
    "lua",
    "markdown",
    "markdown_inline",
    "nix",
    "query",
    "vim",
    "vimdoc",
}

_M.lspconfig_to_lsp_name = {
    ['lua-language-server'] = "lua_ls",
    ['nil'] = "nil_ls",
}
return _M
