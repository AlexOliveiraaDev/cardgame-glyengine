local ____exports = {}
function ____exports.printPlayerPoints(std, player)
    std.text.print(
        20,
        40,
        "Seus pontos: " .. tostring(player.matchPoints)
    )
end
function ____exports.printOpponentPoints(std, opponent)
    std.text.print(
        std.app.width - #tostring(opponent.matchPoints) * 3 - 120,
        40,
        "Pontos do Oponente: " .. tostring(opponent.matchPoints)
    )
end
function ____exports.printCurrentGameState(std, gameStateText)
    std.text.print(std.app.width / 2 - #gameStateText * 3, 20, gameStateText)
end
return ____exports
