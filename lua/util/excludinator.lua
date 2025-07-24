local _M = {}
_M.selected = nil

local texas = {} -- All my exes


function _M.init(def_ft_exes, def_bt_exes)

    if type(def_ft_exes) == "table" then
        texas.default_ft = def_ft_exes
    else
        -- TODO: warn of getting here
        texas.default_ft = {}
    end

    if type(def_bt_exes) == "table" then
        texas.default_bt = def_bt_exes
    else
        -- TODO: warn of getting here
        texas.default_bt = {}
    end
end


-- foo bt|ft
function _M:sel(name, list_type)
    _M.selected = name.."_"..list_type

    if type(texas[_M.selected]) ~= "table" then
        texas[_M.selected] = {}
    end

    if name ~= 'default' then
        for _, v in ipairs(texas["default".."_"..list_type]) do
            table.insert(texas[_M.selected], v)
        end
    end

    return self
end

function _M:add(ext_ex_tbl)
    -- take in table and combine it with
    if type(_M.selected) ~= "string" or type(ext_ex_tbl) ~= "table" then
        vim.notify("shouldn't, be, here 2")
        return
    end

    for _, v in ipairs(ext_ex_tbl) do
        table.insert(texas[_M.selected], v)
    end


    return self
end

function _M:rem(cut_ex_tbl)
    if type(_M.selected) ~= "string" or type(cut_ex_tbl) ~= "table" then
        vim.notify("shouldn't, be, here 3")
        return
    end

    local remove_set = {}
    for _, value in ipairs(cut_ex_tbl) do
        remove_set[value] = true
    end

    local i = 1
    local n = #texas[_M.selected]
    while i <= n do
        if remove_set[texas[_M.selected][i]] then
            texas[_M.selected][i] = texas[_M.selected][n]
            texas[_M.selected][n] = nil
            n = n - 1
        else
            i = i + 1
        end
    end

    return self
end

-- Output the current list
function _M:out()
    return texas[_M.selected]
end

-- Output all lists in texas
function _M:out_all()
    return texas
end

return _M
