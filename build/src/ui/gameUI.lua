-- Lua Library inline imports
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
local ____exports = {}
function ____exports.printCurrentGameState(std, gameStateText)
    local x = std.app.width / 2 - #gameStateText * 4
    local y = 50
    std.draw.color(std.color.white)
    std.text.font_size(18)
    std.text.print(x, y, gameStateText)
end
function ____exports.printPlayerPoints(std, player)
    local text = ("Player: " .. tostring(player:getMatchPoints())) .. " pontos"
    local x = 20
    local y = std.app.height - 80
    std.draw.color(6553779)
    std.draw.rect(
        0,
        x - 5,
        y - 5,
        #text * 7 + 10,
        20
    )
    std.draw.color(std.color.white)
    std.text.font_size(12)
    std.text.print(x, y, text)
    local cardsText = "Cartas: " .. tostring(#player:getHandCards())
    std.text.print(x, y + 25, cardsText)
end
function ____exports.printOpponentPoints(std, opponent)
    local text = ("Opponent: " .. tostring(opponent.matchPoints)) .. " pontos"
    local x = std.app.width - #text * 7 - 20
    local y = std.app.height - 80
    std.draw.color(1677721779)
    std.draw.rect(
        0,
        x - 5,
        y - 5,
        #text * 7 + 10,
        20
    )
    std.draw.color(std.color.white)
    std.text.font_size(12)
    std.text.print(x, y, text)
    local cardsText = "Cartas: " .. tostring(#opponent.hand:getAllCards())
    std.text.print(x, y + 25, cardsText)
end
function ____exports.printUpgradeInfo(std, upgrades)
    if #upgrades == 0 then
        return
    end
    local x = 20
    local y = 100
    std.draw.color(4294967295)
    std.text.font_size(14)
    std.text.print(x, y, "Upgrades Ativos:")
    __TS__ArrayForEach(
        upgrades,
        function(____, upgrade, index)
            local upgradeY = y + 20 + index * 15
            std.text.font_size(10)
            std.text.print(
                x + 10,
                upgradeY,
                "• " .. tostring(upgrade.name)
            )
        end
    )
end
function ____exports.printControls(std)
    local controls = {"← → : Navegar", "A/Enter : Selecionar", "R : Reset (Debug)"}
    local x = std.app.width - 150
    local y = 20
    std.draw.color(204)
    std.draw.rect(
        0,
        x - 10,
        y - 5,
        160,
        #controls * 15 + 10
    )
    std.draw.color(4294967295)
    std.text.font_size(10)
    __TS__ArrayForEach(
        controls,
        function(____, control, index)
            std.text.print(x, y + index * 15, control)
        end
    )
end
function ____exports.printCardInfo(std, card, x, y)
    if not card then
        return
    end
    local info = {
        "Nome: " .. tostring(card.name),
        "Valor: " .. tostring(card.value),
        card.is_special and "Especial: Sim" or "Especial: Não"
    }
    std.draw.color(230)
    std.draw.rect(
        0,
        x - 5,
        y - 5,
        120,
        #info * 12 + 10
    )
    std.draw.color(4294967295)
    std.text.font_size(9)
    __TS__ArrayForEach(
        info,
        function(____, text, index)
            std.text.print(x, y + index * 12, text)
        end
    )
end
return ____exports
