local defaults = require("defaults")
local highlights = vim.api.nvim_create_augroup('highlights', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    group = highlights,
    callback = function()
        -- Rebind float
        vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Pmenu' })


        -- -- Mini Stuffs
        -- vim.api.nvim_set_hl(0, 'MiniMapNormal', { link = 'Comment' })
        -- vim.api.nvim_set_hl(0, 'MiniIndentscopePrefix', { link = 'Comment' })
        -- vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { link = 'Comment' })
        --
        -- -- Eyeliner
        -- vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
        -- vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })
        --
        -- -- Illuminate
        -- vim.api.nvim_set_hl(0, 'IlluminatedWordText', { underline = true, sp = util.get_hl_val('Normal', 'foreground') })
        --
        -- vim.api.nvim_set_hl(0, 'FoldColumn', { link = 'Normal' })

    end,
})


vim.opt.background = defaults.background
vim.cmd('colorscheme ' .. defaults.colorscheme)
