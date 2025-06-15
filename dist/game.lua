local function main_1c5c28()
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
local function __TS__ArrayForEach(self, callbackFn, thisArg)
for i = 1, #self do
callbackFn(thisArg, self[i], i - 1, self)
end
end
local ____exports = {}
local AnimationController
____exports.title = "Gly Engine Gamejam"
____exports.author = "Alex Oliveira"
____exports.version = "1.0.0"
____exports.description = "The best game in the world made in GlyEngine"
____exports.assets = {"src/card1.png:card1.png", "src/card2.png:card2.png", "src/card3.png:card3.png", "src/card4.png:card4.png"}
local CARD_LIST = {{id = "emperor", name = "Emperor", texture = "card1.png"}, {id = "high_priestess", name = "High Priestess", texture = "card2.png"}, {id = "sun", name = "Sun", texture = "card3.png"}, {id = "magician", name = "Magician", texture = "card4.png"}}
local Vector2 = __TS__Class()
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
local GameObject = __TS__Class()
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
self.animator:update(dt)
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
self.obj.transform.position.x = self.startPosition.x + (self.endPosition.x - self.startPosition.x) * easedT
self.obj.transform.position.y = self.startPosition.y + (self.endPosition.y - self.startPosition.y) * easedT
if easedT >= 1 then
self.active = false
self.obj.transform.position.x = self.endPosition.x
self.obj.transform.position.y = self.endPosition.y
end
end
local Card = __TS__Class()
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
end
function Card.prototype.up(self)
self:start({x = self.transform.position.x, y = self.transform.position.y - 50}, 0.5)
self.isUp = true
end
function Card.prototype.down(self)
if not self.isUp then
return
end
self:start({x = self.transform.position.x, y = self.transform.position.y + 50}, 0.5)
self.isUp = false
end
function Card.prototype.drawCard(self, std)
std.draw.image(self.texture, self.transform.position.x, self.transform.position.y)
end
local Hand = __TS__Class()
Hand.name = "Hand"
function Hand.prototype.____constructor(self)
self.cards = {}
self.selectedCard = 0
end
function Hand.prototype.generateNewHand(self)
print("# Generating New Hand #")
local newCard = nil
do
local i = 0
while i < 3 do
newCard = self:getNewCard()
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
local reserveCard = self:getNewCard()
while newCard.id == reserveCard.id do
reserveCard = self:getNewCard()
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
function Hand.prototype.getNewCard(self)
print("Generating Card...")
return __TS__New(
Card,
CARD_LIST[math.floor(math.random() * #CARD_LIST) + 1]
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
local newPosition = __TS__New(Vector2, 0, 0)
local spacing = 50
local cardWidth = 126
local cardHeight = 186
local totalWidth = #self.cards * spacing + (#self.cards - 1) * cardWidth
local x = (screenWidth - totalWidth) / 2
__TS__ArrayForEach(
self.cards,
function(____, card)
card.transform.position = __TS__New(Vector2, x, screenHeight - cardHeight - spacing)
x = x + 160
end
)
end
local hand = __TS__New(Hand)
local function init(std, game)
hand:generateNewHand()
hand:setCardsPosition(game.width, game.height)
end
local function loop(std, game)
hand:updateState(std)
end
local function draw(std, game)
std.draw.clear(std.color.black)
hand:drawHandCards(std)
end
local function exit(std, game)
end
____exports.init = init
____exports.loop = loop
____exports.draw = draw
____exports.exit = exit
return ____exports
end
return main_1c5c28()
