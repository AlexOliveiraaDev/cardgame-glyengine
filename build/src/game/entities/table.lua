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
local ____vector2 = require("src.core.spatial.vector2")
local Vector2 = ____vector2.Vector2
local ____CardFactory = require("src.game.utils.CardFactory")
local createCardInstance = ____CardFactory.createCardInstance
____exports.Table = __TS__Class()
local Table = ____exports.Table
Table.name = "Table"
function Table.prototype.____constructor(self, std)
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
end
function Table.prototype.setPlayerCard(self, card)
    local instanceCard = createCardInstance(card)
    local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth - 30, self.std.app.height / 2 - self.cardHeight + 30)
    instanceCard.transform.position = position
    self.lastPlayerCard = instanceCard
    self.lastPlayerCard:up()
    self.playerCardTexture = instanceCard.texture
end
function Table.prototype.cleanTable(self)
    self.playerCardTexture = nil
    self.lastPlayerCard = nil
    self.opponentCardTexture = nil
    self.lastOpponentCard = nil
end
function Table.prototype.setOpponentCard(self, card)
    local instanceCard = createCardInstance(card)
    local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth + 30, self.std.app.height / 2 - self.cardHeight - 30)
    instanceCard.transform.position = position
    self.lastOpponentCard = instanceCard
    self.opponentCardTexture = instanceCard.texture
end
function Table.prototype.renderCurrentCard(self)
    if self.lastOpponentCard and self.lastOpponentCard.texture then
        self.lastOpponentCard:drawCard(self.std, false)
    end
    if self.lastPlayerCard and self.lastPlayerCard.texture then
        self.lastPlayerCard:drawCard(self.std, false)
    end
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
function Table.prototype.hitPlayer(self)
    self.playerHit = true
end
function Table.prototype.hitOpponent(self)
    self.opponentHit = true
end
function Table.prototype.applyHitOnPlayer(self, dt)
    self.lastPlayerCard.texture = "card_damage.png"
    if self.playerTimer <= 1 then
        self.playerTimer = self.playerTimer + dt / 100
    else
        self.playerHit = false
        self.playerTimer = 0
        self.lastPlayerCard.texture = self.playerCardTexture
    end
end
function Table.prototype.applyHitOnOpponent(self, dt)
    self.lastOpponentCard.texture = "card_damage.png"
    if self.opponentTimer <= 1 then
        self.opponentTimer = self.opponentTimer + dt / 100
    else
        self.opponentHit = false
        self.opponentTimer = 0
        self.lastOpponentCard.texture = self.opponentCardTexture
    end
end
function Table.prototype.applyWinOnPlayer(self, dt)
    self.lastPlayerCard.texture = "card_win.png"
    if self.playerTimer <= 1 then
        self.playerTimer = self.playerTimer + dt / 100
    else
        self.playerHit = false
        self.playerTimer = 0
        self.lastPlayerCard.texture = self.playerCardTexture
    end
end
function Table.prototype.applyWinOnOpponent(self, dt)
    self.lastOpponentCard.texture = "card_win.png"
    if self.opponentTimer <= 1 then
        self.opponentTimer = self.opponentTimer + dt / 100
    else
        self.opponentHit = false
        self.opponentTimer = 0
        self.lastOpponentCard.texture = self.opponentCardTexture
    end
end
function Table.prototype.tick(self, dt)
    if self.playerHit then
        self:applyHitOnPlayer(dt)
    end
    if self.opponentHit then
        self:applyHitOnOpponent(dt)
    end
end
return ____exports
