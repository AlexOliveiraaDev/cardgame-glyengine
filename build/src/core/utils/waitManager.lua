-- Lua Library inline imports
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
-- End of Lua Library inline imports
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
