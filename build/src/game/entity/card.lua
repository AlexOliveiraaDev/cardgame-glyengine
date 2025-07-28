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
local ____vector2 = require("src.core.spatial.vector2")
local Vector2 = ____vector2.Vector2
local ____gameObject = require("src.game.entity.gameObject")
local GameObject = ____gameObject.GameObject
____exports.Card = __TS__Class()
local Card = ____exports.Card
Card.name = "Card"
__TS__ClassExtends(Card, GameObject)
function Card.prototype.____constructor(self, cardInfo)
    GameObject.prototype.____constructor(
        self,
        __TS__New(Vector2, 100, 100),
        __TS__New(Vector2, 100, 100)
    )
    self.isUp = false
    self.id = cardInfo.id
    self.name = cardInfo.name
    self.texture = cardInfo.texture
    self.value = cardInfo.value
    self.is_special = cardInfo.is_special
    self.special_effect = cardInfo.special_effect
end
function Card.prototype.up(self)
    print("card up")
    self:start({x = self.transform.position.x, y = self.transform.position.y - 50}, 0.5)
    self.isUp = true
end
function Card.prototype.down(self)
    if not self.isUp then
        return
    end
    print("card down")
    self:start({x = self.transform.position.x, y = self.transform.position.y + 50}, 0.5)
    self.isUp = false
end
function Card.prototype.drawCard(self, std)
    std.image.draw("cards/" .. self.texture, self.transform.position.x, self.transform.position.y)
end
function Card.prototype.damage(self, std)
    local time = 0
    local originalTexture = tostring(self.texture)
    self.texture = "card_damage.png"
    while time < 2 do
        self:drawCard(std)
        print(time)
        time = time + std.delta / 1000
        print("texture", self.texture)
    end
    print("finished damage")
    self.texture = originalTexture
end
function Card.prototype.testDamage(self, std)
    std.image.draw("cards/card_damage.png", self.transform.position.x, self.transform.position.y)
end
return ____exports
