-- Lua Library inline imports
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
-- End of Lua Library inline imports
local ____exports = {}
local handleOpponentTurn, handleGameCalculation, GameState, upgradeDeck, gameState, waitManager, player, std, opponent, ____table
local ____table = require('game_src_game_entity_table')
local Table = ____table.Table
local ____cardList = require('game_src_game_cards_cardList')
local CARD_LIST = ____cardList.CARD_LIST
local ____player = require('game_src_game_player_player')
local Player = ____player.Player
local ____waitManager = require('game_src_core_utils_waitManager')
local WaitManager = ____waitManager.WaitManager
local ____upgradeOffer = require('game_src_game_upgrades_upgradeOffer')
local UpgradeOffer = ____upgradeOffer.UpgradeOffer
local ____upgradeList = require('game_src_game_upgrades_upgradeList')
local UPGRADE_CARD_LIST = ____upgradeList.UPGRADE_CARD_LIST
local ____ui = require('game_src_core_ui_ui')
local printCurrentGameState = ____ui.printCurrentGameState
local printOpponentPoints = ____ui.printOpponentPoints
local printPlayerPoints = ____ui.printPlayerPoints
local ____opponent = require('game_src_game_opponent_opponent')
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
