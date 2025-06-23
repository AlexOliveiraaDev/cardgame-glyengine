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
local ____upgradeCard = require('game_src_game_upgrades_upgradeCard')
local UpgradeCard = ____upgradeCard.UpgradeCard
____exports.UpgradeOffer = __TS__Class()
local UpgradeOffer = ____exports.UpgradeOffer
UpgradeOffer.name = "UpgradeOffer"
function UpgradeOffer.prototype.____constructor(self)
    self.cardsQuantity = 4
    self.upgrades = {}
    self.selectedCard = 0
end
function UpgradeOffer.prototype.generateNewUpgrades(self, deck)
    print("# Generating New Hand #")
    self.upgrades = {}
    local newCard = nil
    do
        local i = 0
        while i < self.cardsQuantity do
            newCard = self:getNewCard(deck)
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
                local reserveCard = self:getNewCard(deck)
                while newCard.id == reserveCard.id do
                    reserveCard = self:getNewCard(deck)
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
function UpgradeOffer.prototype.getNewCard(self, deck)
    print("Generating UpgradeCard...")
    return __TS__New(
        UpgradeCard,
        deck[math.floor(math.random() * #deck) + 1]
    )
end
function UpgradeOffer.prototype.drawHandCards(self, std)
    __TS__ArrayForEach(
        self.upgrades,
        function(____, card)
            card:drawCard(std)
        end
    )
end
function UpgradeOffer.prototype.updateState(self, std)
    __TS__ArrayForEach(
        self.upgrades,
        function(____, card)
            card:update(std)
        end
    )
end
function UpgradeOffer.prototype.switchActiveCard(self, sum)
    if sum then
        if self.selectedCard < #self.upgrades - 1 then
            self.selectedCard = self.selectedCard + 1
            self.upgrades[self.selectedCard + 1]:up()
            do
                local i = 0
                while i < #self.upgrades do
                    local card = self.upgrades[i + 1]
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
            self.upgrades[self.selectedCard + 1]:up()
            do
                local i = 0
                while i < #self.upgrades do
                    local card = self.upgrades[i + 1]
                    if i ~= self.selectedCard then
                        card:down()
                    end
                    i = i + 1
                end
            end
        end
    end
end
function UpgradeOffer.prototype.setSelectedCard(self, index)
    if index >= 0 and index < #self.upgrades - 1 then
        self.selectedCard = index
    else
        print("Invalid card index")
    end
end
function UpgradeOffer.prototype.getAllUpgrades(self)
    return self.upgrades
end
function UpgradeOffer.prototype.setCardsCenterPosition(self, screenWidth, screenHeight)
    local spacing = 20
    local cardWidth = 107
    local cardHeight = 150
    local totalWidth = #self.upgrades * spacing + (#self.upgrades - 1) * cardWidth
    local x = (screenWidth - totalWidth) / 2
    __TS__ArrayForEach(
        self.upgrades,
        function(____, card)
            card.transform.position = __TS__New(Vector2, x, screenHeight / 2 - cardHeight)
            x = x + (cardWidth + spacing)
        end
    )
end
function UpgradeOffer.prototype.getSelectedUpgrade(self)
    return self.upgrades[self.selectedCard + 1]
end
return ____exports
