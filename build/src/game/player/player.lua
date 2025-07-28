-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
local ____exports = {}
local ____hand = require("src.game.player.hand")
local Hand = ____hand.Hand
____exports.Player = __TS__Class()
local Player = ____exports.Player
Player.name = "Player"
function Player.prototype.____constructor(self)
    self.hand = __TS__New(Hand)
    self.upgrades = {}
    self.matchPoints = 0
end
function Player.prototype.getSelectedCard(self)
    print(self.hand:getSelectedCard().name)
    return self.hand:getSelectedCard()
end
function Player.prototype.addUpgrade(self, upgrade)
    local ____self_upgrades_0 = self.upgrades
    ____self_upgrades_0[#____self_upgrades_0 + 1] = upgrade
end
return ____exports
