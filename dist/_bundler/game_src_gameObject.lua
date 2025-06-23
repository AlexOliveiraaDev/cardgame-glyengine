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
-- End of Lua Library inline imports
local ____exports = {}
local AnimationController
____exports.Vector2 = __TS__Class()
local Vector2 = ____exports.Vector2
Vector2.name = "Vector2"
function Vector2.prototype.____constructor(self, x, y)
    self.x = x
    self.y = y
end
local Transform = __TS__Class()
Transform.name = "Transform"
function Transform.prototype.____constructor(self, position, scale)
    self.position = position
    self.scale = scale
end
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
AnimationController = __TS__Class()
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
