local _M = {}

local is_initialized = false

local cat_filter = nil
local ind_filter = nil
local ele_filter = nil

-- TODO: Maybe cache the lookups?


local supporter = {}

function _M.init(support_tbl)
    if is_initialized == true then
        vim.notify('Supporter has already been initialized!!!')
    end
    if type(support_tbl) ~= 'table' then
        vim.notify("shouldn't be here")
        return
    end

    supporter = support_tbl
    is_initialized = true
end

function _M:categories(to_filter)
    if is_initialized == false then
        vim.notify('Supporter must be initialized first!!!')
    end
    if type(to_filter) ~= 'table' then
        vim.notify('Impropper value: ', to_filter)
    end

    cat_filter = to_filter
    return self
end

function _M:indicies(to_filter)
    if is_initialized == false then
        vim.notify('Supporter must be initialized first!!!')
    end
    if type(to_filter) ~= 'table' then
        vim.notify('Impropper value: ', to_filter)
    end

    ind_filter = to_filter
    return self
end

function _M:elements(to_filter)
    if is_initialized == false then
        vim.notify('Supporter must be initialized first!!!')
    end
    if type(to_filter) ~= 'table' then
        vim.notify('Impropper value: ', to_filter)
    end

    ele_filter = to_filter
    return self
end

local function deep_copy_filter(in_tbl, filters)
    local out_tbl = {}
    for k, v in pairs(in_tbl) do
        if filters[1] == nil or vim.list_contains(filters[1], k) then
            if type(v) == 'table' then
                local slice = table.move(filters, 2, #filters, 1, {})
                out_tbl[k] = deep_copy_filter(v, slice)
                if type(out_tbl[k]) == 'table' and next(out_tbl[k]) == nil then
                    out_tbl[k] = nil
                end

            else
                out_tbl[k] = v
            end
        end
    end
    return out_tbl
end

function _M:out()
    if is_initialized == false then
        vim.notify('Supporter must be initialized first!!!')
    end
    return deep_copy_filter(supporter, {cat_filter, ind_filter, ele_filter})
end

local function deep_copy_crush(in_tbl, filters)
    local out_val = {}
    local out_tbl = {}
    for k, v in pairs(in_tbl) do
        if filters[1] == nil or vim.list_contains(filters[1], k) then
            if type(v) == 'table' then
                local slice = table.move(filters, 2, #filters, 1, {})

                local other_val = deep_copy_crush(v, slice)
                for _, val in ipairs(other_val) do
                    table.insert(out_val, val)
                end

            else
                table.insert(out_val, v)
            end
        end
    end
    return out_val
end

function _M:crush()
    if is_initialized == false then
        vim.notify('Supporter must be initialized first!!!')
    end
    return deep_copy_crush(supporter, {cat_filter, ind_filter, ele_filter})
end

return _M
