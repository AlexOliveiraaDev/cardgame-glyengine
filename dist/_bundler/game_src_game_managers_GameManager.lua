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
local ____table = require('game_src_game_entities_table')
local Table = ____table.Table
local ____Player = require('game_src_game_entities_Player')
local Player = ____Player.Player
local ____Opponent = require('game_src_game_entities_Opponent')
local Opponent = ____Opponent.Opponent
local ____UpgradeManager = require('game_src_game_upgrades_UpgradeManager')
local UpgradeManager = ____UpgradeManager.UpgradeManager
local ____waitManager = require('game_src_core_utils_waitManager')
local WaitManager = ____waitManager.WaitManager
local ____CardDefinitions = require('game_src_game_data_CardDefinitions')
local CARD_LIST = ____CardDefinitions.CARD_LIST
local ____GameConfig = require('game_src_game_config_GameConfig')
local GameConfig = ____GameConfig.GameConfig
local ____menuManager = require('game_src_game_managers_menuManager')
local MenuManager = ____menuManager.MenuManager
____exports.GameState = GameState or ({})
____exports.GameState.MENU = "MENU"
____exports.GameState.WAITING_PLAYER_INPUT = "WAITING_PLAYER_INPUT"
____exports.GameState.PLAYER_TURN_ANIMATION = "PLAYER_TURN_ANIMATION"
____exports.GameState.WAITING_ENEMY_TURN = "WAITING_ENEMY_TURN"
____exports.GameState.ENEMY_TURN_ANIMATION = "ENEMY_TURN_ANIMATION"
____exports.GameState.CALCULATING_RESULTS = "CALCULATING_RESULTS"
____exports.GameState.CHOOSING_UPGRADE = "CHOOSING_UPGRADE"
____exports.GameState.GAME_OVER = "GAME_OVER"
____exports.TurnType = TurnType or ({})
____exports.TurnType.PLAYER_FIRST = "PLAYER_FIRST"
____exports.TurnType.OPPONENT_FIRST = "OPPONENT_FIRST"
____exports.GameManager = __TS__Class()
local GameManager = ____exports.GameManager
GameManager.name = "GameManager"
function GameManager.prototype.____constructor(self, std)
    self.currentTurn = ____exports.TurnType.PLAYER_FIRST
    self.roundNumber = 1
    self.firstPlayerCard = nil
    self.isWaitingForSecondPlayer = false
    self.gameState = ____exports.GameState.WAITING_PLAYER_INPUT
    self.gameStateText = "Escolha sua carta"
    self.std = std
    self.waitManager = __TS__New(WaitManager)
    self.menuManager = __TS__New(MenuManager, std)
    self:initializeGame()
    self.gameState = ____exports.GameState.MENU
    self.gameStateText = "Menu Principal"
end
function GameManager.prototype.initializeGame(self)
    print("Initializing game from menu...")
    self.player = __TS__New(Player)
    self.opponent = __TS__New(Opponent, GameConfig.DEFAULT_OPPONENT_DUMBNESS)
    self.table = __TS__New(Table, self.std)
    self.upgradeManager = __TS__New(UpgradeManager, self.player)
end
function GameManager.prototype.cleanTable(self)
    self.table:cleanTable()
end
function GameManager.prototype.handleOpponentTurn(self)
    if self.gameState ~= ____exports.GameState.WAITING_ENEMY_TURN then
        return
    end
    self.gameState = ____exports.GameState.ENEMY_TURN_ANIMATION
    self.waitManager:addWait({
        id = "opponent_thinking",
        duration = GameConfig.OPPONENT_THINKING_TIME,
        onComplete = function()
            local opponentSelectedCard = self.opponent:getBestCard(self.table:getPlayerCard())
            print("Oponente jogou: " .. opponentSelectedCard.name)
            self.table:setOpponentCard(opponentSelectedCard)
            self.waitManager:addWait({
                id = "opponent_card_animation",
                duration = GameConfig.CARD_ANIMATION_DURATION,
                onComplete = function()
                    self:handleGameCalculation()
                end
            })
        end,
        onUpdate = function(____, progress)
        end
    })
end
function GameManager.prototype.handleGameCalculation(self)
    self.gameState = ____exports.GameState.CALCULATING_RESULTS
    self.gameStateText = "Calculando resultado..."
    local playerCard = self.table:getPlayerCard()
    local opponentCard = self.table:getOpponentCard()
    local playerValue = self:calculateCardValue(playerCard, self.player)
    local opponentValue = opponentCard.value
    local playerAttacked = self.currentTurn == ____exports.TurnType.PLAYER_FIRST
    local ____playerAttacked_0
    if playerAttacked then
        ____playerAttacked_0 = playerValue
    else
        ____playerAttacked_0 = opponentValue
    end
    local attackerValue = ____playerAttacked_0
    local ____playerAttacked_1
    if playerAttacked then
        ____playerAttacked_1 = opponentValue
    else
        ____playerAttacked_1 = playerValue
    end
    local defenderValue = ____playerAttacked_1
    print("Rodada " .. tostring(self.roundNumber))
    print(((playerAttacked and "Jogador" or "Oponente") .. " atacou: ") .. tostring(attackerValue))
    print(((playerAttacked and "Oponente" or "Jogador") .. " revidou: ") .. tostring(defenderValue))
    self.waitManager:addWait({
        id = "calculating_results",
        duration = GameConfig.RESULT_CALCULATION_TIME,
        onComplete = function()
            if playerValue > opponentValue then
                local ____self_player_2, ____matchPoints_3 = self.player, "matchPoints"
                ____self_player_2[____matchPoints_3] = ____self_player_2[____matchPoints_3] + 1
                self.table:hitOpponent()
                self.gameStateText = "Jogador ganhou a rodada!"
            elseif opponentValue > playerValue then
                local ____self_opponent_4, ____matchPoints_5 = self.opponent, "matchPoints"
                ____self_opponent_4[____matchPoints_5] = ____self_opponent_4[____matchPoints_5] + 1
                self.table:hitPlayer()
                self.gameStateText = "Oponente ganhou a rodada!"
            else
                self.gameStateText = "Empate!"
            end
            if #self.player:getHandCards() == 0 then
                self:handleEndGame()
            else
                self:alternateFirstPlayer()
                self.waitManager:addWait({
                    id = "finish_round",
                    duration = 1,
                    onComplete = function()
                        self:cleanTable()
                        self:startNewRound()
                    end
                })
            end
        end,
        onUpdate = function(____, progress)
            print(("Calculando resultado: " .. tostring(math.floor(progress * 100 + 0.5))) .. "%")
        end
    })
end
function GameManager.prototype.alternateFirstPlayer(self)
    self.currentTurn = self.currentTurn == ____exports.TurnType.PLAYER_FIRST and ____exports.TurnType.OPPONENT_FIRST or ____exports.TurnType.PLAYER_FIRST
    self.roundNumber = self.roundNumber + 1
    print(((("Próxima rodada (" .. tostring(self.roundNumber)) .. "): ") .. (self.currentTurn == ____exports.TurnType.PLAYER_FIRST and "Jogador" or "Oponente")) .. " começa")
end
function GameManager.prototype.startNewRound(self)
    self.firstPlayerCard = nil
    if self.currentTurn == ____exports.TurnType.PLAYER_FIRST then
        self.gameState = ____exports.GameState.WAITING_PLAYER_INPUT
        self.gameStateText = "Sua vez de atacar!"
    else
        self.gameState = ____exports.GameState.WAITING_ENEMY_TURN
        self.gameStateText = "Oponente vai atacar primeiro..."
        self.waitManager:addWait({
            id = "opponent_first_delay",
            duration = 0.5,
            onComplete = function()
                self:handleOpponentFirstMove()
            end
        })
    end
end
function GameManager.prototype.calculateCardValue(self, card, player)
    local value = card.value
    local upgrades = player:getUpgrades()
    for ____, upgrade in ipairs(upgrades) do
    end
    value = self:applyComboNaipes(
        player:getCardHistory(),
        value
    )
    return value
end
function GameManager.prototype.applyComboNaipes(self, cardHistory, value)
    if #cardHistory < 3 then
        return value
    end
    local cardType = __TS__StringSplit(cardHistory[1].id, "_")[1]
    local count = 0
    do
        local i = 0
        while i < math.min(#cardHistory, 3) do
            local card = cardHistory[i + 1]
            if __TS__StringSplit(card.id, "_")[1] == cardType then
                count = count + 1
            end
            i = i + 1
        end
    end
    if count >= 3 then
        print("aplicando dobro do valor")
        return value * 2
    end
    return value
end
function GameManager.prototype.handleEndGame(self)
    if self.player:getMatchPoints() > self.opponent.matchPoints then
        print("Jogador ganhou a partida!")
        self.gameState = ____exports.GameState.CHOOSING_UPGRADE
        self.gameStateText = "Escolha um upgrade!"
        self.upgradeManager:setCardsCenterPosition(self.std.app.width, self.std.app.height)
    else
        print("Jogador perdeu a partida!")
        self.gameState = ____exports.GameState.GAME_OVER
        self.gameStateText = "Game Over"
    end
end
function GameManager.prototype.handleUpgradeSelection(self)
    local selectedUpgrade = self.upgradeManager:getSelectedUpgrade()
    self.player:addUpgrade(selectedUpgrade)
    print("Upgrade selecionado: " .. selectedUpgrade.name)
    self:resetGame()
    self.gameState = ____exports.GameState.WAITING_PLAYER_INPUT
    self.gameStateText = "Escolha sua carta"
end
function GameManager.prototype.handleInput(self, key)
    if self.gameState == ____exports.GameState.MENU then
        local handled = self.menuManager:handleInput(key)
        if self.menuManager:isInGame() then
            self:initializeGame()
            self.gameState = ____exports.GameState.CHOOSING_UPGRADE
            self.upgradeManager:setCardsCenterPosition(self.std.app.width, self.std.app.height)
            self.gameStateText = "Escolha seu primeiro upgrade!"
        end
        return
    end
    if self.gameState == ____exports.GameState.GAME_OVER then
        if key == "menu" or key == "action" then
            self.menuManager:returnToMenu()
            self.gameState = ____exports.GameState.MENU
            return
        end
        return
    end
    if self.gameState == ____exports.GameState.WAITING_PLAYER_INPUT then
        repeat
            local ____switch43 = key
            local ____cond43 = ____switch43 == "left"
            if ____cond43 then
                self.player.hand:switchActiveCard(false)
                break
            end
            ____cond43 = ____cond43 or ____switch43 == "right"
            if ____cond43 then
                self.player.hand:switchActiveCard(true)
                break
            end
            ____cond43 = ____cond43 or ____switch43 == "action"
            if ____cond43 then
                if self.currentTurn == ____exports.TurnType.PLAYER_FIRST then
                    self:handlePlayerCardSelection()
                else
                    self:handlePlayerResponse()
                end
                break
            end
        until true
    end
    if self.gameState == ____exports.GameState.CHOOSING_UPGRADE then
        repeat
            local ____switch47 = key
            local ____cond47 = ____switch47 == "left"
            if ____cond47 then
                self.upgradeManager:switchActiveCard(false)
                break
            end
            ____cond47 = ____cond47 or ____switch47 == "right"
            if ____cond47 then
                self.upgradeManager:switchActiveCard(true)
                break
            end
            ____cond47 = ____cond47 or ____switch47 == "action"
            if ____cond47 then
                self:handleUpgradeSelection()
                break
            end
        until true
    end
end
function GameManager.prototype.resetGame(self)
    print("reseting game")
    self.currentTurn = ____exports.TurnType.PLAYER_FIRST
    self.roundNumber = 1
    self.firstPlayerCard = nil
    self.player.matchPoints = 0
    self.opponent.matchPoints = 0
    self.player.hand:generateNewHand(CARD_LIST)
    self.opponent:generateNewHand(CARD_LIST)
    self.player.hand:setCardsPosition(self.std.app.width, self.std.app.height)
    self.opponent:setCardsPosition(self.std.app.width, self.std.app.height)
    if #self.player.hand:getAllCards() > 0 then
        self.player.hand:getAllCards()[1]:up()
    end
    self.table.lastPlayerCard = nil
    self.table.lastOpponentCard = nil
end
function GameManager.prototype.getCurrentTurnInfo(self)
    return {turn = self.currentTurn, round = self.roundNumber}
end
function GameManager.prototype.handlePlayerCardSelection(self)
    if self.gameState ~= ____exports.GameState.WAITING_PLAYER_INPUT then
        return
    end
    if self.currentTurn ~= ____exports.TurnType.PLAYER_FIRST then
        return
    end
    local selectedCard = self.player:getSelectedCard()
    self.table:setPlayerCard(selectedCard)
    self.firstPlayerCard = selectedCard
    self.gameState = ____exports.GameState.PLAYER_TURN_ANIMATION
    self.gameStateText = "Jogador atacou! Oponente vai revidar..."
    self.waitManager:addWait({
        id = "player_card_animation",
        duration = GameConfig.CARD_ANIMATION_DURATION,
        onComplete = function()
            self.gameState = ____exports.GameState.WAITING_ENEMY_TURN
            self.gameStateText = "Oponente revidando..."
            self:handleOpponentResponse()
        end,
        onUpdate = function(____, progress)
        end
    })
end
function GameManager.prototype.handleOpponentFirstMove(self)
    if self.gameState ~= ____exports.GameState.WAITING_ENEMY_TURN then
        return
    end
    self.gameState = ____exports.GameState.ENEMY_TURN_ANIMATION
    self.gameStateText = "Oponente atacando..."
    self.waitManager:addWait({
        id = "opponent_thinking",
        duration = GameConfig.OPPONENT_THINKING_TIME,
        onComplete = function()
            local opponentCards = self.opponent.hand:getAllCards()
            local randomCard = opponentCards[math.floor(math.random() * #opponentCards) + 1]
            print("Oponente atacou com: " .. randomCard.name)
            self.opponent:removeSelectedCard(randomCard)
            self.table:setOpponentCard(randomCard)
            self.firstPlayerCard = randomCard
            self.waitManager:addWait({
                id = "opponent_card_animation",
                duration = GameConfig.CARD_ANIMATION_DURATION,
                onComplete = function()
                    self.gameState = ____exports.GameState.WAITING_PLAYER_INPUT
                    self.gameStateText = "Oponente atacou! Sua vez de revidar!"
                end
            })
        end,
        onUpdate = function(____, progress)
        end
    })
end
function GameManager.prototype.handleOpponentResponse(self)
    if self.gameState ~= ____exports.GameState.WAITING_ENEMY_TURN then
        return
    end
    self.gameState = ____exports.GameState.ENEMY_TURN_ANIMATION
    self.waitManager:addWait({
        id = "opponent_thinking",
        duration = GameConfig.OPPONENT_THINKING_TIME,
        onComplete = function()
            local opponentSelectedCard = self.opponent:getBestCard(self.firstPlayerCard)
            print("Oponente revidou com: " .. opponentSelectedCard.name)
            self.table:setOpponentCard(opponentSelectedCard)
            self.waitManager:addWait({
                id = "opponent_response_animation",
                duration = GameConfig.CARD_ANIMATION_DURATION,
                onComplete = function()
                    self:handleGameCalculation()
                end
            })
        end,
        onUpdate = function(____, progress)
        end
    })
end
function GameManager.prototype.handlePlayerResponse(self)
    if self.gameState ~= ____exports.GameState.WAITING_PLAYER_INPUT then
        return
    end
    if self.currentTurn ~= ____exports.TurnType.OPPONENT_FIRST then
        return
    end
    local selectedCard = self.player:getSelectedCard()
    self.table:setPlayerCard(selectedCard)
    self.gameState = ____exports.GameState.PLAYER_TURN_ANIMATION
    self.gameStateText = "Jogador revidou!"
    self.waitManager:addWait({
        id = "player_response_animation",
        duration = GameConfig.CARD_ANIMATION_DURATION,
        onComplete = function()
            self:handleGameCalculation()
        end,
        onUpdate = function(____, progress)
        end
    })
end
function GameManager.prototype.update(self, dt)
    if self.gameState == ____exports.GameState.MENU then
        self.menuManager:update(dt)
        return
    end
    self.waitManager:tick(dt)
    self.table:tick(dt)
    self.player.hand:updateState(self.std)
    self.upgradeManager:updateState(self.std)
end
function GameManager.prototype.render(self)
    if self.gameState == ____exports.GameState.MENU then
        self.menuManager:render()
        return
    end
    if self.gameState == ____exports.GameState.GAME_OVER then
        self.std.draw.color(self.std.color.white)
        self.std.text.font_size(50)
        self.std.text.print_ex(
            self.std.app.width / 2,
            self.std.app.height / 2 - 50,
            "Game Over",
            0,
            0
        )
        self.std.text.font_size(20)
        self.std.draw.color(self.std.color.gray)
        self.std.text.print_ex(
            self.std.app.width / 2,
            self.std.app.height / 2 + 20,
            "A ou MENU para voltar ao menu",
            0,
            0
        )
        return
    end
    repeat
        local ____switch76 = self.gameState
        local ____cond76 = ____switch76 == ____exports.GameState.CHOOSING_UPGRADE
        if ____cond76 then
            self.upgradeManager:drawHandCards(self.std)
            break
        end
        do
            self.table:renderCurrentCard()
            self.player.hand:drawHandCards(self.std, false)
            self.opponent.hand:drawHandCards(self.std, true)
            break
        end
    until true
end
function GameManager.prototype.getGameState(self)
    return self.gameState
end
function GameManager.prototype.getGameStateText(self)
    return self.gameStateText
end
function GameManager.prototype.getPlayer(self)
    return self.player
end
function GameManager.prototype.getOpponent(self)
    return self.opponent
end
function GameManager.prototype.getMenuManager(self)
    return self.menuManager
end
return ____exports
