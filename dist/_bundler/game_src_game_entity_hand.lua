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
local ____vector2 = require('game_src_core_spatial_vector2')
local Vector2 = ____vector2.Vector2
local ____card = require('game_src_game_entity_card')
local Card = ____card.Card
____exports.Hand = __TS__Class()
local Hand = ____exports.Hand
Hand.name = "Hand"
function Hand.prototype.____constructor(self)
    self.cards = {}
    self.upgrades = {}
    self.selectedCard = 0
    self.cardsQuantity = 5
end
function Hand.prototype.generateNewHand(self, deck)
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
                    if cardCount == 2 then
                        break
                    end
                    local card = self.cards[n + 1]
                    if card.id == newCard.id then
                        cardCount = cardCount + 1
                    end
                    n = n + 1
                end
            end
            if cardCount >= 2 then
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
function Hand.prototype.getNewCard(self, deck)
    print("Generating Card...")
    return __TS__New(
        Card,
        deck[math.floor(math.random() * #deck) + 1]
    )
end
function Hand.prototype.drawHandCards(self, std)
    __TS__ArrayForEach(
        self.cards,
        function(____, card)
            card:drawCard(std)
        end
    )
end
function Hand.prototype.updateState(self, std)
    __TS__ArrayForEach(
        self.cards,
        function(____, card)
            card:update(std)
        end
    )
end
function Hand.prototype.setCardsPosition(self, screenWidth, screenHeight)
    local spacing = 20
    local cardWidth = 71
    local cardHeight = 100
    local totalWidth = #self.cards * spacing + (#self.cards - 1) * cardWidth
    local x = (screenWidth - totalWidth) / 2
    __TS__ArrayForEach(
        self.cards,
        function(____, card)
            card.transform.position = __TS__New(Vector2, x, screenHeight - cardHeight - spacing * 2)
            x = x + (cardWidth + spacing)
        end
    )
end
function Hand.prototype.switchActiveCard(self, sum)
    if sum then
        if self.selectedCard < #self.cards - 1 then
            self.selectedCard = self.selectedCard + 1
            self.cards[self.selectedCard + 1]:up()
            do
                local i = 0
                while i < #self.cards do
                    local card = self.cards[i + 1]
                    if i ~= self.selectedCard then
                        card:down()
                    end
                    i = i + 1
                end
            end
        end
    else
        if self.selectedCard >= 1 then
            self.selectedCard = self.selectedCard - 1
            self.cards[self.selectedCard + 1]:up()
            do
                local i = 0
                while i < #self.cards do
                    local card = self.cards[i + 1]
                    if i ~= self.selectedCard then
                        card:down()
                    end
                    i = i + 1
                end
            end
        end
    end
end
function Hand.prototype.getSelectedCard(self)
    return self.cards[self.selectedCard + 1]
end
function Hand.prototype.setSelectedCard(self, index)
    if index >= 0 and index < #self.cards - 1 then
        self.selectedCard = index
    else
        print("Invalid card index")
    end
end
function Hand.prototype.getAllCards(self)
    return self.cards
end
function Hand.prototype.addNewUpgrade(self, upgrade)
    local ____self_upgrades_2 = self.upgrades
    ____self_upgrades_2[#____self_upgrades_2 + 1] = upgrade
end
function Hand.prototype.use(self)
end
return ____exports
