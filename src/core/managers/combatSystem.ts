import { Card } from "../../game/entities/card";
import { Opponent } from "../../game/entities/Opponent";
import { Player } from "../../game/entities/Player";
import { applyComboNaipes } from "../../game/upgrades/upgradeEffects";
import { createCardInstance } from "../../game/utils/CardFactory";

export class CombatSystem {
  private player: Player;
  private opponent: Opponent;

  constructor(player: Player, opponent: Opponent) {
    this.player = player;
    this.opponent = opponent;
  }

  applyUpgrades() {
    const upgrades = this.player.hand.upgrades;
    upgrades.forEach((upgrade) => {
      switch (upgrade.special_effect) {
        case 1:
          this.player.getLastCard().value = applyComboNaipes(
            this.player.getCardHistory(),
            this.player.getLastCard().value
          );
          break;
        case 2:
          //applyCartaMarcada();
          break;
        case 3:
          //applyBaralhoEnsanguentado();
          break;
        case 4:
          //applyEcoInverso();
          break;
        case 5:
          //applyPrestigioAntigo();
          break;
        case 6:
          //applyNaipeCoringa();
          break;
        case 7:
          //applyPressagioDerrota();
          break;
        case 8:
          //applyCoracaoFrio();
          break;
        case 9:
          //applyRitualDeTres();
          break;
        case 10:
          //applyOrdemImplacavel();
          break;
        case 11:
          //applyFalhaControlada();
          break;
        case 12:
          //applyAuraInflexivel();
          break;
      }
    });
  }
}
