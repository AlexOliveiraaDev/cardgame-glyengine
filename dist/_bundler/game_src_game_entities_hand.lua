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
local function __TS__ArrayFindIndex(self, callbackFn, thisArg)
    for i = 1, #self do
        if callbackFn(thisArg, self[i], i - 1, self) then
            return i - 1
        end
    end
    return -1
end
local function __TS__CountVarargs(...)
    return select("#", ...)
end
local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end
-- End of Lua Library inline imports
local ____exports = {}
local ____vector2 = require('game_src_core_spatial_vector2')
local Vector2 = ____vector2.Vector2
local ____card = require('game_src_game_entities_card')
local Card = ____card.Card
local ____GameConfig = require('game_src_game_config_GameConfig')
local GameConfig = ____GameConfig.GameConfig
____exports.Hand = __TS__Class()
local Hand = ____exports.Hand
Hand.name = "Hand"
function Hand.prototype.____constructor(self)
    self.cards = {}
    self.upgrades = {}
    self.selectedCard = 0
    self.cardsQuantity = GameConfig.HAND_SIZE
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
function Hand.prototype.drawHandCards(self, std, hide)
    if hide == nil then
        hide = false
    end
    __TS__ArrayForEach(
        self.cards,
        function(____, card)
            card:drawCard(std, hide)
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
function Hand.prototype.removeCardById(self, id)
    local index = __TS__ArrayFindIndex(
        self.cards,
        function(____, card) return card.id == id end
    )
    if index ~= -1 then
        __TS__ArraySplice(self.cards, index, 1)
    end
end
function Hand.prototype.use(self)
end
return ____exports
