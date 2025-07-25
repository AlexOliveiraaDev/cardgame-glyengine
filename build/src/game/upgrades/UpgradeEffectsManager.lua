-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end
-- End of Lua Library inline imports
local ____exports = {}
local ____GameConfig = require("src.game.config.GameConfig")
local GameConfig = ____GameConfig.GameConfig
____exports.UpgradeEffectsManager = __TS__Class()
local UpgradeEffectsManager = ____exports.UpgradeEffectsManager
UpgradeEffectsManager.name = "UpgradeEffectsManager"
function UpgradeEffectsManager.prototype.____constructor(self)
end
function UpgradeEffectsManager.applyUpgradeEffects(self, card, upgrades, cardHistory, gameContext)
    local finalValue = card.value
    for ____, upgrade in ipairs(upgrades) do
        local modifiedValue = self:applySpecificUpgrade(
            upgrade.special_effect,
            card,
            finalValue,
            cardHistory,
            gameContext
        )
        if GameConfig.LOG_UPGRADE_EFFECTS and modifiedValue ~= finalValue then
            print((((("Upgrade '" .. upgrade.name) .. "' modificou valor de ") .. tostring(finalValue)) .. " para ") .. tostring(modifiedValue))
        end
        finalValue = modifiedValue
    end
    return finalValue
end
function UpgradeEffectsManager.applySpecificUpgrade(self, effectId, card, currentValue, cardHistory, gameContext)
    repeat
        local ____switch8 = effectId
        local ____cond8 = ____switch8 == GameConfig.UPGRADE_EFFECTS.COMBO_NAIPES
        if ____cond8 then
            return self:applyComboNaipes(cardHistory, currentValue)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.CARTA_MARCADA
        if ____cond8 then
            return self:applyCartaMarcada(card, currentValue, gameContext)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.BARALHO_ENSANGUENTADO
        if ____cond8 then
            return self:applyBaralhoEnsanguentado(cardHistory, currentValue)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.ECO_INVERSO
        if ____cond8 then
            return self:applyEcoInverso(cardHistory, currentValue)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.PRESTIGIO_ANTIGO
        if ____cond8 then
            return self:applyPrestigioAntigo(card, currentValue, cardHistory)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.NAIPE_CORINGA
        if ____cond8 then
            return self:applyNaipeCoringa(card, currentValue, gameContext)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.PRESSAGIO_DERROTA
        if ____cond8 then
            return self:applyPressagioDerrota(currentValue, gameContext)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.CORACAO_FRIO
        if ____cond8 then
            return self:applyCoracaoFrio(card, currentValue)
        end
        ____cond8 = ____cond8 or ____switch8 == GameConfig.UPGRADE_EFFECTS.ORDEM_IMPLACAVEL
        if ____cond8 then
            return self:applyOrdemImplacavel(currentValue, gameContext)
        end
        do
            return currentValue
        end
    until true
end
function UpgradeEffectsManager.applyComboNaipes(self, cardHistory, value)
    if #cardHistory < 3 then
        return value
    end
    local currentSuit = __TS__StringSplit(cardHistory[1].id, "_")[1]
    local suitCount = 0
    do
        local i = 0
        while i < math.min(#cardHistory, 3) do
            local card = cardHistory[i + 1]
            if __TS__StringSplit(card.id, "_")[1] == currentSuit then
                suitCount = suitCount + 1
            end
            i = i + 1
        end
    end
    if suitCount >= 3 then
        return value * 2
    end
    return value
end
function UpgradeEffectsManager.applyCartaMarcada(self, card, value, gameContext)
    local ____opt_result_2
    if gameContext ~= nil then
        ____opt_result_2 = gameContext.markedCardValue
    end
    local markedValue = ____opt_result_2 or 7
    if card.value == markedValue then
        return value + 2
    end
    return value
end
function UpgradeEffectsManager.applyBaralhoEnsanguentado(self, cardHistory, value)
    local isFirstCard = #cardHistory == 0
    if isFirstCard then
        return math.max(1, value - 1)
    else
        return value + 1
    end
end
function UpgradeEffectsManager.applyEcoInverso(self, cardHistory, value)
    if #cardHistory == 0 then
        return value
    end
    local currentCard = cardHistory[1]
    local previousCard = cardHistory[2]
    if previousCard and currentCard.id == previousCard.id then
        return value + 3
    end
    return value
end
function UpgradeEffectsManager.applyPrestigioAntigo(self, card, value, cardHistory)
    if card.value ~= 10 then
        return value
    end
    return 14
end
function UpgradeEffectsManager.applyNaipeCoringa(self, card, value, gameContext)
    local ____opt_result_5
    if gameContext ~= nil then
        ____opt_result_5 = gameContext.chosenSuit
    end
    local chosenSuit = ____opt_result_5 or "hearts"
    local cardSuit = __TS__StringSplit(card.id, "_")[1]
    if cardSuit == chosenSuit then
        return value + 1
    end
    return value
end
function UpgradeEffectsManager.applyPressagioDerrota(self, value, gameContext)
    local ____opt_result_8
    if gameContext ~= nil then
        ____opt_result_8 = gameContext.consecutiveLosses
    end
    local consecutiveLosses = ____opt_result_8 or 0
    if consecutiveLosses >= 2 then
        return value + 5
    end
    return value
end
function UpgradeEffectsManager.applyCoracaoFrio(self, card, value)
    if card.is_special then
        return math.max(1, value - 2)
    end
    return value
end
function UpgradeEffectsManager.applyOrdemImplacavel(self, value, gameContext)
    local ____opt_result_11
    if gameContext ~= nil then
        ____opt_result_11 = gameContext.isHandOrdered
    end
    local isHandOrdered = ____opt_result_11 or false
    if isHandOrdered then
        return value + 1
    end
    return value
end
function UpgradeEffectsManager.isHandOrdered(self, cards)
    if #cards <= 1 then
        return true
    end
    do
        local i = 1
        while i < #cards do
            if cards[i + 1].value < cards[i].value then
                return false
            end
            i = i + 1
        end
    end
    return true
end
function UpgradeEffectsManager.selectRandomSuit(self)
    local suits = {"clubs", "diamonds", "hearts", "spades"}
    return suits[math.floor(math.random() * #suits) + 1]
end
function UpgradeEffectsManager.selectRandomCardValue(self)
    return math.floor(math.random() * 13) + 2
end
return ____exports
