-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
local ____exports = {}
local ____upgradeEffects = require("src.game.upgrades.upgradeEffects")
local applyComboNaipes = ____upgradeEffects.applyComboNaipes
____exports.CombatSystem = __TS__Class()
local CombatSystem = ____exports.CombatSystem
CombatSystem.name = "CombatSystem"
function CombatSystem.prototype.____constructor(self, player, opponent)
    self.player = player
    self.opponent = opponent
end
function CombatSystem.prototype.applyUpgrades(self)
    local upgrades = self.player.hand.upgrades
    __TS__ArrayForEach(
        upgrades,
        function(____, upgrade)
            repeat
                local ____switch5 = upgrade.special_effect
                local ____cond5 = ____switch5 == 1
                if ____cond5 then
                    self.player:getLastCard().value = applyComboNaipes(
                        self.player:getCardHistory(),
                        self.player:getLastCard().value
                    )
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 2
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 3
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 4
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 5
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 6
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 7
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 8
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 9
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 10
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 11
                if ____cond5 then
                    break
                end
                ____cond5 = ____cond5 or ____switch5 == 12
                if ____cond5 then
                    break
                end
            until true
        end
    )
end
return ____exports
