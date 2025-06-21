import { GlyStd } from "@gamely/gly-types";
import { Card, CardDefinition } from "./card";
import { Vector2 } from "../../core/spatial/vector2";
import { Player } from "../player/player";
import { applyComboNaipes } from "../upgrades/upgradeEffects";

export class Table {
  lastOpponentCard: Card;
  lastPlayerCard: Card;
  playerCardHistory: Card[];
  opponentCardHistory: Card[];
  currentCard: Card;
  std: GlyStd;
  player: Player;

  cardWidth = 30;
  cardHeight = 120;
  playerHit = false;
  enemyHit = false;
  timer = 0;

  playerCardTexture = "";
  enemyCardTexture = "";

  playerCardValue: number;
  opponentCardValue: number;

  constructor(std: GlyStd, player: Player) {
    this.std = std;
    this.player = player;
  }

  setPlayerCard(card: Card) {
    const instanceCard = this.createCardInstance(card);
    const position = new Vector2(
      this.std.app.width / 2 - this.cardWidth - 30,
      this.std.app.height / 2 - this.cardHeight + 30
    );
    instanceCard.transform.position = position;
    this.lastPlayerCard = instanceCard;
    this.lastPlayerCard.up();
    this.playerCardTexture = instanceCard.texture;
    this.playerCardHistory.unshift(instanceCard);
  }

  setOpponentCard(card: Card) {
    const instanceCard = this.createCardInstance(card);
    const position = new Vector2(
      this.std.app.width / 2 - this.cardWidth + 30,
      this.std.app.height / 2 - this.cardHeight - 30
    );
    instanceCard.transform.position = position;
    this.lastOpponentCard = instanceCard;
    this.enemyCardTexture = instanceCard.texture;
    this.opponentCardHistory.unshift(instanceCard);
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
    const playerWin = this.lastPlayerCard.value > this.lastOpponentCard.value;

    if (playerWin) {
      this.enemyHit = true;
    } else this.playerHit = true;
  }

  applyUpgrades() {
    const upgrades = this.player.hand.upgrades;
    upgrades.forEach((upgrade) => {
      switch (upgrade.special_effect) {
        case 1:
          this.playerCardValue = applyComboNaipes(this.getOpponentCardHistory(), this.playerCardValue);
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

  tick(dt) {
    if (this.lastPlayerCard) console.log(this.lastPlayerCard.texture);

    if (this.playerHit) {
      this.lastPlayerCard.texture = "card_damage.png";
      if (this.timer <= 1) {
        this.timer += dt / 100;
      } else {
        this.playerHit = false;
        this.timer = 0;
        this.lastPlayerCard.texture = this.playerCardTexture;
      }
    }

    if (this.enemyHit) {
      this.lastOpponentCard.texture = "card_damage.png";
      if (this.timer <= 1) {
        this.timer += dt / 100;
      } else {
        this.enemyHit = false;
        this.timer = 0;
        this.lastOpponentCard.texture = this.enemyCardTexture;
      }
    }
  }
}
