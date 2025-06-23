import { GlyStd } from "@gamely/gly-types";
import { Card, CardDefinition } from "./card";
import { Vector2 } from "../../core/spatial/vector2";
import { Player } from "../player/player";
import { applyComboNaipes } from "../upgrades/upgradeEffects";
import { Opponent } from "../opponent/opponent";

export class Table {
  lastOpponentCard: Card;
  lastPlayerCard: Card;
  playerCardHistory: Card[] = [];
  opponentCardHistory: Card[] = [];
  currentCard: Card;
  std: GlyStd;
  player: Player;
  opponent: Opponent;

  cardWidth = 30;
  cardHeight = 120;
  playerHit = false;
  opponentHit = false;
  playerTimer = 0;
  opponentTimer = 0;

  playerCardTexture = "";
  opponentCardTexture = "";

  playerCardValue: number = 0;
  opponentCardValue: number = 0;

  constructor(std: GlyStd, player: Player, opponent: Opponent) {
    this.std = std;
    this.player = player;
    this.opponent = opponent;
  }

  setPlayerCard(card: Card) {
    const instanceCard = this.createCardInstance(card);
    const position = new Vector2(
      this.std.app.width / 2 - this.cardWidth - 30,
      this.std.app.height / 2 - this.cardHeight + 30
    );
    instanceCard.transform.position = position;
    this.lastPlayerCard = instanceCard;
    this.playerCardValue = this.lastPlayerCard.value;
    this.lastPlayerCard.up();
    this.playerCardTexture = instanceCard.texture;
    this.playerCardHistory.unshift(instanceCard);
    this.player.hand.removeCardById(this.getPlayerCard().id);
  }

  setOpponentCard(card: Card) {
    const instanceCard = this.createCardInstance(card);
    const position = new Vector2(
      this.std.app.width / 2 - this.cardWidth + 30,
      this.std.app.height / 2 - this.cardHeight - 30
    );
    instanceCard.transform.position = position;
    this.lastOpponentCard = instanceCard;
    this.opponentCardValue = this.lastOpponentCard.value;
    this.opponentCardTexture = instanceCard.texture;
    this.opponentCardHistory.unshift(instanceCard);
    this.opponent.hand.removeCardById(this.getOpponentCard().id);
  }

  createCardInstance(card: Card) {
    const cardInfo: CardDefinition = {
      id: card.id,
      name: card.name,
      texture: card.texture,
      value: card.value,
      is_special: card.is_special,
      special_effect: card.special_effect,
    };
    return new Card(cardInfo);
  }

  renderCurrentCard() {
    if (this.lastOpponentCard) {
      this.lastOpponentCard.drawCard(this.std);
    }
    if (this.lastPlayerCard) {
      this.lastPlayerCard.drawCard(this.std);
    }
  }

  calculeWin() {
    console.log("calcule win");

    if (this.playerCardValue > this.opponentCardValue) {
      this.opponentHit = true;
    } else if (this.playerCardValue === this.opponentCardValue) {
      this.playerHit = true;
      this.opponentHit = true;
    } else this.playerHit = true;
  }

  applyUpgrades() {
    const upgrades = this.player.hand.upgrades;
    upgrades.forEach((upgrade) => {
      switch (upgrade.special_effect) {
        case 1:
          this.lastPlayerCard.value = applyComboNaipes(this.getOpponentCardHistory(), this.lastPlayerCard.value);
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

  getPlayerCard() {
    if (this.lastPlayerCard) return this.lastPlayerCard;
  }

  getOpponentCard() {
    if (this.lastOpponentCard) return this.lastOpponentCard;
  }

  getPlayerCardHistory() {
    return this.playerCardHistory;
  }

  getOpponentCardHistory() {
    return this.opponentCardHistory;
  }

  hitPlayer(dt: number) {
    this.lastPlayerCard.texture = "card_damage.png";
    if (this.playerTimer <= 1) {
      this.playerTimer += dt / 100;
    } else {
      this.playerHit = false;
      this.playerTimer = 0;
      this.opponent.matchPoints++;

      this.lastPlayerCard.texture = this.playerCardTexture;
    }
  }

  hitOpponent(dt: number) {
    this.lastOpponentCard.texture = "card_damage.png";
    if (this.opponentTimer <= 1) {
      this.opponentTimer += dt / 100;
    } else {
      this.opponentHit = false;
      this.opponentTimer = 0;
      this.player.matchPoints++;
      this.lastOpponentCard.texture = this.opponentCardTexture;
    }
  }

  tick(dt) {
    if (this.playerHit) {
      this.hitPlayer(dt);
    }

    if (this.opponentHit) {
      this.hitOpponent(dt);
    }
  }
}
