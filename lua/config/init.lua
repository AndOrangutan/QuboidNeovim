local _M = {}

_M.did_init = false
_M.init = function()
    if did_init then
        return
    end
    require('config.options')
end

return _M
