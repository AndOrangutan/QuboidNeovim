local _M = {}

_M.gen = {
    box_added      = ' ',
    box_deleted    = ' ',
    box_git        = ' ',
    box_modified   = ' ',
    box_o          = ' ',
    box_o_check    = ' ',
    box_renamed    = ' ',
}

_M.lsp_diag = {
    Error = " ",
    Warn  = " ",
    Hint  = " ",
    Info  = " ",
}

_M.ui = {
    bar_cursor      = '▮',
    bar_thick       = '┃',
    bar_thick_elbow = '┗',
    bar_thick_split = '╏',
    bar_thick_tree  = '┣',
    bar_thin        = '｜',
    arrow_up        = '▲',
    arrow_down      = '▼',
    arrow_left      = '◀',
    arrow_right     = '▶',
}



return _M
