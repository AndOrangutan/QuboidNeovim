local excludeinator = {}

local texas = texas or {}

-- Tracks the current list name
local cur_name = "default"


-- Initalize Excludinator
function excludeinator:init(default_exes)
    texas.default = default_exes
end

-- Set or switch the current list
function excludeinator:cur(name)
    if not texas[name] then
        texas[name] = {}
        for _, v in ipairs(texas.default) do
            table.insert(texas[name], v)
        end
    end

    cur_name = name
    return self
end

-- Add external exes to the current list
function excludeinator:add(ext_ex)
    for _, ex in ipairs(ext_ex) do
        table.insert(texas[cur_name], ex)
    end
    return self
end

-- Remove specific exes from the current list
function excludeinator:rem(cut_ex)
    local list = texas[cur_name]
    for _, ex in ipairs(cut_ex) do
        for i, v in ipairs(list) do
            if v == ex then
                table.remove(list, i)
                break
            end
        end
    end
    return self
end

-- Output the current list
function excludeinator:out()
    return texas[cur_name]
end

-- Output all lists in texas
function excludeinator:out_all()
    return texas
end

return excludeinator

