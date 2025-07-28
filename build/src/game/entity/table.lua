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

local function __TS__ArrayUnshift(self, ...)
    local items = {...}
    local numItemsToInsert = #items
    if numItemsToInsert == 0 then
        return #self
    end
    for i = #self, 1, -1 do
        self[i + numItemsToInsert] = self[i]
    end
    for i = 1, numItemsToInsert do
        self[i] = items[i]
    end
    return #self
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
local ____exports = {}
local ____card = require("src.game.entity.card")
local Card = ____card.Card
local ____vector2 = require("src.core.spatial.vector2")
local Vector2 = ____vector2.Vector2
local ____upgradeEffects = require("src.game.upgrades.upgradeEffects")
local applyComboNaipes = ____upgradeEffects.applyComboNaipes
____exports.Table = __TS__Class()
local Table = ____exports.Table
Table.name = "Table"
function Table.prototype.____constructor(self, std, player, opponent)
    self.playerCardHistory = {}
    self.opponentCardHistory = {}
    self.cardWidth = 30
    self.cardHeight = 120
    self.playerHit = false
    self.opponentHit = false
    self.playerTimer = 0
    self.opponentTimer = 0
    self.playerCardTexture = ""
    self.opponentCardTexture = ""
    self.playerCardValue = 0
    self.opponentCardValue = 0
    self.std = std
    self.player = player
    self.opponent = opponent
end
function Table.prototype.setPlayerCard(self, card)
    local instanceCard = self:createCardInstance(card)
    local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth - 30, self.std.app.height / 2 - self.cardHeight + 30)
    instanceCard.transform.position = position
    self.lastPlayerCard = instanceCard
    self.playerCardValue = self.lastPlayerCard.value
    self.lastPlayerCard:up()
    self.playerCardTexture = instanceCard.texture
    __TS__ArrayUnshift(self.playerCardHistory, instanceCard)
    self.player.hand:removeCardById(self:getPlayerCard().id)
end
function Table.prototype.setOpponentCard(self, card)
    local instanceCard = self:createCardInstance(card)
    local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth + 30, self.std.app.height / 2 - self.cardHeight - 30)
    instanceCard.transform.position = position
    self.lastOpponentCard = instanceCard
    self.opponentCardValue = self.lastOpponentCard.value
    self.opponentCardTexture = instanceCard.texture
    __TS__ArrayUnshift(self.opponentCardHistory, instanceCard)
    self.opponent.hand:removeCardById(self:getOpponentCard().id)
end
function Table.prototype.createCardInstance(self, card)
    local cardInfo = {
        id = card.id,
        name = card.name,
        texture = card.texture,
        value = card.value,
        is_special = card.is_special,
        special_effect = card.special_effect
    }
    return __TS__New(Card, cardInfo)
end
function Table.prototype.renderCurrentCard(self)
    if self.lastOpponentCard then
        self.lastOpponentCard:drawCard(self.std)
    end
    if self.lastPlayerCard then
        self.lastPlayerCard:drawCard(self.std)
    end
end
function Table.prototype.calculeWin(self)
    print("calcule win")
    if self.playerCardValue > self.opponentCardValue then
        self.opponentHit = true
    elseif self.playerCardValue == self.opponentCardValue then
        self.playerHit = true
        self.opponentHit = true
    else
        self.playerHit = true
    end
end
function Table.prototype.applyUpgrades(self)
    local upgrades = self.player.hand.upgrades
    __TS__ArrayForEach(
        upgrades,
        function(____, upgrade)
            repeat
                local ____switch15 = upgrade.special_effect
                local ____cond15 = ____switch15 == 1
                if ____cond15 then
                    self.lastPlayerCard.value = applyComboNaipes(
                        self:getOpponentCardHistory(),
                        self.lastPlayerCard.value
                    )
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 2
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 3
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 4
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 5
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 6
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 7
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 8
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 9
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 10
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 11
                if ____cond15 then
                    break
                end
                ____cond15 = ____cond15 or ____switch15 == 12
                if ____cond15 then
                    break
                end
            until true
        end
    )
end
function Table.prototype.getPlayerCard(self)
    if self.lastPlayerCard then
        return self.lastPlayerCard
    end
end
function Table.prototype.getOpponentCard(self)
    if self.lastOpponentCard then
        return self.lastOpponentCard
    end
end
function Table.prototype.getPlayerCardHistory(self)
    return self.playerCardHistory
end
function Table.prototype.getOpponentCardHistory(self)
    return self.opponentCardHistory
end
function Table.prototype.hitPlayer(self, dt)
    self.lastPlayerCard.texture = "card_damage.png"
    if self.playerTimer <= 1 then
        self.playerTimer = self.playerTimer + dt / 100
    else
        self.playerHit = false
        self.playerTimer = 0
        local ____self_opponent_0, ____matchPoints_1 = self.opponent, "matchPoints"
        ____self_opponent_0[____matchPoints_1] = ____self_opponent_0[____matchPoints_1] + 1
        self.lastPlayerCard.texture = self.playerCardTexture
    end
end
function Table.prototype.hitOpponent(self, dt)
    self.lastOpponentCard.texture = "card_damage.png"
    if self.opponentTimer <= 1 then
        self.opponentTimer = self.opponentTimer + dt / 100
    else
        self.opponentHit = false
        self.opponentTimer = 0
        local ____self_player_2, ____matchPoints_3 = self.player, "matchPoints"
        ____self_player_2[____matchPoints_3] = ____self_player_2[____matchPoints_3] + 1
        self.lastOpponentCard.texture = self.opponentCardTexture
    end
end
function Table.prototype.tick(self, dt)
    if self.playerHit then
        self:hitPlayer(dt)
    end
    if self.opponentHit then
        self:hitOpponent(dt)
    end
end
return ____exports
