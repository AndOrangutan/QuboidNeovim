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

return _M
