local defaults = require("defaults")
local highlights = vim.api.nvim_create_augroup('highlights', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    group = highlights,
    callback = function()
        -- Rebind float
        vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })


        -- Requires `vim.opt.cursorline = true`
        --vim.api.nvim_set_hl(0, "CursorLineNr", { link = "Normal" })
        vim.api.nvim_set_hl(0, "CursorLine", { link = "NONE" })

        -- -- Mini Stuffs
        -- vim.api.nvim_set_hl(0, 'MiniMapNormal', { link = 'Comment' })
        vim.api.nvim_set_hl(0, 'MiniIndentscopePrefix', { link = 'Comment' })
        vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { link = 'Comment' })

        -- Eyeliner
        vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
        vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })

        -- -- Illuminate
        -- vim.api.nvim_set_hl(0, 'IlluminatedWordText', { underline = true })
        -- vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { underline = true })
        -- vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { underline = true })

        -- vim.api.nvim_set_hl(0, 'FoldColumn', { link = 'Normal' })

        vim.api.nvim_set_hl(0, 'WinBar', { link = "Normal" })
        vim.api.nvim_set_hl(0, 'WinBarNC', { link = "Normal" })

        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineOk', { undercurl = true })
        vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true })

     require('lualine').refresh()
    end,
})


vim.opt.background = defaults.background
vim.cmd('colorscheme ' .. defaults.colorscheme)
