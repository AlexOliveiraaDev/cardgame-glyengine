-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
local ____exports = {}
local ____card = require("src.game.entities.card")
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
