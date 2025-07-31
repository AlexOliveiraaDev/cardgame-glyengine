import { GlyStd } from "@gamely/gly-types";
import { Card, CardDefinition } from "./card";
import { Vector2 } from "../../core/spatial/vector2";
import { Player } from "./Player";
import { Opponent } from "./Opponent";
import { createCardInstance } from "../utils/CardFactory";

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

  constructor(std: GlyStd) {
    this.std = std;
  }

  setPlayerCard(card: Card) {
    const instanceCard = createCardInstance(card);
    const position = new Vector2(
      this.std.app.width / 2 - this.cardWidth - 30,
      this.std.app.height / 2 - this.cardHeight + 30
    );
    instanceCard.transform.position = position;
    this.lastPlayerCard = instanceCard;
    this.lastPlayerCard.up();
    this.playerCardTexture = instanceCard.texture;
  }

  cleanTable() {
    this.playerCardTexture = null;
    this.lastPlayerCard = null;
    this.opponentCardTexture = null;
    this.lastOpponentCard = null;
  }

  setOpponentCard(card: Card) {
    const instanceCard = createCardInstance(card);
    const position = new Vector2(
      this.std.app.width / 2 - this.cardWidth + 30,
      this.std.app.height / 2 - this.cardHeight - 30
    );
    instanceCard.transform.position = position;
    this.lastOpponentCard = instanceCard;
    this.opponentCardTexture = instanceCard.texture;
  }

  renderCurrentCard() {
    if (this.lastOpponentCard && this.lastOpponentCard.texture) {
      this.lastOpponentCard.drawCard(this.std, false);
    }
    if (this.lastPlayerCard && this.lastPlayerCard.texture) {
      this.lastPlayerCard.drawCard(this.std, false);
    }
  }

  getPlayerCard() {
    if (this.lastPlayerCard) return this.lastPlayerCard;
  }

  getOpponentCard() {
    if (this.lastOpponentCard) return this.lastOpponentCard;
  }

  hitPlayer() {
    this.playerHit = true;
  }

  hitOpponent() {
    this.opponentHit = true;
  }

  applyHitOnPlayer(dt: number) {
    this.lastPlayerCard.texture = "card_damage.png";
    if (this.playerTimer <= 1) {
      this.playerTimer += dt / 100;
    } else {
      this.playerHit = false;
      this.playerTimer = 0;
      this.lastPlayerCard.texture = this.playerCardTexture;
    }
  }

  applyHitOnOpponent(dt: number) {
    this.lastOpponentCard.texture = "card_damage.png";
    if (this.opponentTimer <= 1) {
      this.opponentTimer += dt / 100;
    } else {
      this.opponentHit = false;
      this.opponentTimer = 0;
      this.lastOpponentCard.texture = this.opponentCardTexture;
    }
  }

  applyWinOnPlayer(dt: number) {
    this.lastPlayerCard.texture = "card_win.png";
    if (this.playerTimer <= 1) {
      this.playerTimer += dt / 100;
    } else {
      this.playerHit = false;
      this.playerTimer = 0;
      this.lastPlayerCard.texture = this.playerCardTexture;
    }
  }

  applyWinOnOpponent(dt: number) {
    this.lastOpponentCard.texture = "card_win.png";
    if (this.opponentTimer <= 1) {
      this.opponentTimer += dt / 100;
    } else {
      this.opponentHit = false;
      this.opponentTimer = 0;
      this.lastOpponentCard.texture = this.opponentCardTexture;
    }
  }

  tick(dt) {
    if (this.playerHit) {
      this.applyHitOnPlayer(dt);
      //this.applyWinOnOpponent(dt);
    }

    if (this.opponentHit) {
      this.applyHitOnOpponent(dt);
      //this.applyWinOnPlayer(dt);
    }
  }
}
