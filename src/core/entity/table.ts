import { GlyStd } from "@gamely/gly-types";
import { Card, CardDefinition } from "./card";
import { Vector2 } from "../spatial/vector2";

export class Table {
  lastOpponentCard: Card;
  lastPlayerCard: Card;
  currentCard: Card;
  std: GlyStd;

  cardWidth = 30;
  cardHeight = 120;
  playerHit = false;
  enemyHit = false;
  timer = 0;

  playerCardTexture = "";
  enemyCardTexture = "";

  constructor(std: GlyStd) {
    this.std = std;
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
