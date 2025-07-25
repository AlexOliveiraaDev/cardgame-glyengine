-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
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

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
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
-- End of Lua Library inline imports
local ____exports = {}
____exports.GameState = GameState or ({})
____exports.GameState.WAITING_PLAYER_TURN = 0
____exports.GameState[____exports.GameState.WAITING_PLAYER_TURN] = "WAITING_PLAYER_TURN"
____exports.GameState.WAITING_OPPONENT_TURN = 1
____exports.GameState[____exports.GameState.WAITING_OPPONENT_TURN] = "WAITING_OPPONENT_TURN"
____exports.GameState.PLAYER_TURN_ANIMATION = 2
____exports.GameState[____exports.GameState.PLAYER_TURN_ANIMATION] = "PLAYER_TURN_ANIMATION"
____exports.GameState.OPPONENT_TURN_ANIMATION = 3
____exports.GameState[____exports.GameState.OPPONENT_TURN_ANIMATION] = "OPPONENT_TURN_ANIMATION"
____exports.GameState.CALCULATING_RESULTS = 4
____exports.GameState[____exports.GameState.CALCULATING_RESULTS] = "CALCULATING_RESULTS"
____exports.GameState.CHOOSING_UPGRADE = 5
____exports.GameState[____exports.GameState.CHOOSING_UPGRADE] = "CHOOSING_UPGRADE"
____exports.GameState.GAME_OVER = 6
____exports.GameState[____exports.GameState.GAME_OVER] = "GAME_OVER"
____exports.GameState.GAME_MENU = 7
____exports.GameState[____exports.GameState.GAME_MENU] = "GAME_MENU"
____exports.StateManager = __TS__Class()
local StateManager = ____exports.StateManager
StateManager.name = "StateManager"
function StateManager.prototype.____constructor(self)
    self.stateMap = {
        player_turn = ____exports.GameState.WAITING_PLAYER_TURN,
        opponent_turn = ____exports.GameState.WAITING_OPPONENT_TURN,
        player_animation = ____exports.GameState.PLAYER_TURN_ANIMATION,
        opponent_animation = ____exports.GameState.OPPONENT_TURN_ANIMATION,
        calculating = ____exports.GameState.CALCULATING_RESULTS,
        upgrade = ____exports.GameState.CHOOSING_UPGRADE,
        game_over = ____exports.GameState.GAME_OVER,
        game_menu = ____exports.GameState.GAME_MENU
    }
end
function StateManager.prototype.getCurrentState(self)
    return self.currentState
end
function StateManager.prototype.setState(self, state)
    local mapped = self.stateMap[state]
    if mapped == nil then
        error(
            __TS__New(Error, "State Inválido"),
            0
        )
    end
    self.currentState = mapped
end
function StateManager.prototype.getTextState(self)
    repeat
        local ____switch7 = self.currentState
        local ____cond7 = ____switch7 == ____exports.GameState.WAITING_OPPONENT_TURN
        if ____cond7 then
            return "VEZ DO OPONENTE"
        end
        ____cond7 = ____cond7 or ____switch7 == ____exports.GameState.GAME_OVER
        if ____cond7 then
            return "GAME OVER"
        end
        ____cond7 = ____cond7 or ____switch7 == ____exports.GameState.WAITING_PLAYER_TURN
        if ____cond7 then
            return "SUA VEZ"
        end
        ____cond7 = ____cond7 or ____switch7 == ____exports.GameState.CHOOSING_UPGRADE
        if ____cond7 then
            return "ESCOLHA UM UPGRADE"
        end
    until true
end
return ____exports
