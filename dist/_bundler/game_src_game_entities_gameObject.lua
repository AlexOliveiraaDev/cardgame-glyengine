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
local ____transform = require('game_src_core_spatial_transform')
local Transform = ____transform.Transform
local ____animationController = require('game_src_core_animation_animationController')
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
