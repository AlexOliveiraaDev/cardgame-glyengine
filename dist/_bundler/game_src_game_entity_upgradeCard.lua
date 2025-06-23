-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end
local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end
-- End of Lua Library inline imports
local ____exports = {}
local ____card = require('game_src_game_entity_card')
local Card = ____card.Card
____exports.UpgradeCard = __TS__Class()
local UpgradeCard = ____exports.UpgradeCard
UpgradeCard.name = "UpgradeCard"
__TS__ClassExtends(UpgradeCard, Card)
function UpgradeCard.prototype.____constructor(self, ...)
    Card.prototype.____constructor(self, ...)
    self.a = 0
end
return ____exports
