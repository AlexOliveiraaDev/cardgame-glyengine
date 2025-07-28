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
local ____waitManager = require("src.core.utils.waitManager")
local WaitManager = ____waitManager.WaitManager
local ____opponent = require("src.game.opponent.opponent")
local Opponent = ____opponent.Opponent
local ____player = require("src.game.player.player")
local Player = ____player.Player
____exports.GameManager = __TS__Class()
local GameManager = ____exports.GameManager
GameManager.name = "GameManager"
function GameManager.prototype.____constructor(self)
    self.waitManager = __TS__New(WaitManager)
    self.player = __TS__New(Player)
    self.opponent = __TS__New(Opponent, 50)
end
return ____exports
