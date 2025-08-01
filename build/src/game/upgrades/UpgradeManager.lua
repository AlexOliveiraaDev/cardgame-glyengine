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
local ____vector2 = require("src.core.spatial.vector2")
local Vector2 = ____vector2.Vector2
local ____upgradeDeck = require("src.game.upgrades.upgradeDeck")
local UpgradeDeck = ____upgradeDeck.UpgradeDeck
local ____UpgradeDefinitions = require("src.game.data.UpgradeDefinitions")
local UPGRADE_CARD_LIST = ____UpgradeDefinitions.UPGRADE_CARD_LIST
____exports.UpgradeManager = __TS__Class()
local UpgradeManager = ____exports.UpgradeManager
UpgradeManager.name = "UpgradeManager"
function UpgradeManager.prototype.____constructor(self, player)
    self.UPGRADE_QUANTITY = 2
    self.cardsQuantity = 4
    self.selectedCard = 0
    self.player = player
    self.upgradeDeck = __TS__New(UpgradeDeck, UPGRADE_CARD_LIST)
    self.upgradeDeck:generateNewUpgrades(self.UPGRADE_QUANTITY)
    self.upgrades = self.upgradeDeck:getUpgradeCards()
end
function UpgradeManager.prototype.drawHandCards(self, std)
    __TS__ArrayForEach(
        self.upgrades,
        function(____, card)
            card:drawCard(std)
        end
    )
end
function UpgradeManager.prototype.updateState(self, std)
    __TS__ArrayForEach(
        self.upgrades,
        function(____, card)
            card:update(std)
        end
    )
end
function UpgradeManager.prototype.switchActiveCard(self, sum)
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
function UpgradeManager.prototype.setSelectedCard(self, index)
    if index >= 0 and index < #self.upgrades - 1 then
        self.selectedCard = index
    else
        print("Invalid card index")
    end
end
function UpgradeManager.prototype.getAllupgradeDeck(self)
    return self.upgrades
end
function UpgradeManager.prototype.setCardsCenterPosition(self, screenWidth, screenHeight)
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
function UpgradeManager.prototype.getSelectedUpgrade(self)
    return self.upgrades[self.selectedCard + 1]
end
return ____exports
