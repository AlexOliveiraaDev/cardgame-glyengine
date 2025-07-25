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
local ____upgradeCard = require("src.game.upgrades.upgradeCard")
local UpgradeCard = ____upgradeCard.UpgradeCard
____exports.UpgradeDeck = __TS__Class()
local UpgradeDeck = ____exports.UpgradeDeck
UpgradeDeck.name = "UpgradeDeck"
function UpgradeDeck.prototype.____constructor(self, deck)
    self.upgrades = {}
    self.deck = deck
end
function UpgradeDeck.prototype.getNewCard(self, deck)
    print("Generating UpgradeCard...")
    return __TS__New(
        UpgradeCard,
        deck[math.floor(math.random() * #deck) + 1]
    )
end
function UpgradeDeck.prototype.generateNewUpgrades(self, cardsQuantity)
    print("# Generating New Hand #")
    self.upgrades = {}
    local newCard = nil
    do
        local i = 0
        while i < cardsQuantity do
            newCard = self:getNewCard(self.deck)
            print("Get card with success:", newCard)
            local cardCount = 0
            do
                local n = 0
                while n < #self.upgrades do
                    if cardCount > 0 then
                        break
                    end
                    local card = self.upgrades[n + 1]
                    if card.id == newCard.id then
                        cardCount = cardCount + 1
                    end
                    n = n + 1
                end
            end
            if cardCount > 0 then
                local reserveCard = self:getNewCard(self.deck)
                while newCard.id == reserveCard.id do
                    reserveCard = self:getNewCard(self.deck)
                end
                local ____self_upgrades_0 = self.upgrades
                ____self_upgrades_0[#____self_upgrades_0 + 1] = reserveCard
            else
                local ____self_upgrades_1 = self.upgrades
                ____self_upgrades_1[#____self_upgrades_1 + 1] = newCard
            end
            i = i + 1
        end
    end
    print("Finished generating new hand!")
end
function UpgradeDeck.prototype.getUpgradeCards(self)
    return self.upgrades
end
return ____exports
