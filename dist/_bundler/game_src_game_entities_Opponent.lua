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
local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
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
local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        elseif _VERSION == "Lua 5.1" then
            return string.sub(
                debug.traceback("", level),
                2
            )
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0")
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, __TS__New)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
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
local ____hand = require('game_src_game_entities_hand')
local Hand = ____hand.Hand
____exports.Opponent = __TS__Class()
local Opponent = ____exports.Opponent
Opponent.name = "Opponent"
function Opponent.prototype.____constructor(self, baseDumbness)
    self.matchPoints = 0
    self.hand = __TS__New(Hand)
    self.baseDumbness = baseDumbness
    self.cardHistory = {}
    print("New opponent created with dumbness:", baseDumbness)
end
function Opponent.prototype.removeSelectedCard(self, card)
    __TS__ArrayUnshift(self.cardHistory, card)
    self.hand:removeCardById(card.id)
end
function Opponent.prototype.generateNewHand(self, deck)
    print("# Generating New Opponent Hand #")
    self.hand.cards = {}
    do
        local i = 0
        while i < self.hand.cardsQuantity do
            local newCard = self.hand:getNewCard(deck)
            print("Got card:", newCard.name)
            local cardCount = 0
            local highCardCount = 0
            do
                local n = 0
                while n < #self.hand.cards do
                    if cardCount >= 2 then
                        break
                    end
                    if highCardCount >= 2 then
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
                local attempts = 0
                while newCard.id == reserveCard.id and attempts < 10 do
                    reserveCard = self.hand:getNewCard(deck)
                    attempts = attempts + 1
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
    print("Finished generating opponent hand with", #self.hand.cards, "cards")
end
function Opponent.prototype.getLastCard(self)
    return self.cardHistory[1]
end
function Opponent.prototype.getCardHistory(self)
    return self.cardHistory
end
function Opponent.prototype.getMatchPoints(self)
    return self.matchPoints
end
function Opponent.prototype.getBestCard(self, playerCard)
    local cards = __TS__ArraySort(
        self.hand:getAllCards(),
        function(____, a, b) return a.value - b.value end
    )
    if #cards == 0 then
        error(
            __TS__New(Error, "Opponent has no cards left"),
            0
        )
    end
    local winningCards = __TS__ArrayFilter(
        cards,
        function(____, item) return item.value > playerCard.value end
    )
    local loseCards = __TS__ArrayFilter(
        cards,
        function(____, item) return item.value < playerCard.value end
    )
    local equalCards = __TS__ArrayFilter(
        cards,
        function(____, item) return item.value == playerCard.value end
    )
    local variation = 25
    local dumbness = math.min(
        100,
        math.max(
            0,
            self.baseDumbness + (math.random() * 2 - 1) * variation
        )
    )
    local selectedCard
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
        selectedCard = pool[math.floor(math.random() * #pool) + 1]
    elseif dumbness >= 25 then
        selectedCard = cards[math.floor(math.random() * #cards) + 1]
    else
        if #winningCards > 0 then
            selectedCard = winningCards[1]
        else
            selectedCard = cards[1]
        end
    end
    print((((("Opponent chose: " .. selectedCard.name) .. " (value: ") .. tostring(selectedCard.value)) .. ") against player's ") .. tostring(playerCard.value))
    self:removeSelectedCard(selectedCard)
    return selectedCard
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
        end
    )
end
function Opponent.prototype.resetForNewMatch(self)
    self.matchPoints = 0
    self.cardHistory = {}
end
return ____exports
