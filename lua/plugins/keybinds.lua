return {
    {
        'folke/which-key.nvim',
        opts = {
            icons = {
                mappings = false,
            },
        },
        keys = {
            { '<leader>' },
            { 'g' },
            { '<c-w>' },
            {
                "<leader>?", function()
                    require("which-key").show({ global = false })
                end, desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
}
