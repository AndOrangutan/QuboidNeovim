return {
    {
        'navarasu/onedark.nvim',
        opts = {
            code_style = {
                comments = 'italic',
                keywords = 'italic,bold',
                functions = 'bold',
                strings = 'italic',
                variables = 'none'
            },
            lualine = {
                transparent = false, -- lualine center bar transparency
            },
            diagnostics = {
                undercurl = false,
            }
        },
        priority = 1000,
    },
}
