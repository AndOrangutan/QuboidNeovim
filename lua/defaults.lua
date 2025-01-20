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

return _M
