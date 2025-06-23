import { GlyStd } from "@gamely/gly-types";
import { Player } from "../../game/player/player";
import { Opponent } from "../../game/opponent/opponent";

export function printPlayerPoints(std: GlyStd, player: Player) {
  std.text.print(20, 40, "Seus pontos: " + player.matchPoints);
}

export function printOpponentPoints(std: GlyStd, opponent: Opponent) {
  std.text.print(
    std.app.width - opponent.matchPoints.toString().length * 3 - 120,
    40,
    "Pontos do Oponente: " + opponent.matchPoints
  );
}

export function printCurrentGameState(std, gameStateText: string) {
  std.text.print(std.app.width / 2 - gameStateText.length * 3, 20, gameStateText);
}
