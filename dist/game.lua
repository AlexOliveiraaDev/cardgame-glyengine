local game_src_game_entity_table_1c6700 = nil
local game_src_game_enemy_enemy_1c6fa0 = nil
local game_src_game_cards_cardList_1d5d98 = nil
local game_src_game_player_player_157aa8 = nil
local game_src_core_utils_waitManager_1d78c8 = nil
local game_src_game_upgrades_upgradeOffer_1d7e30 = nil
local game_src_game_upgrades_upgradeList_20d2b0 = nil
local game_src_game_entity_card_1e2c68 = nil
local game_src_core_spatial_vector2_1c99d0 = nil
local game_src_game_upgrades_upgradeEffects_32b978 = nil
local game_src_game_player_hand_1c0718 = nil
local game_src_game_upgrades_upgradeCard_1c3530 = nil
local game_src_game_entity_gameObject_1c1388 = nil
local game_src_core_spatial_transform_1ad398 = nil
local game_src_core_animation_animationController_1c2a90 = nil
local function main_20d510()
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
local handleEnemyTurn, handleGameCalculation, GameState, gameState, waitManager, opponent, ____table
local ____table = game_src_game_entity_table_1c6700()
local Table = ____table.Table
local ____enemy = game_src_game_enemy_enemy_1c6fa0()
local Enemy = ____enemy.Enemy
local ____cardList = game_src_game_cards_cardList_1d5d98()
local CARD_LIST = ____cardList.CARD_LIST
local ____player = game_src_game_player_player_157aa8()
local Player = ____player.Player
local ____waitManager = game_src_core_utils_waitManager_1d78c8()
local WaitManager = ____waitManager.WaitManager
local ____upgradeOffer = game_src_game_upgrades_upgradeOffer_1d7e30()
local UpgradeOffer = ____upgradeOffer.UpgradeOffer
local ____upgradeList = game_src_game_upgrades_upgradeList_20d2b0()
local UPGRADE_CARD_LIST = ____upgradeList.UPGRADE_CARD_LIST
function handleEnemyTurn()
if gameState ~= GameState.WAITING_ENEMY_TURN then
return
end
gameState = GameState.ENEMY_TURN_ANIMATION
waitManager:addWait({
id = "enemy_thinking",
duration = 0.5,
onComplete = function()
local enemySelectedCard = opponent:getBestCard(____table:getPlayerCard())
print(enemySelectedCard.name)
____table:setOpponentCard(enemySelectedCard)
waitManager:addWait({
id = "enemy_card_animation",
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
print(waitManager:isAnyWaiting())
gameState = GameState.CALCULATING_RESULTS
waitManager:addWait({
id = "calculating_results",
duration = 0.5,
onComplete = function()
____table:calculeWin()
gameState = GameState.WAITING_PLAYER_INPUT
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
local upgradeDeck = __TS__New(UpgradeOffer)
gameState = GameState.WAITING_PLAYER_INPUT
local gameStateText = ""
waitManager = __TS__New(WaitManager)
local player = __TS__New(Player)
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
if gameState ~= GameState.WAITING_PLAYER_INPUT then
return
end
____table:setPlayerCard(player:getSelectedCard())
____table.lastOpponentCard = nil
gameState = GameState.PLAYER_TURN_ANIMATION
waitManager:addWait({
id = "player_card_animation",
duration = 0.5,
onComplete = function()
gameState = GameState.WAITING_ENEMY_TURN
handleEnemyTurn()
end,
onUpdate = function(____, progress)
end
})
end
local function handleChooseUpgradeCard()
gameState = GameState.CHOOSING_UPGRADE
upgradeDeck:generateNewUpgrades(UPGRADE_CARD_LIST)
end
opponent = __TS__New(Enemy)
local pressed = false
____exports.meta = {title = "Your Awesome Game", author = "IntellectualAuthor", version = "1.0.0", description = "The best game in the world made in GlyEngine"}
local function init(std, game)
player.hand:generateNewHand(CARD_LIST)
player.hand:setCardsPosition(std.app.width, std.app.height)
opponent.hand:generateNewHand(CARD_LIST)
handleChooseUpgradeCard()
____table = __TS__New(Table, std, player)
end
local function loop(std, game)
return __TS__AsyncAwaiter(function(____awaiter_resolve)
handleGameStateText()
waitManager:update(std.delta / 1000)
____table:tick(std.delta)
player.hand:updateState(std)
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
if gameState == GameState.CHOOSING_UPGRADE then
upgradeDeck:drawHandCards(std)
else
____table:renderCurrentCard()
player.hand:drawHandCards(std)
end
std.draw.color(std.color.white)
std.text.font_size(14)
std.text.font_name("tiny.ttf")
std.text.print(std.app.width / 2 - #gameStateText * 3, 20, gameStateText)
std.text.print(
std.app.width / 2 - #gameStateText * 3,
40,
"Valor carta: " .. tostring(____table.playerCardValue)
)
end
local function key(std, key)
if GameState.WAITING_PLAYER_INPUT then
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
if GameState.CHOOSING_UPGRADE then
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
game_src_game_entity_table_1c6700 = function()
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
local ____card = game_src_game_entity_card_1e2c68()
local Card = ____card.Card
local ____vector2 = game_src_core_spatial_vector2_1c99d0()
local Vector2 = ____vector2.Vector2
local ____upgradeEffects = game_src_game_upgrades_upgradeEffects_32b978()
local applyComboNaipes = ____upgradeEffects.applyComboNaipes
____exports.Table = __TS__Class()
local Table = ____exports.Table
Table.name = "Table"
function Table.prototype.____constructor(self, std, player)
self.cardWidth = 30
self.cardHeight = 120
self.playerHit = false
self.enemyHit = false
self.timer = 0
self.playerCardTexture = ""
self.enemyCardTexture = ""
self.std = std
self.player = player
end
function Table.prototype.setPlayerCard(self, card)
local instanceCard = self:createCardInstance(card)
local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth - 30, self.std.app.height / 2 - self.cardHeight + 30)
instanceCard.transform.position = position
self.lastPlayerCard = instanceCard
self.lastPlayerCard:up()
self.playerCardTexture = instanceCard.texture
__TS__ArrayUnshift(self.playerCardHistory, instanceCard)
end
function Table.prototype.setOpponentCard(self, card)
local instanceCard = self:createCardInstance(card)
local position = __TS__New(Vector2, self.std.app.width / 2 - self.cardWidth + 30, self.std.app.height / 2 - self.cardHeight - 30)
instanceCard.transform.position = position
self.lastOpponentCard = instanceCard
self.enemyCardTexture = instanceCard.texture
__TS__ArrayUnshift(self.opponentCardHistory, instanceCard)
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
local playerWin = self.lastPlayerCard.value > self.lastOpponentCard.value
if playerWin then
self.enemyHit = true
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
local ____switch14 = upgrade.special_effect
local ____cond14 = ____switch14 == 1
if ____cond14 then
self.playerCardValue = applyComboNaipes(
self:getOpponentCardHistory(),
self.playerCardValue
)
break
end
____cond14 = ____cond14 or ____switch14 == 2
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 3
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 4
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 5
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 6
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 7
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 8
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 9
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 10
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 11
if ____cond14 then
break
end
____cond14 = ____cond14 or ____switch14 == 12
if ____cond14 then
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
function Table.prototype.tick(self, dt)
if self.lastPlayerCard then
print(self.lastPlayerCard.texture)
end
if self.playerHit then
self.lastPlayerCard.texture = "card_damage.png"
if self.timer <= 1 then
self.timer = self.timer + dt / 100
else
self.playerHit = false
self.timer = 0
self.lastPlayerCard.texture = self.playerCardTexture
end
end
if self.enemyHit then
self.lastOpponentCard.texture = "card_damage.png"
if self.timer <= 1 then
self.timer = self.timer + dt / 100
else
self.enemyHit = false
self.timer = 0
self.lastOpponentCard.texture = self.enemyCardTexture
end
end
end
return ____exports
end
--
game_src_game_enemy_enemy_1c6fa0 = function()
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
local ____exports = {}
local ____hand = game_src_game_player_hand_1c0718()
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
end
--
game_src_game_cards_cardList_1d5d98 = function()
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
game_src_game_player_player_157aa8 = function()
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
local ____hand = game_src_game_player_hand_1c0718()
local Hand = ____hand.Hand
____exports.Player = __TS__Class()
local Player = ____exports.Player
Player.name = "Player"
function Player.prototype.____constructor(self)
self.hand = __TS__New(Hand)
self.upgrades = {}
end
function Player.prototype.getSelectedCard(self)
return self.hand:getSelectedCard()
end
function Player.prototype.addUpgrade(self, upgrade)
local ____self_upgrades_0 = self.upgrades
____self_upgrades_0[#____self_upgrades_0 + 1] = upgrade
end
return ____exports
end
--
game_src_core_utils_waitManager_1d78c8 = function()
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
game_src_game_upgrades_upgradeOffer_1d7e30 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1c99d0()
local Vector2 = ____vector2.Vector2
local ____upgradeCard = game_src_game_upgrades_upgradeCard_1c3530()
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
game_src_game_upgrades_upgradeList_20d2b0 = function()
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
game_src_game_entity_card_1e2c68 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1c99d0()
local Vector2 = ____vector2.Vector2
local ____gameObject = game_src_game_entity_gameObject_1c1388()
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
game_src_core_spatial_vector2_1c99d0 = function()
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
game_src_game_upgrades_upgradeEffects_32b978 = function()
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
game_src_game_player_hand_1c0718 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1c99d0()
local Vector2 = ____vector2.Vector2
local ____card = game_src_game_entity_card_1e2c68()
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
function Hand.prototype.use(self)
end
return ____exports
end
--
game_src_game_upgrades_upgradeCard_1c3530 = function()
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
local ____vector2 = game_src_core_spatial_vector2_1c99d0()
local Vector2 = ____vector2.Vector2
local ____gameObject = game_src_game_entity_gameObject_1c1388()
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
game_src_game_entity_gameObject_1c1388 = function()
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
local ____transform = game_src_core_spatial_transform_1ad398()
local Transform = ____transform.Transform
local ____animationController = game_src_core_animation_animationController_1c2a90()
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
game_src_core_spatial_transform_1ad398 = function()
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
game_src_core_animation_animationController_1c2a90 = function()
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
return main_20d510()
