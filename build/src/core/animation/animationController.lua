-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end
-- End of Lua Library inline imports
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
