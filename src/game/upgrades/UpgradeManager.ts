import { GlyStd } from "@gamely/gly-types";
import { Vector2 } from "../../core/spatial/vector2";
import { Player } from "../entities/Player";
import { UpgradeCard, UpgradeCardDefinition } from "./upgradeCard";
import { UpgradeDeck } from "./upgradeDeck";
import { UPGRADE_CARD_LIST } from "../data/UpgradeDefinitions";

export class UpgradeManager {
  private player: Player;
  private upgradeDeck: UpgradeDeck;
  private upgrades: UpgradeCard[];
  UPGRADE_QUANTITY = 2;

  constructor(player: Player) {
    this.player = player;
    this.upgradeDeck = new UpgradeDeck(UPGRADE_CARD_LIST);
    this.upgradeDeck.generateNewUpgrades(this.UPGRADE_QUANTITY);
    this.upgrades = this.upgradeDeck.getUpgradeCards();
  }

  cardsQuantity: number = 4;

  selectedCard = 0;

  drawHandCards(std: GlyStd) {
    this.upgrades.forEach((card) => {
      card.drawCard(std);
    });
  }

  updateState(std: GlyStd) {
    this.upgrades.forEach((card) => {
      card.update(std);
    });
  }

  switchActiveCard(sum: boolean) {
    if (sum) {
      if (this.selectedCard < this.upgrades.length - 1) {
        this.selectedCard++;
        this.upgrades[this.selectedCard].up();

        for (let i = 0; i < this.upgrades.length; i++) {
          const card = this.upgrades[i];
          if (i !== this.selectedCard) {
            card.down();
          }
        }
      }
    } else {
      if (this.selectedCard >= 1) {
        this.selectedCard--;
        this.upgrades[this.selectedCard].up();
        for (let i = 0; i < this.upgrades.length; i++) {
          const card = this.upgrades[i];
          if (i !== this.selectedCard) card.down();
        }
      }
    }
  }
  setSelectedCard(index: number) {
    if (index >= 0 && index < this.upgrades.length - 1) this.selectedCard = index;
    else console.warn("Invalid card index");
  }

  getAllupgradeDeck() {
    return this.upgrades;
  }

  setCardsCenterPosition(screenWidth: number, screenHeight: number) {
    const spacing = 20;
    const cardWidth = 107;
    const cardHeight = 150;
    const totalWidth = this.upgrades.length * spacing + (this.upgrades.length - 1) * cardWidth;
    let x = (screenWidth - totalWidth) / 2;

    this.upgrades.forEach((card) => {
      card.transform.position = new Vector2(x, screenHeight / 2 - cardHeight);
      x += cardWidth + spacing;
    });
  }

  getSelectedUpgrade() {
    return this.upgrades[this.selectedCard];
  }
}
