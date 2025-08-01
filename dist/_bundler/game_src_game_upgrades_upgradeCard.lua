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
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
local ____exports = {}
local ____vector2 = require('game_src_core_spatial_vector2')
local Vector2 = ____vector2.Vector2
local ____gameObject = require('game_src_game_entities_gameObject')
local GameObject = ____gameObject.GameObject
____exports.UpgradeCard = __TS__Class()
local UpgradeCard = ____exports.UpgradeCard
UpgradeCard.name = "UpgradeCard"
__TS__ClassExtends(UpgradeCard, GameObject)
function UpgradeCard.prototype.____constructor(self, cardInfo)
    GameObject.prototype.____constructor(
        self,
        __TS__New(Vector2, 100, 100),
        __TS__New(Vector2, 100, 100)
    )
    self.isUp = false
    self.id = cardInfo.id
    self.name = cardInfo.name
    self.texture = cardInfo.texture
    self.special_effect = cardInfo.special_effect
end
function UpgradeCard.prototype.up(self)
    print("card up")
    self:start({x = self.transform.position.x, y = self.transform.position.y - 50}, 0.5)
    self.isUp = true
end
function UpgradeCard.prototype.down(self)
    if not self.isUp then
        return
    end
    print("card down")
    self:start({x = self.transform.position.x, y = self.transform.position.y + 50}, 0.5)
    self.isUp = false
end
function UpgradeCard.prototype.drawCard(self, std)
    std.image.draw("assets/cards/" .. self.texture, self.transform.position.x, self.transform.position.y)
end
return ____exports
