-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end
-- End of Lua Library inline imports
local ____exports = {}
____exports.RenderSystem = __TS__Class()
local RenderSystem = ____exports.RenderSystem
RenderSystem.name = "RenderSystem"
function RenderSystem.prototype.____constructor(self)
end
function RenderSystem.prototype.initialize(self, std)
    print("RenderSystem initialized")
end
return ____exports
