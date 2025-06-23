local game_src_game_entity_table_1d8f30 = nil
local game_src_game_cards_cardList_1c6278 = nil
local game_src_game_player_player_10d510 = nil
local game_src_core_utils_waitManager_23acb8 = nil
local game_src_game_upgrades_upgradeOffer_10d4e8 = nil
local game_src_game_upgrades_upgradeList_1d7628 = nil
local game_src_core_ui_ui_1dcf30 = nil
local game_src_game_opponent_opponent_1df618 = nil
local game_src_game_entity_card_1e65b8 = nil
local game_src_core_spatial_vector2_1dc6e8 = nil
local game_src_game_upgrades_upgradeEffects_34a928 = nil
local game_src_game_player_hand_1a1d70 = nil
local game_src_game_upgrades_upgradeCard_1c63b0 = nil
local game_src_game_entity_gameObject_1c2728 = nil
local game_src_core_spatial_transform_1cc088 = nil
local game_src_core_animation_animationController_1dc7d0 = nil
local function main_23d6f0()
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
local ____exports = {}
local handleOpponentTurn, handleGameCalculation, GameState, upgradeDeck, gameState, waitManager, player, std, opponent, ____table
local ____table = game_src_game_entity_table_1d8f30()
local Table = ____table.Table
local ____cardList = game_src_game_cards_cardList_1c6278()
local CARD_LIST = ____cardList.CARD_LIST
local ____player = game_src_game_player_player_10d510()
local Player = ____player.Player
local ____waitManager = game_src_core_utils_waitManager_23acb8()
local WaitManager = ____waitManager.WaitManager
local ____upgradeOffer = game_src_game_upgrades_upgradeOffer_10d4e8()
local UpgradeOffer = ____upgradeOffer.UpgradeOffer
local ____upgradeList = game_src_game_upgrades_upgradeList_1d7628()
local UPGRADE_CARD_LIST = ____upgradeList.UPGRADE_CARD_LIST
local ____ui = game_src_core_ui_ui_1dcf30()
local printCurrentGameState = ____ui.printCurrentGameState
local printOpponentPoints = ____ui.printOpponentPoints
local printPlayerPoints = ____ui.printPlayerPoints
local ____opponent = game_src_game_opponent_opponent_1df618()
local Opponent = ____opponent.Opponent
function handleOpponentTurn()
print("handleOpponentTurn")
if gameState ~= GameState.WAITING_ENEMY_TURN then
return
end
gameState = GameState.ENEMY_TURN_ANIMATION
waitManager:addWait({
id = "opponent_thinking",
duration = 0.5,
onComplete = function()
local opponentSelectedCard = opponent:getBestCard(____table:getPlayerCard())
print(opponentSelectedCard.name)
____table:setOpponentCard(opponentSelectedCard)
waitManager:addWait({
id = "opponent_card_animation",
duration = 0.5,
onComplete = function()
handleGameCalculation()
end
})
end,
onUpdate = function(____, progress)
end
})
end
function handleGameCalculation()
print("handleGameCalculation")
gameState = GameState.CALCULATING_RESULTS
waitManager:addWait({
id = "calculating_results",
duration = 0.5,
onComplete = function()
print("=== STACK TRACE oncomplete handlegamecalculation ===")
print(debug.traceback())
print("oncomplete")
____table:calculeWin()
if #player.hand.cards == 0 then
print("Calculando vitoria")
if player.matchPoints > opponent.matchPoints then
print("Jogador ganhou")
waitManager:clear()
gameState = GameState.CHOOSING_UPGRADE
upgradeDeck:generateNewUpgrades(UPGRADE_CARD_LIST)
upgradeDeck:setCardsCenterPosition(std.app.width, std.app.height)
else
print("Jogador perdeu")
waitManager:clear()
gameState = GameState.GAME_OVER
end
upgradeDeck:setCardsCenterPosition(std.app.width, std.app.height)
else
gameState = GameState.WAITING_PLAYER_INPUT
end
end,
onUpdate = function(____, progress)
print(("Calculando resultado: " .. tostring(math.floor(progress * 100 + 0.5))) .. "%")
end
})
end
GameState = GameState or ({})
GameState.WAITING_PLAYER_INPUT = 0
GameState[GameState.WAITING_PLAYER_INPUT] = "WAITING_PLAYER_INPUT"
GameState.PLAYER_TURN_ANIMATION = 1
GameState[GameState.PLAYER_TURN_ANIMATION] = "PLAYER_TURN_ANIMATION"
GameState.WAITING_ENEMY_TURN = 2
GameState[GameState.WAITING_ENEMY_TURN] = "WAITING_ENEMY_TURN"
GameState.ENEMY_TURN_ANIMATION = 3
GameState[GameState.ENEMY_TURN_ANIMATION] = "ENEMY_TURN_ANIMATION"
GameState.CALCULATING_RESULTS = 4
GameState[GameState.CALCULATING_RESULTS] = "CALCULATING_RESULTS"
GameState.GAME_OVER = 5
GameState[GameState.GAME_OVER] = "GAME_OVER"
GameState.CHOOSING_UPGRADE = 6
GameState[GameState.CHOOSING_UPGRADE] = "CHOOSING_UPGRADE"
upgradeDeck = __TS__New(UpgradeOffer)
gameState = GameState.WAITING_PLAYER_INPUT
local gameStateText = ""
waitManager = __TS__New(WaitManager)
player = __TS__New(Player)
local function handleGameStateText()
repeat
local ____switch3 = gameState
local ____cond3 = ____switch3 == GameState.WAITING_ENEMY_TURN
if ____cond3 then
gameStateText = "VEZ DO OPONENTE"
break
end
____cond3 = ____cond3 or ____switch3 == GameState.GAME_OVER
if ____cond3 then
gameStateText = "GAME OVER"
break
end
____cond3 = ____cond3 or ____switch3 == GameState.WAITING_PLAYER_INPUT
if ____cond3 then
gameStateText = "SUA VEZ"
break
end
____cond3 = ____cond3 or ____switch3 == GameState.CHOOSING_UPGRADE
if ____cond3 then
gameStateText = "ESCOLHA UM UPGRADE"
end
do
break
end
until true
end
local function handlePlayerCardSelection(std)
print("step1 handlePlayerCardSelection")
if gameState ~= GameState.WAITING_PLAYER_INPUT then
return
end
print("step2 handlePlayerCardSelection")
____table:setPlayerCard(player:getSelectedCard())
print("step3 handlePlayerCardSelection")
____table.lastOpponentCard = nil
print("step4 handlePlayerCardSelection")
gameState = GameState.PLAYER_TURN_ANIMATION
waitManager:addWait({
id = "player_card_animation",
duration = 0.5,
onComplete = function()
print("opponent turn")
gameState = GameState.WAITING_ENEMY_TURN
handleOpponentTurn()
end,
onUpdate = function(____, progress)
end
})
end
local function resetGame()
player.matchPoints = 0
opponent.matchPoints = 0
player.hand:generateNewHand(CARD_LIST)
player.hand:setCardsPosition(std.app.width, std.app.height)
opponent.hand:generateNewHand(CARD_LIST)
opponent:setCardsPosition(std.app.width, std.app.height)
end
local function handleChooseUpgradeCard()
print("handleChooseUpgradeCard")
gameState = GameState.CHOOSING_UPGRADE
upgradeDeck:generateNewUpgrades(UPGRADE_CARD_LIST)
end
opponent = __TS__New(Opponent, 80)
local pressed = false
____exports.meta = {title = "Your Awesome Game", author = "IntellectualAuthor", version = "1.0.0", description = "The best game in the world made in GlyEngine"}
local function init(std, game)
std = std
player.hand:generateNewHand(CARD_LIST)
player.hand:setCardsPosition(std.app.width, std.app.height)
opponent.hand:generateNewHand(CARD_LIST)
opponent:setCardsPosition(std.app.width, std.app.height)
handleChooseUpgradeCard()
____table = __TS__New(Table, std, player, opponent)
end
local function loop(std, game)
return __TS__AsyncAwaiter(function(____awaiter_resolve)
waitManager:update(std.delta / 1000)
handleGameStateText()
if gameState == GameState.GAME_OVER then
return ____awaiter_resolve(nil)
end
____table:tick(std.delta)
player.hand:updateState(std)
opponent.hand:updateState(std)
upgradeDeck:updateState(std)
if std.key.press.any then
pressed = true
else
pressed = false
end
end)
end
local doOnce = false
local function draw(std, game)
if doOnce == false then
std.media.video():src("bg.mp4"):resize(std.app.width, std.app.height):play()
upgradeDeck:setCardsCenterPosition(std.app.width, std.app.height)
doOnce = true
end
print(gameState)
if gameState == GameState.GAME_OVER then
std.draw.color(std.color.white)
std.text.font_size(50)
std.text.print(std.app.width / 2 - 30, std.app.height / 2 - 4, "Game Over")
return
end
repeat
local ____switch30 = gameState
local ____cond30 = ____switch30 == GameState.CHOOSING_UPGRADE
if ____cond30 then
upgradeDeck:drawHandCards(std)
break
end
do
____table:renderCurrentCard()
player.hand:drawHandCards(std)
opponent.hand:drawHandCards(std)
break
end
until true
std.draw.color(std.color.white)
std.text.font_size(14)
std.text.font_name("tiny.ttf")
printCurrentGameState(std, gameStateText)
printPlayerPoints(std, player)
printOpponentPoints(std, opponent)
end
local function key(std, key)
if gameState == GameState.GAME_OVER then
return
end
if gameState == GameState.WAITING_PLAYER_INPUT then
if std.key.press.left then
if not pressed then
print("pressed left")
player.hand:switchActiveCard(false)
end
end
if std.key.press.right then
if not pressed then
print("pressed right")
player.hand:switchActiveCard(true)
end
end
if std.key.press.a then
if not pressed then
print("pressed z")
handlePlayerCardSelection(std)
end
end
end
if gameState == GameState.CHOOSING_UPGRADE then
if std.key.press.left then
if not pressed then
print("pressed left")
upgradeDeck:switchActiveCard(false)
end
end
if std.key.press.right then
if not pressed then
print("pressed right")
upgradeDeck:switchActiveCard(true)
end
end
if std.key.press.a then
resetGame()
player:addUpgrade(upgradeDeck:getSelectedUpgrade())
gameState = GameState.WAITING_PLAYER_INPUT
end
end
end
local function exit(std, game)
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
game_src_game_entity_table_1d8f30 = function()
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
local function __TS__ArrayForEach(self, callbackFn, thisArg)
for i = 1, #self do
callbackFn(thisArg, self[i], i - 1, self)
end
end
local ____exports = {}
local ____card = game_src_game_entity_card_1e65b8()
local Card = ____card.Card
local ____vector2 = game_src_core_spatial_vector2_1dc6e8()
local Vector2 = ____vector2.Vector2
local ____upgradeEffects = game_src_game_upgrades_upgradeEffects_34a928()
local applyComboNaipes = ____upgradeEffects.applyComboNaipes
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
local instanceCard = self:createCardInstance(card)
local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth - 30, self.std.app.height / 2 - self.cardHeight + 30)
instanceCard.transform.position = position
self.lastPlayerCard = instanceCard
self.playerCardValue = self.lastPlayerCard.value
self.lastPlayerCard:up()
self.playerCardTexture = instanceCard.texture
__TS__ArrayUnshift(self.playerCardHistory, instanceCard)
self.player.hand:removeCardById(self:getPlayerCard().id)
end
function Table.prototype.setOpponentCard(self, card)
local instanceCard = self:createCardInstance(card)
local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth + 30, self.std.app.height / 2 - self.cardHeight - 30)
instanceCard.transform.position = position
self.lastOpponentCard = instanceCard
self.opponentCardValue = self.lastOpponentCard.value
self.opponentCardTexture = instanceCard.texture
__TS__ArrayUnshift(self.opponentCardHistory, instanceCard)
self.opponent.hand:removeCardById(self:getOpponentCard().id)
end
function Table.prototype.createCardInstance(self, card)
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
function Table.prototype.renderCurrentCard(self)
if self.lastOpponentCard then
self.lastOpponentCard:drawCard(self.std)
end
if self.lastPlayerCard then
self.lastPlayerCard:drawCard(self.std)
end
end
function Table.prototype.calculeWin(self)
print("calcule win")
if self.playerCardValue > self.opponentCardValue then
self.opponentHit = true
elseif self.playerCardValue == self.opponentCardValue then
self.playerHit = true
self.opponentHit = true
else
self.playerHit = true
end
end
function Table.prototype.applyUpgrades(self)
local upgrades = self.player.hand.upgrades
__TS__ArrayForEach(
upgrades,
function(____, upgrade)
repeat
local ____switch15 = upgrade.special_effect
local ____cond15 = ____switch15 == 1
if ____cond15 then
self.lastPlayerCard.value = applyComboNaipes(
self:getOpponentCardHistory(),
self.lastPlayerCard.value
)
break
end
____cond15 = ____cond15 or ____switch15 == 2
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 3
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 4
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 5
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 6
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 7
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 8
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 9
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 10
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 11
if ____cond15 then
break
end
____cond15 = ____cond15 or ____switch15 == 12
if ____cond15 then
break
end
until true
end
)
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
function Table.prototype.getPlayerCardHistory(self)
return self.playerCardHistory
end
function Table.prototype.getOpponentCardHistory(self)
return self.opponentCardHistory
end
function Table.prototype.hitPlayer(self, dt)
self.lastPlayerCard.texture = "card_damage.png"
if self.playerTimer <= 1 then
self.playerTimer = self.playerTimer + dt / 100
else
self.playerHit = false
self.playerTimer = 0
local ____self_opponent_0, ____matchPoints_1 = self.opponent, "matchPoints"
____self_opponent_0[____matchPoints_1] = ____self_opponent_0[____matchPoints_1] + 1
self.lastPlayerCard.texture = self.playerCardTexture
end
end
function Table.prototype.hitOpponent(self, dt)
self.lastOpponentCard.texture = "card_damage.png"
if self.opponentTimer <= 1 then
self.opponentTimer = self.opponentTimer + dt / 100
else
self.opponentHit = false
self.opponentTimer = 0
local ____self_player_2, ____matchPoints_3 = self.player, "matchPoints"
____self_player_2[____matchPoints_3] = ____self_player_2[____matchPoints_3] + 1
self.lastOpponentCard.texture = self.opponentCardTexture
end
end
function Table.prototype.tick(self, dt)
if self.playerHit then
self:hitPlayer(dt)
end
if self.opponentHit then
self:hitOpponent(dt)
end
end
return ____exports
end
--
game_src_game_cards_cardList_1c6278 = function()
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
game_src_game_player_player_10d510 = function()
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
local ____hand = game_src_game_player_hand_1a1d70()
local Hand = ____hand.Hand
____exports.Player = __TS__Class()
local Player = ____exports.Player
Player.name = "Player"
function Player.prototype.____constructor(self)
self.hand = __TS__New(Hand)
self.upgrades = {}
self.matchPoints = 0
end
function Player.prototype.getSelectedCard(self)
print(self.hand:getSelectedCard().name)
return self.hand:getSelectedCard()
end
function Player.prototype.addUpgrade(self, upgrade)
local ____self_upgrades_0 = self.upgrades
____self_upgrades_0[#____self_upgrades_0 + 1] = upgrade
end
return ____exports
end
--
game_src_core_utils_waitManager_23acb8 = function()
local function __TS__Class(self)
local c = {prototype = {}}
c.prototype.__index = c.prototype
c.prototype.constructor = c
return c
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
local __TS__Iterator
do
local function iteratorGeneratorStep(self)
local co = self.____coroutine
local status, value = coroutine.resume(co)
if not status then
error(value, 0)
end
if coroutine.status(co) == "dead" then
return
end
return true, value
end
local function iteratorIteratorStep(self)
local result = self:next()
if result.done then
return
end
return true, result.value
end
local function iteratorStringStep(self, index)
index = index + 1
if index > #self then
return
end
return index, string.sub(self, index, index)
end
function __TS__Iterator(iterable)
if type(iterable) == "string" then
return iteratorStringStep, iterable, 0
elseif iterable.____coroutine ~= nil then
return iteratorGeneratorStep, iterable
elseif iterable[Symbol.iterator] then
local iterator = iterable[Symbol.iterator](iterable)
return iteratorIteratorStep, iterator
else
return ipairs(iterable)
end
end
end
local Map
do
Map = __TS__Class()
Map.name = "Map"
function Map.prototype.____constructor(self, entries)
self[Symbol.toStringTag] = "Map"
self.items = {}
self.size = 0
self.nextKey = {}
self.previousKey = {}
if entries == nil then
return
end
local iterable = entries
if iterable[Symbol.iterator] then
local iterator = iterable[Symbol.iterator](iterable)
while true do
local result = iterator:next()
if result.done then
break
end
local value = result.value
self:set(value[1], value[2])
end
else
local array = entries
for ____, kvp in ipairs(array) do
self:set(kvp[1], kvp[2])
end
end
end
function Map.prototype.clear(self)
self.items = {}
self.nextKey = {}
self.previousKey = {}
self.firstKey = nil
self.lastKey = nil
self.size = 0
end
function Map.prototype.delete(self, key)
local contains = self:has(key)
if contains then
self.size = self.size - 1
local next = self.nextKey[key]
local previous = self.previousKey[key]
if next ~= nil and previous ~= nil then
self.nextKey[previous] = next
self.previousKey[next] = previous
elseif next ~= nil then
self.firstKey = next
self.previousKey[next] = nil
elseif previous ~= nil then
self.lastKey = previous
self.nextKey[previous] = nil
else
self.firstKey = nil
self.lastKey = nil
end
self.nextKey[key] = nil
self.previousKey[key] = nil
end
self.items[key] = nil
return contains
end
function Map.prototype.forEach(self, callback)
for ____, key in __TS__Iterator(self:keys()) do
callback(nil, self.items[key], key, self)
end
end
function Map.prototype.get(self, key)
return self.items[key]
end
function Map.prototype.has(self, key)
return self.nextKey[key] ~= nil or self.lastKey == key
end
function Map.prototype.set(self, key, value)
local isNewValue = not self:has(key)
if isNewValue then
self.size = self.size + 1
end
self.items[key] = value
if self.firstKey == nil then
self.firstKey = key
self.lastKey = key
elseif isNewValue then
self.nextKey[self.lastKey] = key
self.previousKey[key] = self.lastKey
self.lastKey = key
end
return self
end
Map.prototype[Symbol.iterator] = function(self)
return self:entries()
end
function Map.prototype.entries(self)
local items = self.items
local nextKey = self.nextKey
local key = self.firstKey
return {
[Symbol.iterator] = function(self)
return self
end,
next = function(self)
local result = {done = not key, value = {key, items[key]}}
key = nextKey[key]
return result
end
}
end
function Map.prototype.keys(self)
local nextKey = self.nextKey
local key = self.firstKey
return {
[Symbol.iterator] = function(self)
return self
end,
next = function(self)
local result = {done = not key, value = key}
key = nextKey[key]
return result
end
}
end
function Map.prototype.values(self)
local items = self.items
local nextKey = self.nextKey
local key = self.firstKey
return {
[Symbol.iterator] = function(self)
return self
end,
next = function(self)
local result = {done = not key, value = items[key]}
key = nextKey[key]
return result
end
}
end
Map[Symbol.species] = Map
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
____exports.WaitManager = __TS__Class()
local WaitManager = ____exports.WaitManager
WaitManager.name = "WaitManager"
function WaitManager.prototype.____constructor(self)
self.waitActions = __TS__New(Map)
end
function WaitManager.prototype.addWait(self, action)
self.waitActions:set(action.id, {timeLeft = action.duration, action = action})
end
function WaitManager.prototype.removeWait(self, id)
self.waitActions:delete(id)
end
function WaitManager.prototype.isWaiting(self, id)
return self.waitActions:has(id)
end
function WaitManager.prototype.isAnyWaiting(self)
return self.waitActions.size > 0
end
function WaitManager.prototype.update(self, dt)
local completedActions = {}
self.waitActions:forEach(function(____, waitData, id)
waitData.timeLeft = waitData.timeLeft - dt
local progress = 1 - (waitData.timeLeft - waitData.action.duration)
if waitData.action.onUpdate then
waitData.action:onUpdate(math.min(progress, 1))
end
if waitData.timeLeft <= 0 then
completedActions[#completedActions + 1] = id
end
__TS__ArrayForEach(
completedActions,
function(____, id)
local waitData = self.waitActions:get(id)
if waitData then
waitData.action:onComplete()
self.waitActions:delete(id)
end
end
)
end)
end
function WaitManager.prototype.getProgress(self, id)
local waitData = self.waitActions:get(id)
if not waitData then
return 0
end
return 1 - waitData.timeLeft / waitData.action.duration
end
function WaitManager.prototype.clear(self)
self.waitActions:clear()
end
return ____exports
end
--
game_src_game_upgrades_upgradeOffer_10d4e8 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1dc6e8()
local Vector2 = ____vector2.Vector2
local ____upgradeCard = game_src_game_upgrades_upgradeCard_1c63b0()
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
end
--
game_src_game_upgrades_upgradeList_1d7628 = function()
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
game_src_core_ui_ui_1dcf30 = function()
local ____exports = {}
function ____exports.printPlayerPoints(std, player)
std.text.print(
20,
40,
"Seus pontos: " .. tostring(player.matchPoints)
)
end
function ____exports.printOpponentPoints(std, opponent)
std.text.print(
std.app.width - #tostring(opponent.matchPoints) * 3 - 120,
40,
"Pontos do Oponente: " .. tostring(opponent.matchPoints)
)
end
function ____exports.printCurrentGameState(std, gameStateText)
std.text.print(std.app.width / 2 - #gameStateText * 3, 20, gameStateText)
end
return ____exports
end
--
game_src_game_opponent_opponent_1df618 = function()
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
local ____exports = {}
local ____vector2 = game_src_core_spatial_vector2_1dc6e8()
local Vector2 = ____vector2.Vector2
local ____hand = game_src_game_player_hand_1a1d70()
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
end
--
game_src_game_entity_card_1e65b8 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1dc6e8()
local Vector2 = ____vector2.Vector2
local ____gameObject = game_src_game_entity_gameObject_1c2728()
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
print(time)
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
game_src_core_spatial_vector2_1dc6e8 = function()
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
game_src_game_upgrades_upgradeEffects_34a928 = function()
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
function ____exports.applyComboNaipes(cardHistory, value)
local cardType = __TS__StringSplit(cardHistory[1].id, "_")[1]
local quant = 0
do
local i = 0
while i < #cardHistory do
local card = cardHistory[i + 1]
if __TS__StringSplit(card.id, "_")[1] == cardType then
quant = quant + 1
end
if i >= 3 then
break
end
i = i + 1
end
end
if quant >= 3 then
return value * 3
end
end
return ____exports
end
--
game_src_game_player_hand_1a1d70 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1dc6e8()
local Vector2 = ____vector2.Vector2
local ____card = game_src_game_entity_card_1e65b8()
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
game_src_game_upgrades_upgradeCard_1c63b0 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1dc6e8()
local Vector2 = ____vector2.Vector2
local ____gameObject = game_src_game_entity_gameObject_1c2728()
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
game_src_game_entity_gameObject_1c2728 = function()
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
local ____transform = game_src_core_spatial_transform_1cc088()
local Transform = ____transform.Transform
local ____animationController = game_src_core_animation_animationController_1dc7d0()
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
game_src_core_spatial_transform_1cc088 = function()
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
game_src_core_animation_animationController_1dc7d0 = function()
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
return main_23d6f0()
