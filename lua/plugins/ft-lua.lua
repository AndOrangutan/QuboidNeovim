return {
    {
        "folke/lazydev.nvim",
        dependencies = {
            'justinsgithub/wezterm-types',
        },
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                -- Only load the lazyvim library when the `LazyVim` global is found
                { path = "LazyVim", words = { "LazyVim" } },
                -- Load the wezterm types when the `wezterm` module is required
                -- Needs `justinsgithub/wezterm-types` to be installed
                { path = "wezterm-types", mods = { "wezterm" } },
                -- -- Load the xmake types when opening file named `xmake.lua`
                -- -- Needs `LelouchHe/xmake-luals-addon` to be installed
                -- { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
            },
        },
    },
}
