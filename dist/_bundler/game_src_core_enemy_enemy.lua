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
local function __TS__ArraySlice(self, first, last)
    local len = #self
    first = first or 0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    last = last or len
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
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
-- End of Lua Library inline imports
local ____exports = {}
local ____hand = require('game_src_core_entity_hand')
local Hand = ____hand.Hand
____exports.Enemy = __TS__Class()
local Enemy = ____exports.Enemy
Enemy.name = "Enemy"
function Enemy.prototype.____constructor(self)
    self.hand = __TS__New(Hand)
    print("new hand enemy", self.hand)
end
function Enemy.prototype.getBestCard(self, card)
    print("1")
    local cards = self.hand:getAllCards()
    print("2")
    local sortedCards = __TS__ArraySort(
        __TS__ArraySlice(cards),
        function(____, a, b) return a.value - b.value end
    )
    print("3")
    do
        local i = 0
        while i < #sortedCards do
            local element = sortedCards[i + 1]
            print(element.name)
            if element.value > card.value then
                return element
            end
            i = i + 1
        end
    end
    return sortedCards[1]
end
return ____exports
