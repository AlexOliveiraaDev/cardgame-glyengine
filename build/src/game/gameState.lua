-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end
-- End of Lua Library inline imports
local ____exports = {}
____exports.GameState = GameState or ({})
____exports.GameState.WAITING_PLAYER_INPUT = 0
____exports.GameState[____exports.GameState.WAITING_PLAYER_INPUT] = "WAITING_PLAYER_INPUT"
____exports.GameState.PLAYER_TURN_ANIMATION = 1
____exports.GameState[____exports.GameState.PLAYER_TURN_ANIMATION] = "PLAYER_TURN_ANIMATION"
____exports.GameState.WAITING_ENEMY_TURN = 2
____exports.GameState[____exports.GameState.WAITING_ENEMY_TURN] = "WAITING_ENEMY_TURN"
____exports.GameState.ENEMY_TURN_ANIMATION = 3
____exports.GameState[____exports.GameState.ENEMY_TURN_ANIMATION] = "ENEMY_TURN_ANIMATION"
____exports.GameState.CALCULATING_RESULTS = 4
____exports.GameState[____exports.GameState.CALCULATING_RESULTS] = "CALCULATING_RESULTS"
____exports.GameState.GAME_OVER = 5
____exports.GameState[____exports.GameState.GAME_OVER] = "GAME_OVER"
____exports.GameState.CHOOSING_UPGRADE = 6
____exports.GameState[____exports.GameState.CHOOSING_UPGRADE] = "CHOOSING_UPGRADE"
____exports.GameStateManager = __TS__Class()
local GameStateManager = ____exports.GameStateManager
GameStateManager.name = "GameStateManager"
function GameStateManager.prototype.____constructor(self)
end
return ____exports
