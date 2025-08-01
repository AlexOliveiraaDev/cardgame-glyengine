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
local function __TS__ArraySort(self, compareFn)
    if compareFn ~= nil then
        table.sort(
            self,
            function(a, b) return compareFn(nil, a, b) < 0 end
        )
    else
        table.sort(self)
    end
    return self
end
local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
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
local ____hand = require('game_src_game_player_hand')
local Hand = ____hand.Hand
____exports.Opponent = __TS__Class()
local Opponent = ____exports.Opponent
Opponent.name = "Opponent"
function Opponent.prototype.____constructor(self, baseDumbness)
    self.matchPoints = 0
    self.hand = __TS__New(Hand)
    print("new hand opponent", self.hand)
    self.baseDumbness = baseDumbness
end
function Opponent.prototype.generateNewHand(self, deck)
    print("# Generating New Hand #")
    local newCard = nil
    do
        local i = 0
        while i < self.hand.cardsQuantity do
            newCard = self.hand:getNewCard(deck)
            print("Get card with success:", newCard)
            local cardCount = 0
            local highCardCount = 0
            do
                local n = 0
                while n < #self.hand.cards do
                    if cardCount == 2 then
                        break
                    end
                    if highCardCount == 2 then
                        break
                    end
                    local card = self.hand.cards[n + 1]
                    if card.id == newCard.id then
                        cardCount = cardCount + 1
                    end
                    if card.value >= 10 then
                        highCardCount = highCardCount + 1
                    end
                    n = n + 1
                end
            end
            if cardCount >= 2 or highCardCount >= 2 then
                local reserveCard = self.hand:getNewCard(deck)
                while newCard.id == reserveCard.id do
                    reserveCard = self.hand:getNewCard(deck)
                end
                local ____self_hand_cards_0 = self.hand.cards
                ____self_hand_cards_0[#____self_hand_cards_0 + 1] = reserveCard
            else
                local ____self_hand_cards_1 = self.hand.cards
                ____self_hand_cards_1[#____self_hand_cards_1 + 1] = newCard
            end
            i = i + 1
        end
    end
    print("Finished generating new hand!")
end
function Opponent.prototype.getBestCard(self, card)
    local cards = __TS__ArraySort(
        self.hand:getAllCards(),
        function(____, a, b) return a.value - b.value end
    )
    local winningCards = __TS__ArrayFilter(
        cards,
        function(____, item) return item.value > card.value end
    )
    local loseCards = __TS__ArrayFilter(
        cards,
        function(____, item) return item.value < card.value end
    )
    local variation = 25
    local equalCards = __TS__ArrayFilter(
        cards,
        function(____, item) return item.value == card.value end
    )
    local dumbness = math.min(
        100,
        math.max(
            0,
            self.baseDumbness + (math.random() * 2 - 1) * variation
        )
    )
    if dumbness >= 70 then
        local ____temp_3
        if #loseCards > 0 then
            ____temp_3 = loseCards
        else
            local ____temp_2
            if #equalCards > 0 then
                ____temp_2 = equalCards
            else
                ____temp_2 = winningCards
            end
            ____temp_3 = ____temp_2
        end
        local pool = ____temp_3
        return pool[math.floor(math.random() * #pool) + 1]
    end
    if dumbness >= 25 then
        return cards[math.floor(math.random() * #cards) + 1]
    end
    if #winningCards > 0 then
        return winningCards[1]
    end
    return cards[1]
end
function Opponent.prototype.setCardsPosition(self, screenWidth, screenHeight)
    local spacing = 20
    local cardWidth = 71
    local cardHeight = 100
    local totalWidth = #self.hand.cards * spacing + (#self.hand.cards - 1) * cardWidth
    local x = (screenWidth - totalWidth) / 2
    __TS__ArrayForEach(
        self.hand.cards,
        function(____, card)
            card.transform.position = __TS__New(Vector2, x, cardHeight + 50)
            x = x + (cardWidth + spacing)
        end
    )
end
function Opponent.prototype.hideCards(self)
    __TS__ArrayForEach(
        self.hand.cards,
        function(____, card)
            card.texture = "Card_2.png"
            return "Card_2.png"
        end
    )
end
return ____exports
