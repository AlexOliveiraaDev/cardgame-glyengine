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
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
local ____exports = {}
local ____vector2 = require('game_src_core_spatial_vector2')
local Vector2 = ____vector2.Vector2
local ____hand = require('game_src_core_entity_hand')
local Hand = ____hand.Hand
____exports.UpgradeCards = __TS__Class()
local UpgradeCards = ____exports.UpgradeCards
UpgradeCards.name = "UpgradeCards"
__TS__ClassExtends(UpgradeCards, Hand)
function UpgradeCards.prototype.____constructor(self, ...)
    Hand.prototype.____constructor(self, ...)
    self.cardsQuantity = 4
end
function UpgradeCards.prototype.generateNewHand(self, deck)
    print("# Generating New Hand #")
    local newCard = nil
    do
        local i = 0
        while i < self.cardsQuantity do
            newCard = self:getNewCard(deck)
            print("Get card with success:", newCard)
            local cardCount = 0
            do
                local n = 0
                while n < #self.cards do
                    if cardCount == 1 then
                        break
                    end
                    local card = self.cards[n + 1]
                    if card.id == newCard.id then
                        cardCount = cardCount + 1
                    end
                    n = n + 1
                end
            end
            if cardCount >= 1 then
                local reserveCard = self:getNewCard(deck)
                while newCard.id == reserveCard.id do
                    reserveCard = self:getNewCard(deck)
                end
                local ____self_cards_0 = self.cards
                ____self_cards_0[#____self_cards_0 + 1] = reserveCard
            else
                local ____self_cards_1 = self.cards
                ____self_cards_1[#____self_cards_1 + 1] = newCard
            end
            i = i + 1
        end
    end
    print("Finished generating new hand!")
end
function UpgradeCards.prototype.setCardsCenterPosition(self, screenWidth, screenHeight)
    local spacing = 20
    local cardWidth = 107
    local cardHeight = 150
    local totalWidth = #self.cards * spacing + (#self.cards - 1) * cardWidth
    local x = (screenWidth - totalWidth) / 2
    __TS__ArrayForEach(
        self.cards,
        function(____, card)
            card.transform.position = __TS__New(Vector2, x, screenHeight / 2 - cardHeight)
            x = x + (cardWidth + spacing)
        end
    )
end
function UpgradeCards.prototype.getSelectedUpgrade(self)
    return self.cards[self.selectedCard + 1]
end
return ____exports
