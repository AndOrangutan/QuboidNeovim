
-- Lua configuration
require("config").init()

require("util.excludeinator"):init(require('defaults').ft_exclude)

-- Package manager
require("plugin-manager")

require("highlights")

