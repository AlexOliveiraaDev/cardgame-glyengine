local game_src_ui_gameUI_1c5d50 = nil
local game_src_game_managers_GameManager_1b6858 = nil
local game_src_game_config_GameConfig_1c70c0 = nil
local game_src_game_entities_table_210ff0 = nil
local game_src_game_entities_Player_1c7808 = nil
local game_src_game_entities_Opponent_1d8c20 = nil
local game_src_game_upgrades_UpgradeManager_1d8898 = nil
local game_src_core_utils_waitManager_1d3a98 = nil
local game_src_game_data_CardDefinitions_26abf8 = nil
local game_src_core_spatial_vector2_1c3ea8 = nil
local game_src_game_utils_CardFactory_1cba90 = nil
local game_src_game_entities_hand_1c6378 = nil
local game_src_game_upgrades_upgradeDeck_1d8bb0 = nil
local game_src_game_data_UpgradeDefinitions_10c760 = nil
local game_src_game_entities_card_1d3ba8 = nil
local game_src_game_upgrades_upgradeCard_1a75d8 = nil
local game_src_game_entities_gameObject_1bd220 = nil
local game_src_core_spatial_transform_1cba68 = nil
local game_src_core_animation_animationController_1d53b0 = nil
local function main_1e5fa0()
local function __TS__New(target, ...)
local instance = setmetatable({}, target.prototype)
instance:____constructor(...)
return instance
end
local __TS__Symbol, Symbol
do
local symbolMetatable = {__tostring = function(self)
return ("Symbol(" .. (self.description or "")) .. ")"
end}
function __TS__Symbol(description)
return setmetatable({description = description}, symbolMetatable)
end
Symbol = {
asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
dispose = __TS__Symbol("Symbol.dispose"),
iterator = __TS__Symbol("Symbol.iterator"),
hasInstance = __TS__Symbol("Symbol.hasInstance"),
species = __TS__Symbol("Symbol.species"),
toStringTag = __TS__Symbol("Symbol.toStringTag")
}
end
local function __TS__InstanceOf(obj, classTbl)
if type(classTbl) ~= "table" then
error("Right-hand side of 'instanceof' is not an object", 0)
end
if classTbl[Symbol.hasInstance] ~= nil then
return not not classTbl[Symbol.hasInstance](classTbl, obj)
end
if type(obj) == "table" then
local luaClass = obj.constructor
while luaClass ~= nil do
if luaClass == classTbl then
return true
end
luaClass = luaClass.____super
end
end
return false
end
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
end
local __TS__Promise
do
local function makeDeferredPromiseFactory()
local resolve
local reject
local function executor(____, res, rej)
resolve = res
reject = rej
end
return function()
local promise = __TS__New(__TS__Promise, executor)
return promise, resolve, reject
end
end
local makeDeferredPromise = makeDeferredPromiseFactory()
local function isPromiseLike(value)
return __TS__InstanceOf(value, __TS__Promise)
end
local function doNothing(self)
end
local ____pcall = _G.pcall
__TS__Promise = __TS__Class()
__TS__Promise.name = "__TS__Promise"
function __TS__Promise.prototype.____constructor(self, executor)
self.state = 0
self.fulfilledCallbacks = {}
self.rejectedCallbacks = {}
self.finallyCallbacks = {}
local success, ____error = ____pcall(
executor,
nil,
function(____, v) return self:resolve(v) end,
function(____, err) return self:reject(err) end
)
if not success then
self:reject(____error)
end
end
function __TS__Promise.resolve(value)
if __TS__InstanceOf(value, __TS__Promise) then
return value
end
local promise = __TS__New(__TS__Promise, doNothing)
promise.state = 1
promise.value = value
return promise
end
function __TS__Promise.reject(reason)
local promise = __TS__New(__TS__Promise, doNothing)
promise.state = 2
promise.rejectionReason = reason
return promise
end
__TS__Promise.prototype["then"] = function(self, onFulfilled, onRejected)
local promise, resolve, reject = makeDeferredPromise()
self:addCallbacks(
onFulfilled and self:createPromiseResolvingCallback(onFulfilled, resolve, reject) or resolve,
onRejected and self:createPromiseResolvingCallback(onRejected, resolve, reject) or reject
)
return promise
end
function __TS__Promise.prototype.addCallbacks(self, fulfilledCallback, rejectedCallback)
if self.state == 1 then
return fulfilledCallback(nil, self.value)
end
if self.state == 2 then
return rejectedCallback(nil, self.rejectionReason)
end
local ____self_fulfilledCallbacks_0 = self.fulfilledCallbacks
____self_fulfilledCallbacks_0[#____self_fulfilledCallbacks_0 + 1] = fulfilledCallback
local ____self_rejectedCallbacks_1 = self.rejectedCallbacks
____self_rejectedCallbacks_1[#____self_rejectedCallbacks_1 + 1] = rejectedCallback
end
function __TS__Promise.prototype.catch(self, onRejected)
return self["then"](self, nil, onRejected)
end
function __TS__Promise.prototype.finally(self, onFinally)
if onFinally then
local ____self_finallyCallbacks_2 = self.finallyCallbacks
____self_finallyCallbacks_2[#____self_finallyCallbacks_2 + 1] = onFinally
if self.state ~= 0 then
onFinally(nil)
end
end
return self
end
function __TS__Promise.prototype.resolve(self, value)
if isPromiseLike(value) then
return value:addCallbacks(
function(____, v) return self:resolve(v) end,
function(____, err) return self:reject(err) end
)
end
if self.state == 0 then
self.state = 1
self.value = value
return self:invokeCallbacks(self.fulfilledCallbacks, value)
end
end
function __TS__Promise.prototype.reject(self, reason)
if self.state == 0 then
self.state = 2
self.rejectionReason = reason
return self:invokeCallbacks(self.rejectedCallbacks, reason)
end
end
function __TS__Promise.prototype.invokeCallbacks(self, callbacks, value)
local callbacksLength = #callbacks
local finallyCallbacks = self.finallyCallbacks
local finallyCallbacksLength = #finallyCallbacks
if callbacksLength ~= 0 then
for i = 1, callbacksLength - 1 do
callbacks[i](callbacks, value)
end
if finallyCallbacksLength == 0 then
return callbacks[callbacksLength](callbacks, value)
end
callbacks[callbacksLength](callbacks, value)
end
if finallyCallbacksLength ~= 0 then
for i = 1, finallyCallbacksLength - 1 do
finallyCallbacks[i](finallyCallbacks)
end
return finallyCallbacks[finallyCallbacksLength](finallyCallbacks)
end
end
function __TS__Promise.prototype.createPromiseResolvingCallback(self, f, resolve, reject)
return function(____, value)
local success, resultOrError = ____pcall(f, nil, value)
if not success then
return reject(nil, resultOrError)
end
return self:handleCallbackValue(resultOrError, resolve, reject)
end
end
function __TS__Promise.prototype.handleCallbackValue(self, value, resolve, reject)
if isPromiseLike(value) then
local nextpromise = value
if nextpromise.state == 1 then
return resolve(nil, nextpromise.value)
elseif nextpromise.state == 2 then
return reject(nil, nextpromise.rejectionReason)
else
return nextpromise:addCallbacks(resolve, reject)
end
else
return resolve(nil, value)
end
end
end
local __TS__AsyncAwaiter, __TS__Await
do
local ____coroutine = _G.coroutine or ({})
local cocreate = ____coroutine.create
local coresume = ____coroutine.resume
local costatus = ____coroutine.status
local coyield = ____coroutine.yield
function __TS__AsyncAwaiter(generator)
return __TS__New(
__TS__Promise,
function(____, resolve, reject)
local fulfilled, step, resolved, asyncCoroutine
function fulfilled(self, value)
local success, resultOrError = coresume(asyncCoroutine, value)
if success then
return step(resultOrError)
end
return reject(nil, resultOrError)
end
function step(result)
if resolved then
return
end
if costatus(asyncCoroutine) == "dead" then
return resolve(nil, result)
end
return __TS__Promise.resolve(result):addCallbacks(fulfilled, reject)
end
resolved = false
asyncCoroutine = cocreate(generator)
local success, resultOrError = coresume(
asyncCoroutine,
function(____, v)
resolved = true
return __TS__Promise.resolve(v):addCallbacks(resolve, reject)
end
)
if success then
return step(resultOrError)
else
return reject(nil, resultOrError)
end
end
)
end
function __TS__Await(thing)
return coyield(thing)
end
end
local function __TS__ArrayMap(self, callbackfn, thisArg)
local result = {}
for i = 1, #self do
result[i] = callbackfn(thisArg, self[i], i - 1, self)
end
return result
end
local ____exports = {}
local ____gameUI = game_src_ui_gameUI_1c5d50()
local printCurrentGameState = ____gameUI.printCurrentGameState
local printOpponentPoints = ____gameUI.printOpponentPoints
local printPlayerPoints = ____gameUI.printPlayerPoints
local printControls = ____gameUI.printControls
local printUpgradeInfo = ____gameUI.printUpgradeInfo
local ____GameManager = game_src_game_managers_GameManager_1b6858()
local GameManager = ____GameManager.GameManager
local ____GameConfig = game_src_game_config_GameConfig_1c70c0()
local GameConfig = ____GameConfig.GameConfig
local gameManager
local pressed = false
____exports.meta = {title = "Card Game", author = "", version = "1.0.0", description = ""}
local function init(std, game)
print("Initializing game...")
gameManager = __TS__New(GameManager, std)
end
local function loop(std, game)
return __TS__AsyncAwaiter(function(____awaiter_resolve)
if std.key.press.any then
pressed = true
else
pressed = false
end
gameManager:update(std.delta)
end)
end
local function draw(std, game)
std.draw.clear(std.color.black)
std.draw.color(std.color.white)
std.text.font_size(GameConfig.UI_FONT_SIZE_SMALL)
std.text.font_name(GameConfig.UI_FONT_NAME)
printCurrentGameState(
std,
gameManager:getGameStateText()
)
printPlayerPoints(
std,
gameManager:getPlayer()
)
printOpponentPoints(
std,
gameManager:getOpponent()
)
gameManager:render()
local playerUpgrades = gameManager:getPlayer():getUpgrades()
if #playerUpgrades > 0 then
printUpgradeInfo(std, playerUpgrades)
end
printControls(std)
if GameConfig.DEBUG_MODE then
std.text.font_size(GameConfig.UI_FONT_SIZE_TINY)
std.text.print(
10,
10,
"State: " .. gameManager:getGameState()
)
std.text.print(
10,
25,
"Player Cards: " .. tostring(#gameManager:getPlayer():getHandCards())
)
std.text.print(
10,
40,
"Player Points: " .. tostring(gameManager:getPlayer():getMatchPoints())
)
std.text.print(
10,
55,
"Opponent Points: " .. tostring(gameManager:getOpponent():getMatchPoints())
)
if GameConfig.SHOW_OPPONENT_CARDS then
local opponentCards = gameManager:getOpponent().hand:getAllCards()
std.text.print(
10,
70,
"Opponent Cards: " .. table.concat(
__TS__ArrayMap(
opponentCards,
function(____, c) return c.name end
),
", "
)
)
end
end
end
local function key(std, key)
if pressed then
return
end
if std.key.press.left then
gameManager:handleInput("left")
end
if std.key.press.right then
gameManager:handleInput("right")
end
if std.key.press.a then
print("aaaa")
gameManager:handleInput("action")
end
if std.key.press.menu then
print("Resetting game...")
gameManager = __TS__New(GameManager, std)
end
end
local function exit(std, game)
print("Game exiting...")
end
____exports.config = {require = "http media.video"}
____exports.callbacks = {
init = init,
loop = loop,
draw = draw,
exit = exit,
key = key
}
return ____exports
end
game_src_ui_gameUI_1c5d50 = function()
local function __TS__ArrayForEach(self, callbackFn, thisArg)
for i = 1, #self do
callbackFn(thisArg, self[i], i - 1, self)
end
end
local ____exports = {}
function ____exports.printCurrentGameState(std, gameStateText)
local x = std.app.width / 2 - #gameStateText * 4
local y = 50
std.draw.color(179)
std.draw.rect(
0,
x - 10,
y - 5,
#gameStateText * 8 + 20,
25
)
std.draw.color(4294967295)
std.text.font_size(16)
std.text.print(x, y, gameStateText)
end
function ____exports.printPlayerPoints(std, player)
local text = ("Player: " .. tostring(player:getMatchPoints())) .. " pontos"
local x = 20
local y = std.app.height - 80
std.draw.color(6553779)
std.draw.rect(
0,
x - 5,
y - 5,
#text * 7 + 10,
20
)
std.draw.color(4294967295)
std.text.font_size(12)
std.text.print(x, y, text)
local cardsText = "Cartas: " .. tostring(#player:getHandCards())
std.text.print(x, y + 15, cardsText)
end
function ____exports.printOpponentPoints(std, opponent)
local text = ("Opponent: " .. tostring(opponent.matchPoints)) .. " pontos"
local x = std.app.width - #text * 7 - 20
local y = std.app.height - 80
std.draw.color(1677721779)
std.draw.rect(
0,
x - 5,
y - 5,
#text * 7 + 10,
20
)
std.draw.color(4294967295)
std.text.font_size(12)
std.text.print(x, y, text)
local cardsText = "Cartas: " .. tostring(#opponent.hand:getAllCards())
std.text.print(x, y + 15, cardsText)
end
function ____exports.printUpgradeInfo(std, upgrades)
if #upgrades == 0 then
return
end
local x = 20
local y = 100
std.draw.color(4294967295)
std.text.font_size(14)
std.text.print(x, y, "Upgrades Ativos:")
__TS__ArrayForEach(
upgrades,
function(____, upgrade, index)
local upgradeY = y + 20 + index * 15
std.text.font_size(10)
std.text.print(
x + 10,
upgradeY,
"• " .. tostring(upgrade.name)
)
end
)
end
function ____exports.printControls(std)
local controls = {"← → : Navegar", "A/Enter : Selecionar", "R : Reset (Debug)"}
local x = std.app.width - 150
local y = 20
std.draw.color(204)
std.draw.rect(
0,
x - 10,
y - 5,
160,
#controls * 15 + 10
)
std.draw.color(4294967295)
std.text.font_size(10)
__TS__ArrayForEach(
controls,
function(____, control, index)
std.text.print(x, y + index * 15, control)
end
)
end
function ____exports.printCardInfo(std, card, x, y)
if not card then
return
end
local info = {
"Nome: " .. tostring(card.name),
"Valor: " .. tostring(card.value),
card.is_special and "Especial: Sim" or "Especial: Não"
}
std.draw.color(230)
std.draw.rect(
0,
x - 5,
y - 5,
120,
#info * 12 + 10
)
std.draw.color(4294967295)
std.text.font_size(9)
__TS__ArrayForEach(
info,
function(____, text, index)
std.text.print(x, y + index * 12, text)
end
)
end
return ____exports
end
--
game_src_game_managers_GameManager_1b6858 = function()
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
local ____exports = {}
local ____table = game_src_game_entities_table_210ff0()
local Table = ____table.Table
local ____Player = game_src_game_entities_Player_1c7808()
local Player = ____Player.Player
local ____Opponent = game_src_game_entities_Opponent_1d8c20()
local Opponent = ____Opponent.Opponent
local ____UpgradeManager = game_src_game_upgrades_UpgradeManager_1d8898()
local UpgradeManager = ____UpgradeManager.UpgradeManager
local ____waitManager = game_src_core_utils_waitManager_1d3a98()
local WaitManager = ____waitManager.WaitManager
local ____CardDefinitions = game_src_game_data_CardDefinitions_26abf8()
local CARD_LIST = ____CardDefinitions.CARD_LIST
local ____GameConfig = game_src_game_config_GameConfig_1c70c0()
local GameConfig = ____GameConfig.GameConfig
____exports.GameState = GameState or ({})
____exports.GameState.WAITING_PLAYER_INPUT = "WAITING_PLAYER_INPUT"
____exports.GameState.PLAYER_TURN_ANIMATION = "PLAYER_TURN_ANIMATION"
____exports.GameState.WAITING_ENEMY_TURN = "WAITING_ENEMY_TURN"
____exports.GameState.ENEMY_TURN_ANIMATION = "ENEMY_TURN_ANIMATION"
____exports.GameState.CALCULATING_RESULTS = "CALCULATING_RESULTS"
____exports.GameState.CHOOSING_UPGRADE = "CHOOSING_UPGRADE"
____exports.GameState.GAME_OVER = "GAME_OVER"
____exports.GameManager = __TS__Class()
local GameManager = ____exports.GameManager
GameManager.name = "GameManager"
function GameManager.prototype.____constructor(self, std)
self.gameState = ____exports.GameState.WAITING_PLAYER_INPUT
self.gameStateText = "Escolha sua carta"
self.std = std
self.waitManager = __TS__New(WaitManager)
self:initializeGame()
end
function GameManager.prototype.initializeGame(self)
self.player = __TS__New(Player)
self.opponent = __TS__New(Opponent, GameConfig.DEFAULT_OPPONENT_DUMBNESS)
self.table = __TS__New(Table, self.std, self.player, self.opponent)
self.upgradeManager = __TS__New(UpgradeManager, self.player)
self.player.hand:generateNewHand(CARD_LIST)
self.opponent:generateNewHand(CARD_LIST)
self.player.hand:setCardsPosition(self.std.app.width, self.std.app.height)
self.opponent:setCardsPosition(self.std.app.width, self.std.app.height)
self.opponent:hideCards()
if #self.player.hand:getAllCards() > 0 then
self.player.hand:getAllCards()[1]:up()
end
self.gameState = ____exports.GameState.WAITING_PLAYER_INPUT
self.gameStateText = "Escolha sua carta"
end
function GameManager.prototype.handlePlayerCardSelection(self)
if self.gameState ~= ____exports.GameState.WAITING_PLAYER_INPUT then
return
end
local selectedCard = self.player:getSelectedCard()
self.table:setPlayerCard(selectedCard)
self.table.lastOpponentCard = nil
self.gameState = ____exports.GameState.PLAYER_TURN_ANIMATION
self.gameStateText = "Jogador jogou!"
self.waitManager:addWait({
id = "player_card_animation",
duration = GameConfig.CARD_ANIMATION_DURATION,
onComplete = function()
print("Turno do oponente")
self.gameState = ____exports.GameState.WAITING_ENEMY_TURN
self.gameStateText = "Oponente pensando..."
self:handleOpponentTurn()
end,
onUpdate = function(____, progress)
end
})
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
print((("Jogador: " .. tostring(playerValue)) .. " vs Oponente: ") .. tostring(opponentValue))
self.waitManager:addWait({
id = "calculating_results",
duration = GameConfig.RESULT_CALCULATION_TIME,
onComplete = function()
if playerValue > opponentValue then
local ____self_player_0, ____matchPoints_1 = self.player, "matchPoints"
____self_player_0[____matchPoints_1] = ____self_player_0[____matchPoints_1] + 1
self.table:hitOpponent()
self.gameStateText = "Jogador ganhou a rodada!"
elseif opponentValue > playerValue then
local ____self_opponent_2, ____matchPoints_3 = self.opponent, "matchPoints"
____self_opponent_2[____matchPoints_3] = ____self_opponent_2[____matchPoints_3] + 1
self.table:hitPlayer()
self.gameStateText = "Oponente ganhou a rodada!"
else
self.gameStateText = "Empate!"
end
if #self.player:getHandCards() == 0 then
self:handleEndGame()
else
setTimeout(
_G,
function()
self.gameState = ____exports.GameState.WAITING_PLAYER_INPUT
self.gameStateText = "Escolha sua carta"
end,
GameConfig.RESULT_DISPLAY_TIME * 1000
)
end
end,
onUpdate = function(____, progress)
print(("Calculando resultado: " .. tostring(math.floor(progress * 100 + 0.5))) .. "%")
end
})
end
function GameManager.prototype.calculateCardValue(self, card, player)
local value = card.value
local upgrades = player:getUpgrades()
for ____, upgrade in ipairs(upgrades) do
repeat
local ____switch25 = upgrade.special_effect
local ____cond25 = ____switch25 == 1
if ____cond25 then
value = self:applyComboNaipes(
player:getCardHistory(),
value
)
break
end
until true
end
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
function GameManager.prototype.resetGame(self)
self.player.matchPoints = 0
self.opponent.matchPoints = 0
self.player.hand:generateNewHand(CARD_LIST)
self.opponent:generateNewHand(CARD_LIST)
self.player.hand:setCardsPosition(self.std.app.width, self.std.app.height)
self.opponent:setCardsPosition(self.std.app.width, self.std.app.height)
self.opponent:hideCards()
if #self.player.hand:getAllCards() > 0 then
self.player.hand:getAllCards()[1]:up()
end
self.table.lastPlayerCard = nil
self.table.lastOpponentCard = nil
end
function GameManager.prototype.handleInput(self, key)
if self.gameState == ____exports.GameState.GAME_OVER then
return
end
if self.gameState == ____exports.GameState.WAITING_PLAYER_INPUT then
repeat
local ____switch42 = key
local ____cond42 = ____switch42 == "left"
if ____cond42 then
self.player.hand:switchActiveCard(false)
break
end
____cond42 = ____cond42 or ____switch42 == "right"
if ____cond42 then
self.player.hand:switchActiveCard(true)
break
end
____cond42 = ____cond42 or ____switch42 == "action"
if ____cond42 then
self:handlePlayerCardSelection()
break
end
until true
end
if self.gameState == ____exports.GameState.CHOOSING_UPGRADE then
repeat
local ____switch44 = key
local ____cond44 = ____switch44 == "left"
if ____cond44 then
self.upgradeManager:switchActiveCard(false)
break
end
____cond44 = ____cond44 or ____switch44 == "right"
if ____cond44 then
self.upgradeManager:switchActiveCard(true)
break
end
____cond44 = ____cond44 or ____switch44 == "action"
if ____cond44 then
self:handleUpgradeSelection()
break
end
until true
end
end
function GameManager.prototype.update(self, dt)
self.waitManager:tick(dt)
self.table:tick(dt)
self.player.hand:updateState(self.std)
self.upgradeManager:updateState(self.std)
end
function GameManager.prototype.render(self)
if self.gameState == ____exports.GameState.GAME_OVER then
self.std.draw.color(self.std.color.white)
self.std.text.font_size(50)
self.std.text.print(self.std.app.width / 2 - 100, self.std.app.height / 2 - 25, "Game Over")
return
end
repeat
local ____switch48 = self.gameState
local ____cond48 = ____switch48 == ____exports.GameState.CHOOSING_UPGRADE
if ____cond48 then
self.upgradeManager:drawHandCards(self.std)
break
end
do
self.table:renderCurrentCard()
self.player.hand:drawHandCards(self.std)
self.opponent.hand:drawHandCards(self.std)
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
return ____exports
end
--
game_src_game_config_GameConfig_1c70c0 = function()
local ____exports = {}
____exports.GameConfig = {
HAND_SIZE = 5,
CARD_WIDTH = 71,
CARD_HEIGHT = 100,
CARD_SPACING = 20,
DEFAULT_OPPONENT_DUMBNESS = 50,
DUMBNESS_VARIATION = 25,
UPGRADE_CARDS_PER_SELECTION = 4,
UPGRADE_CARD_WIDTH = 107,
UPGRADE_CARD_HEIGHT = 150,
CARD_ANIMATION_DURATION = 0.5,
OPPONENT_THINKING_TIME = 1,
RESULT_CALCULATION_TIME = 1,
RESULT_DISPLAY_TIME = 1.5,
TABLE_CARD_WIDTH = 30,
TABLE_CARD_HEIGHT = 120,
PLAYER_CARD_OFFSET_X = -30,
PLAYER_CARD_OFFSET_Y = 30,
OPPONENT_CARD_OFFSET_X = 30,
OPPONENT_CARD_OFFSET_Y = -30,
CARD_BACK_TEXTURE = "Card_2.png",
CARD_DAMAGE_TEXTURE = "card_damage.png",
UI_FONT_SIZE_LARGE = 50,
UI_FONT_SIZE_MEDIUM = 16,
UI_FONT_SIZE_SMALL = 12,
UI_FONT_SIZE_TINY = 10,
UI_FONT_NAME = "tiny.ttf",
UI_BACKGROUND_ALPHA = 0.7,
UI_PLAYER_COLOR = {0, 100, 0, 0.7},
UI_OPPONENT_COLOR = {100, 0, 0, 0.7},
UI_INFO_COLOR = {0, 0, 0, 0.8},
MAX_DUPLICATE_CARDS_IN_HAND = 2,
MAX_HIGH_VALUE_CARDS_IN_HAND = 2,
HIGH_VALUE_CARD_THRESHOLD = 10,
VERY_DUMB_THRESHOLD = 70,
MEDIUM_DUMB_THRESHOLD = 25,
SPECIAL_EFFECTS = {
JACK = 1,
QUEEN = 2,
KING = 3,
RED_JOKER = 4,
BLACK_JOKER = 5
},
UPGRADE_EFFECTS = {
COMBO_NAIPES = 1,
CARTA_MARCADA = 2,
BARALHO_ENSANGUENTADO = 3,
ECO_INVERSO = 4,
PRESTIGIO_ANTIGO = 5,
NAIPE_CORINGA = 6,
PRESSAGIO_DERROTA = 7,
CORACAO_FRIO = 8,
RITUAL_DE_TRES = 9,
ORDEM_IMPLACAVEL = 10,
FALHA_CONTROLADA = 11,
AURA_INFLEXIVEL = 12
},
DEBUG_MODE = false,
SHOW_OPPONENT_CARDS = false,
LOG_CARD_SELECTIONS = true,
LOG_UPGRADE_EFFECTS = true
}
return ____exports
end
--
game_src_game_entities_table_210ff0 = function()
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
local ____exports = {}
local ____vector2 = game_src_core_spatial_vector2_1c3ea8()
local Vector2 = ____vector2.Vector2
local ____CardFactory = game_src_game_utils_CardFactory_1cba90()
local createCardInstance = ____CardFactory.createCardInstance
____exports.Table = __TS__Class()
local Table = ____exports.Table
Table.name = "Table"
function Table.prototype.____constructor(self, std, player, opponent)
self.playerCardHistory = {}
self.opponentCardHistory = {}
self.cardWidth = 30
self.cardHeight = 120
self.playerHit = false
self.opponentHit = false
self.playerTimer = 0
self.opponentTimer = 0
self.playerCardTexture = ""
self.opponentCardTexture = ""
self.playerCardValue = 0
self.opponentCardValue = 0
self.std = std
self.player = player
self.opponent = opponent
end
function Table.prototype.setPlayerCard(self, card)
local instanceCard = createCardInstance(card)
local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth - 30, self.std.app.height / 2 - self.cardHeight + 30)
instanceCard.transform.position = position
self.lastPlayerCard = instanceCard
self.lastPlayerCard:up()
self.playerCardTexture = instanceCard.texture
end
function Table.prototype.setOpponentCard(self, card)
local instanceCard = createCardInstance(card)
local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth + 30, self.std.app.height / 2 - self.cardHeight - 30)
instanceCard.transform.position = position
self.lastOpponentCard = instanceCard
self.opponentCardTexture = instanceCard.texture
end
function Table.prototype.renderCurrentCard(self)
if self.lastOpponentCard then
self.lastOpponentCard:drawCard(self.std)
end
if self.lastPlayerCard then
self.lastPlayerCard:drawCard(self.std)
end
end
function Table.prototype.getPlayerCard(self)
if self.lastPlayerCard then
return self.lastPlayerCard
end
end
function Table.prototype.getOpponentCard(self)
if self.lastOpponentCard then
return self.lastOpponentCard
end
end
function Table.prototype.hitPlayer(self)
self.playerHit = true
end
function Table.prototype.hitOpponent(self)
self.opponentHit = true
end
function Table.prototype.applyHitOnPlayer(self, dt)
self.lastPlayerCard.texture = "card_damage.png"
if self.playerTimer <= 1 then
self.playerTimer = self.playerTimer + dt / 100
else
self.playerHit = false
self.playerTimer = 0
self.lastPlayerCard.texture = self.playerCardTexture
end
end
function Table.prototype.applyHitOnOpponent(self, dt)
self.lastOpponentCard.texture = "card_damage.png"
if self.opponentTimer <= 1 then
self.opponentTimer = self.opponentTimer + dt / 100
else
self.opponentHit = false
self.opponentTimer = 0
self.lastOpponentCard.texture = self.opponentCardTexture
end
end
function Table.prototype.tick(self, dt)
if self.playerHit then
self:applyHitOnPlayer(dt)
end
if self.opponentHit then
self:applyHitOnOpponent(dt)
end
end
return ____exports
end
--
game_src_game_entities_Player_1c7808 = function()
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
local ____exports = {}
local ____hand = game_src_game_entities_hand_1c6378()
local Hand = ____hand.Hand
____exports.Player = __TS__Class()
local Player = ____exports.Player
Player.name = "Player"
function Player.prototype.____constructor(self)
self.hand = __TS__New(Hand)
self.upgrades = {}
self.matchPoints = 0
self.cardHistory = {}
self.cardHistory = {}
end
function Player.prototype.getSelectedCard(self)
local card = self.hand:getSelectedCard()
if not card then
error(
__TS__New(Error, "No card selected"),
0
)
end
print("Player selected: " .. card.name)
__TS__ArrayUnshift(self.cardHistory, card)
self.hand:removeCardById(card.id)
return card
end
function Player.prototype.getLastCard(self)
return self.cardHistory[1]
end
function Player.prototype.getCardHistory(self)
return self.cardHistory
end
function Player.prototype.addUpgrade(self, upgrade)
local ____self_upgrades_0 = self.upgrades
____self_upgrades_0[#____self_upgrades_0 + 1] = upgrade
print("Added upgrade: " .. upgrade.name)
end
function Player.prototype.getUpgrades(self)
return self.upgrades
end
function Player.prototype.getMatchPoints(self)
return self.matchPoints
end
function Player.prototype.getHandCards(self)
return self.hand:getAllCards()
end
function Player.prototype.hasCards(self)
return #self.hand:getAllCards() > 0
end
function Player.prototype.resetForNewMatch(self)
self.matchPoints = 0
self.cardHistory = {}
end
function Player.prototype.resetCompletely(self)
self.matchPoints = 0
self.cardHistory = {}
self.upgrades = {}
end
return ____exports
end
--
game_src_game_entities_Opponent_1d8c20 = function()
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
local ____exports = {}
local ____vector2 = game_src_core_spatial_vector2_1c3ea8()
local Vector2 = ____vector2.Vector2
local ____hand = game_src_game_entities_hand_1c6378()
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
end
--
game_src_game_upgrades_UpgradeManager_1d8898 = function()
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
local ____exports = {}
local ____vector2 = game_src_core_spatial_vector2_1c3ea8()
local Vector2 = ____vector2.Vector2
local ____upgradeDeck = game_src_game_upgrades_upgradeDeck_1d8bb0()
local UpgradeDeck = ____upgradeDeck.UpgradeDeck
local ____UpgradeDefinitions = game_src_game_data_UpgradeDefinitions_10c760()
local UPGRADE_CARD_LIST = ____UpgradeDefinitions.UPGRADE_CARD_LIST
____exports.UpgradeManager = __TS__Class()
local UpgradeManager = ____exports.UpgradeManager
UpgradeManager.name = "UpgradeManager"
function UpgradeManager.prototype.____constructor(self, player)
self.UPGRADE_QUANTITY = 4
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
end
--
game_src_core_utils_waitManager_1d3a98 = function()
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
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
local function __TS__ArraySome(self, callbackfn, thisArg)
for i = 1, #self do
if callbackfn(thisArg, self[i], i - 1, self) then
return true
end
end
return false
end
local function __TS__ArrayFind(self, predicate, thisArg)
for i = 1, #self do
local elem = self[i]
if predicate(thisArg, elem, i - 1, self) then
return elem
end
end
return nil
end
local function __TS__ArrayMap(self, callbackfn, thisArg)
local result = {}
for i = 1, #self do
result[i] = callbackfn(thisArg, self[i], i - 1, self)
end
return result
end
local ____exports = {}
____exports.WaitManager = __TS__Class()
local WaitManager = ____exports.WaitManager
WaitManager.name = "WaitManager"
function WaitManager.prototype.____constructor(self)
self.waitQueue = {}
end
function WaitManager.prototype.addWait(self, config)
self:removeWait(config.id)
local waitItem = {
id = config.id,
duration = config.duration,
elapsed = 0,
onComplete = config.onComplete,
onUpdate = config.onUpdate
}
local ____self_waitQueue_0 = self.waitQueue
____self_waitQueue_0[#____self_waitQueue_0 + 1] = waitItem
print(((("Added wait: " .. config.id) .. " for ") .. tostring(config.duration)) .. "s")
end
function WaitManager.prototype.removeWait(self, id)
local index = __TS__ArrayFindIndex(
self.waitQueue,
function(____, item) return item.id == id end
)
if index ~= -1 then
__TS__ArraySplice(self.waitQueue, index, 1)
print("Removed wait: " .. id)
end
end
function WaitManager.prototype.clear(self)
print(("Clearing " .. tostring(#self.waitQueue)) .. " waits")
self.waitQueue = {}
end
function WaitManager.prototype.tick(self, deltaTime)
local ____temp_1
if deltaTime > 1 then
____temp_1 = deltaTime / 1000
else
____temp_1 = deltaTime
end
local dt = ____temp_1
do
local i = #self.waitQueue - 1
while i >= 0 do
local waitItem = self.waitQueue[i + 1]
waitItem.elapsed = waitItem.elapsed + dt
local progress = math.min(waitItem.elapsed / waitItem.duration, 1)
if waitItem.onUpdate then
waitItem:onUpdate(progress)
end
if waitItem.elapsed >= waitItem.duration then
waitItem:onComplete()
__TS__ArraySplice(self.waitQueue, i, 1)
print("Completed wait: " .. waitItem.id)
end
i = i - 1
end
end
end
function WaitManager.prototype.hasWait(self, id)
return __TS__ArraySome(
self.waitQueue,
function(____, item) return item.id == id end
)
end
function WaitManager.prototype.getWaitProgress(self, id)
local waitItem = __TS__ArrayFind(
self.waitQueue,
function(____, item) return item.id == id end
)
if not waitItem then
return 0
end
return math.min(waitItem.elapsed / waitItem.duration, 1)
end
function WaitManager.prototype.getActiveWaits(self)
return __TS__ArrayMap(
self.waitQueue,
function(____, item) return item.id end
)
end
return ____exports
end
--
game_src_game_data_CardDefinitions_26abf8 = function()
local ____exports = {}
____exports.CARD_LIST = {
{
id = "clubs_2",
name = "2 of Clubs",
texture = "Clubs_2.png",
value = 2,
is_special = 0,
special_effect = 0
},
{
id = "clubs_3",
name = "3 of Clubs",
texture = "Clubs_3.png",
value = 3,
is_special = 0,
special_effect = 0
},
{
id = "clubs_4",
name = "4 of Clubs",
texture = "Clubs_4.png",
value = 4,
is_special = 0,
special_effect = 0
},
{
id = "clubs_5",
name = "5 of Clubs",
texture = "Clubs_5.png",
value = 5,
is_special = 0,
special_effect = 0
},
{
id = "clubs_6",
name = "6 of Clubs",
texture = "Clubs_6.png",
value = 6,
is_special = 0,
special_effect = 0
},
{
id = "clubs_7",
name = "7 of Clubs",
texture = "Clubs_7.png",
value = 7,
is_special = 0,
special_effect = 0
},
{
id = "clubs_8",
name = "8 of Clubs",
texture = "Clubs_8.png",
value = 8,
is_special = 0,
special_effect = 0
},
{
id = "clubs_9",
name = "9 of Clubs",
texture = "Clubs_9.png",
value = 9,
is_special = 0,
special_effect = 0
},
{
id = "clubs_10",
name = "10 of Clubs",
texture = "Clubs_10.png",
value = 10,
is_special = 0,
special_effect = 0
},
{
id = "clubs_ace",
name = "Ace of Clubs",
texture = "Clubs_ACE.png",
value = 11,
is_special = 0,
special_effect = 0
},
{
id = "clubs_j",
name = "Jack of Clubs",
texture = "Clubs_J.png",
value = 12,
is_special = 1,
special_effect = 1
},
{
id = "clubs_q",
name = "Queen of Clubs",
texture = "Clubs_Q.png",
value = 13,
is_special = 1,
special_effect = 2
},
{
id = "clubs_k",
name = "King of Clubs",
texture = "Clubs_K.png",
value = 14,
is_special = 1,
special_effect = 3
},
{
id = "diamonds_2",
name = "2 of Diamonds",
texture = "Diamonds_2.png",
value = 2,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_3",
name = "3 of Diamonds",
texture = "Diamonds_3.png",
value = 3,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_4",
name = "4 of Diamonds",
texture = "Diamonds_4.png",
value = 4,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_5",
name = "5 of Diamonds",
texture = "Diamonds_5.png",
value = 5,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_6",
name = "6 of Diamonds",
texture = "Diamonds_6.png",
value = 6,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_7",
name = "7 of Diamonds",
texture = "Diamonds_7.png",
value = 7,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_8",
name = "8 of Diamonds",
texture = "Diamonds_8.png",
value = 8,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_9",
name = "9 of Diamonds",
texture = "Diamonds_9.png",
value = 9,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_10",
name = "10 of Diamonds",
texture = "Diamonds_10.png",
value = 10,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_ace",
name = "Ace of Diamonds",
texture = "Diamonds_ACE.png",
value = 11,
is_special = 0,
special_effect = 0
},
{
id = "diamonds_j",
name = "Jack of Diamonds",
texture = "Diamonds_J.png",
value = 12,
is_special = 1,
special_effect = 1
},
{
id = "diamonds_q",
name = "Queen of Diamonds",
texture = "Diamonds_Q.png",
value = 13,
is_special = 1,
special_effect = 2
},
{
id = "diamonds_k",
name = "King of Diamonds",
texture = "Diamonds_K.png",
value = 14,
is_special = 1,
special_effect = 3
},
{
id = "hearts_2",
name = "2 of Hearts",
texture = "Hearts_2.png",
value = 2,
is_special = 0,
special_effect = 0
},
{
id = "hearts_3",
name = "3 of Hearts",
texture = "Hearts_3.png",
value = 3,
is_special = 0,
special_effect = 0
},
{
id = "hearts_4",
name = "4 of Hearts",
texture = "Hearts_4.png",
value = 4,
is_special = 0,
special_effect = 0
},
{
id = "hearts_5",
name = "5 of Hearts",
texture = "Hearts_5.png",
value = 5,
is_special = 0,
special_effect = 0
},
{
id = "hearts_6",
name = "6 of Hearts",
texture = "Hearts_6.png",
value = 6,
is_special = 0,
special_effect = 0
},
{
id = "hearts_7",
name = "7 of Hearts",
texture = "Hearts_7.png",
value = 7,
is_special = 0,
special_effect = 0
},
{
id = "hearts_8",
name = "8 of Hearts",
texture = "Hearts_8.png",
value = 8,
is_special = 0,
special_effect = 0
},
{
id = "hearts_9",
name = "9 of Hearts",
texture = "Hearts_9.png",
value = 9,
is_special = 0,
special_effect = 0
},
{
id = "hearts_10",
name = "10 of Hearts",
texture = "Hearts_10.png",
value = 10,
is_special = 0,
special_effect = 0
},
{
id = "hearts_ace",
name = "Ace of Hearts",
texture = "Hearts_ACE.png",
value = 11,
is_special = 0,
special_effect = 0
},
{
id = "hearts_j",
name = "Jack of Hearts",
texture = "Hearts_J.png",
value = 12,
is_special = 1,
special_effect = 1
},
{
id = "hearts_q",
name = "Queen of Hearts",
texture = "Hearts_Q.png",
value = 13,
is_special = 1,
special_effect = 2
},
{
id = "hearts_k",
name = "King of Hearts",
texture = "Hearts_K.png",
value = 14,
is_special = 1,
special_effect = 3
},
{
id = "spades_2",
name = "2 of Spades",
texture = "Spades_2.png",
value = 2,
is_special = 0,
special_effect = 0
},
{
id = "spades_3",
name = "3 of Spades",
texture = "Spades_3.png",
value = 3,
is_special = 0,
special_effect = 0
},
{
id = "spades_4",
name = "4 of Spades",
texture = "Spades_4.png",
value = 4,
is_special = 0,
special_effect = 0
},
{
id = "spades_5",
name = "5 of Spades",
texture = "Spades_5.png",
value = 5,
is_special = 0,
special_effect = 0
},
{
id = "spades_6",
name = "6 of Spades",
texture = "Spades_6.png",
value = 6,
is_special = 0,
special_effect = 0
},
{
id = "spades_7",
name = "7 of Spades",
texture = "Spades_7.png",
value = 7,
is_special = 0,
special_effect = 0
},
{
id = "spades_8",
name = "8 of Spades",
texture = "Spades_8.png",
value = 8,
is_special = 0,
special_effect = 0
},
{
id = "spades_9",
name = "9 of Spades",
texture = "Spades_9.png",
value = 9,
is_special = 0,
special_effect = 0
},
{
id = "spades_10",
name = "10 of Spades",
texture = "Spades_10.png",
value = 10,
is_special = 0,
special_effect = 0
},
{
id = "spades_ace",
name = "Ace of Spades",
texture = "Spades_ACE.png",
value = 11,
is_special = 0,
special_effect = 0
},
{
id = "spades_j",
name = "Jack of Spades",
texture = "Spades_J.png",
value = 12,
is_special = 1,
special_effect = 1
},
{
id = "spades_q",
name = "Queen of Spades",
texture = "Spades_Q.png",
value = 13,
is_special = 1,
special_effect = 2
},
{
id = "spades_k",
name = "King of Spades",
texture = "Spades_K.png",
value = 14,
is_special = 1,
special_effect = 3
},
{
id = "joker_red",
name = "Red Joker",
texture = "Joker_1.png",
value = 15,
is_special = 1,
special_effect = 4
},
{
id = "joker_black",
name = "Black Joker",
texture = "Joker_2.png",
value = 15,
is_special = 1,
special_effect = 5
}
}
return ____exports
end
--
game_src_core_spatial_vector2_1c3ea8 = function()
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
end
local ____exports = {}
____exports.Vector2 = __TS__Class()
local Vector2 = ____exports.Vector2
Vector2.name = "Vector2"
function Vector2.prototype.____constructor(self, x, y)
self.x = x
self.y = y
end
return ____exports
end
--
game_src_game_utils_CardFactory_1cba90 = function()
local function __TS__New(target, ...)
local instance = setmetatable({}, target.prototype)
instance:____constructor(...)
return instance
end
local ____exports = {}
local ____card = game_src_game_entities_card_1d3ba8()
local Card = ____card.Card
function ____exports.createCardInstance(card)
local cardInfo = {
id = card.id,
name = card.name,
texture = card.texture,
value = card.value,
is_special = card.is_special,
special_effect = card.special_effect
}
return __TS__New(Card, cardInfo)
end
return ____exports
end
--
game_src_game_entities_hand_1c6378 = function()
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
local ____exports = {}
local ____vector2 = game_src_core_spatial_vector2_1c3ea8()
local Vector2 = ____vector2.Vector2
local ____card = game_src_game_entities_card_1d3ba8()
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
end
--
game_src_game_upgrades_upgradeDeck_1d8bb0 = function()
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
local ____exports = {}
local ____upgradeCard = game_src_game_upgrades_upgradeCard_1a75d8()
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
end
--
game_src_game_data_UpgradeDefinitions_10c760 = function()
local ____exports = {}
____exports.UPGRADE_CARD_LIST = {
{id = "combo_naipes", name = "Combo de Naipe", texture = "card1.png", special_effect = 1},
{id = "carta_marcada", name = "Carta Marcada", texture = "card2.png", special_effect = 2},
{id = "baralho_ensanguentado", name = "Baralho Ensanguentado", texture = "card3.png", special_effect = 3},
{id = "eco_inverso", name = "Eco Inverso", texture = "card4.png", special_effect = 4},
{id = "prestigio_antigo", name = "Prestígio Antigo", texture = "card5.png", special_effect = 5},
{id = "naipe_coringa", name = "Naipe Coringa", texture = "card6.png", special_effect = 6},
{id = "pressagio_derrota", name = "Presságio de Derrota", texture = "card7.png", special_effect = 7},
{id = "coracao_frio", name = "Coração Frio", texture = "card8.png", special_effect = 8},
{id = "ritual_de_tres", name = "Ritual de Três", texture = "card9.png", special_effect = 9},
{id = "ordem_implacavel", name = "Ordem Implacável", texture = "card10.png", special_effect = 10},
{id = "falha_controlada", name = "Falha Controlada", texture = "card11.png", special_effect = 11},
{id = "aura_inflexivel", name = "Aura Inflexível", texture = "card12.png", special_effect = 12}
}
return ____exports
end
--
game_src_game_entities_card_1d3ba8 = function()
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
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
local function __TS__New(target, ...)
local instance = setmetatable({}, target.prototype)
instance:____constructor(...)
return instance
end
local ____exports = {}
local ____vector2 = game_src_core_spatial_vector2_1c3ea8()
local Vector2 = ____vector2.Vector2
local ____gameObject = game_src_game_entities_gameObject_1bd220()
local GameObject = ____gameObject.GameObject
____exports.Card = __TS__Class()
local Card = ____exports.Card
Card.name = "Card"
__TS__ClassExtends(Card, GameObject)
function Card.prototype.____constructor(self, cardInfo)
GameObject.prototype.____constructor(
self,
__TS__New(Vector2, 100, 100),
__TS__New(Vector2, 100, 100)
)
self.isUp = false
self.id = cardInfo.id
self.name = cardInfo.name
self.texture = cardInfo.texture
self.value = cardInfo.value
self.is_special = cardInfo.is_special
self.special_effect = cardInfo.special_effect
end
function Card.prototype.up(self)
print("card up")
self:start({x = self.transform.position.x, y = self.transform.position.y - 50}, 0.5)
self.isUp = true
end
function Card.prototype.down(self)
if not self.isUp then
return
end
print("card down")
self:start({x = self.transform.position.x, y = self.transform.position.y + 50}, 0.5)
self.isUp = false
end
function Card.prototype.drawCard(self, std)
std.image.draw("cards/" .. self.texture, self.transform.position.x, self.transform.position.y)
end
function Card.prototype.damage(self, std)
local time = 0
local originalTexture = tostring(self.texture)
self.texture = "card_damage.png"
while time < 2 do
self:drawCard(std)
print("time", time)
time = time + std.delta / 1000
print("texture", self.texture)
end
print("finished damage")
self.texture = originalTexture
end
function Card.prototype.testDamage(self, std)
std.image.draw("cards/card_damage.png", self.transform.position.x, self.transform.position.y)
end
return ____exports
end
--
game_src_game_upgrades_upgradeCard_1a75d8 = function()
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
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
local function __TS__New(target, ...)
local instance = setmetatable({}, target.prototype)
instance:____constructor(...)
return instance
end
local ____exports = {}
local ____vector2 = game_src_core_spatial_vector2_1c3ea8()
local Vector2 = ____vector2.Vector2
local ____gameObject = game_src_game_entities_gameObject_1bd220()
local GameObject = ____gameObject.GameObject
____exports.UpgradeCard = __TS__Class()
local UpgradeCard = ____exports.UpgradeCard
UpgradeCard.name = "UpgradeCard"
__TS__ClassExtends(UpgradeCard, GameObject)
function UpgradeCard.prototype.____constructor(self, cardInfo)
GameObject.prototype.____constructor(
self,
__TS__New(Vector2, 100, 100),
__TS__New(Vector2, 100, 100)
)
self.isUp = false
self.id = cardInfo.id
self.name = cardInfo.name
self.texture = cardInfo.texture
self.special_effect = cardInfo.special_effect
end
function UpgradeCard.prototype.up(self)
print("card up")
self:start({x = self.transform.position.x, y = self.transform.position.y - 50}, 0.5)
self.isUp = true
end
function UpgradeCard.prototype.down(self)
if not self.isUp then
return
end
print("card down")
self:start({x = self.transform.position.x, y = self.transform.position.y + 50}, 0.5)
self.isUp = false
end
function UpgradeCard.prototype.drawCard(self, std)
std.image.draw("cards/" .. self.texture, self.transform.position.x, self.transform.position.y)
end
return ____exports
end
--
game_src_game_entities_gameObject_1bd220 = function()
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
local ____exports = {}
local ____transform = game_src_core_spatial_transform_1cba68()
local Transform = ____transform.Transform
local ____animationController = game_src_core_animation_animationController_1d53b0()
local AnimationController = ____animationController.AnimationController
____exports.GameObject = __TS__Class()
local GameObject = ____exports.GameObject
GameObject.name = "GameObject"
function GameObject.prototype.____constructor(self, position, scale)
self.transform = __TS__New(Transform, position, scale)
self.animator = __TS__New(AnimationController, self)
end
function GameObject.prototype.draw(self, std)
std.draw.rect(
0,
self.transform.position.x,
self.transform.position.y,
self.transform.scale.x,
self.transform.scale.y
)
end
function GameObject.prototype.update(self, dt)
self.animator:update(dt.delta)
end
function GameObject.prototype.start(self, position, duration)
self.animator:start(position, duration)
end
return ____exports
end
--
game_src_core_spatial_transform_1cba68 = function()
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
end
local ____exports = {}
____exports.Transform = __TS__Class()
local Transform = ____exports.Transform
Transform.name = "Transform"
function Transform.prototype.____constructor(self, position, scale)
self.position = position
self.scale = scale
end
return ____exports
end
--
game_src_core_animation_animationController_1d53b0 = function()
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
end
local ____exports = {}
____exports.AnimationController = __TS__Class()
local AnimationController = ____exports.AnimationController
AnimationController.name = "AnimationController"
function AnimationController.prototype.____constructor(self, obj)
self.obj = obj
self.active = false
self.duration = 0
self.elapsed = 0
end
function AnimationController.prototype.start(self, position, duration)
self.startPosition = self.obj.transform.position
self.endPosition = position
self.duration = duration
self.elapsed = 0
self.active = true
end
function AnimationController.prototype.update(self, dt)
if not self.active then
return
end
self.elapsed = self.elapsed + dt / 1000
local t = math.min(self.elapsed / self.duration, 1)
local easedT = 1 - (1 - t) ^ 5
local newX = self.startPosition.x + (self.endPosition.x - self.startPosition.x) * easedT
local newY = self.startPosition.y + (self.endPosition.y - self.startPosition.y) * easedT
self.obj.transform.position.x = newX
self.obj.transform.position.y = newY
if easedT >= 1 then
self.active = false
self.obj.transform.position.x = self.endPosition.x
self.obj.transform.position.y = self.endPosition.y
end
end
return ____exports
end
--
return main_1e5fa0()
