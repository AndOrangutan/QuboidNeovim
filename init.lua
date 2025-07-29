local def = require('defaults')
require('util.supporter').init(def.supporter)

-- Lua configuration
require("config").init()

-- Package manager
require("plugin-manager")

require('highlights')

-- require('test')
