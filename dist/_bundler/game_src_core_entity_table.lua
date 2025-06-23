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
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
local ____exports = {}
local ____card = require('game_src_core_entity_card')
local Card = ____card.Card
local ____vector2 = require('game_src_core_spatial_vector2')
local Vector2 = ____vector2.Vector2
____exports.Table = __TS__Class()
local Table = ____exports.Table
Table.name = "Table"
function Table.prototype.____constructor(self, std)
    self.cardWidth = 30
    self.cardHeight = 120
    self.playerHit = false
    self.enemyHit = false
    self.timer = 0
    self.playerCardTexture = ""
    self.enemyCardTexture = ""
    self.std = std
end
function Table.prototype.setPlayerCard(self, card)
    local instanceCard = self:createCardInstance(card)
    local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth - 30, self.std.app.height / 2 - self.cardHeight + 30)
    instanceCard.transform.position = position
    self.lastPlayerCard = instanceCard
    self.lastPlayerCard:up()
    self.playerCardTexture = instanceCard.texture
end
function Table.prototype.setOpponentCard(self, card)
    local instanceCard = self:createCardInstance(card)
    local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth + 30, self.std.app.height / 2 - self.cardHeight - 30)
    instanceCard.transform.position = position
    self.lastOpponentCard = instanceCard
    self.enemyCardTexture = instanceCard.texture
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
    local playerWin = self.lastPlayerCard.value > self.lastOpponentCard.value
    if playerWin then
        self.enemyHit = true
    else
        self.playerHit = true
    end
end
function Table.prototype.applyUpgrades(self, hand)
    local upgrades = hand.upgrades
    __TS__ArrayForEach(
        upgrades,
        function(____, upgrade)
        end
    )
end
function Table.prototype.tick(self, dt)
    if self.lastPlayerCard then
        print(self.lastPlayerCard.texture)
    end
    if self.playerHit then
        self.lastPlayerCard.texture = "card_damage.png"
        if self.timer <= 1 then
            self.timer = self.timer + dt / 100
        else
            self.playerHit = false
            self.timer = 0
            self.lastPlayerCard.texture = self.playerCardTexture
        end
    end
    if self.enemyHit then
        self.lastOpponentCard.texture = "card_damage.png"
        if self.timer <= 1 then
            self.timer = self.timer + dt / 100
        else
            self.enemyHit = false
            self.timer = 0
            self.lastOpponentCard.texture = self.enemyCardTexture
        end
    end
end
return ____exports
