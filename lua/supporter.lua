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
    ['basedpyright'] = {
        alt = 'basedpyright',
        ft = 'python',
    },
}

support_classes.ft = {
    markup = {
        'markdown',
    },

}

support_classes.plugins = {
    ['treesitter'] = {
        "c",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        'python',
        "query",
        "vim",
        "vimdoc",
    },
    ['colorful-menu'] = {
        'c',
        'cs',
        'cpp',
        'go',
        'lua',
        'php',
        'python',
        'rust',
        'typescript',
        'zig',
    }
}

-- Adds to specified table, extending existing tables

-- Retrieve support class
---@param class 'ft'|'lsp'|'plugins'
---@param subclass string
---@return SupportClasses[class][subclass]
supporter.get = function(class, subclass)
    if type(subclass) ~= 'nil' then
        if support_classes[class][subclass] == nil then
            vim.notify("Invalid call of supporter.get()", vim.log.levels.ERROR)
            return {}
        end
        return support_classes[class][subclass]
    else
        if support_classes[class] == nil then
            vim.notify("Invalid call of supporter.get()", vim.log.levels.ERROR)
            return {}
        end
        return support_classes[class]
    end
end

return supporter
