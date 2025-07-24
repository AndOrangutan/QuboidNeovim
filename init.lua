
-- Lua configuration
require("config").init()

local def = require('defaults')
require('util.excludinator').init(def.ft_exclude, def.bt_exclude)
require('util.supporter').init(def.supporter)

-- Package manager
require("plugin-manager")

require('highlights')

require('test')
