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
    'NeogitStatus',
    'NeogitCommitMessage',
    'NeogitDiffView',
}

return _M
