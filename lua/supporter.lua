local supporter = {}

--               CLN
--                ui
--                ax
--+LSP----------+----+
--|LSP          | xx|
--|Treesitter   | xx|
--|colorful-menu|x  |
--+-------------+---+

---@class SupportClasses
---@field lsp table
---@field plugins table
local support_classes ={}

support_classes.lsp = {
    ['lua-language-server'] = {
        alt = 'lua_ls',
        ft = 'lua',
    },
    ['nil'] = {
        alt = 'nil_ls',
        ft = 'nix',
    },
    ['ruff'] = {
        alt = 'ruff',
        ft = 'python',
    },
}

support_classes.plugins = {
    ['treesitter'] = {
        "c",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "query",
        "vim",
        "vimdoc",
    },
    -- ['colorful-menu'] = {
    --     'c',
    --     'cs',
    --     'cpp',
    --     'go',
    --     'lua',
    --     'php',
    --     'python',
    --     'rust',
    --     'typescript',
    --     'zig',
    -- }
}

-- Adds to specified table, extending existing tables

-- Retrieve support class
---@param class 'lsp'|'plugins'
---@param subclass string
---@return SupportClasses[class][subclass]
supporter.get = function(class, subclass)
    if type(subclass) ~= 'nil' then
        return support_classes[class][subclass]
    else
        return support_classes[class]
    end
end

return supporter
