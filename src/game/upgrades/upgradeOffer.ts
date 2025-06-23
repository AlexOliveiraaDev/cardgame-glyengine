import { GlyStd } from "@gamely/gly-types";
import { Vector2 } from "../../core/spatial/vector2";
import { CardDefinition } from "../entity/card";
import { UpgradeCard, UpgradeCardDefinition } from "./upgradeCard";

export class UpgradeOffer {
  cardsQuantity: number = 4;
  upgrades: UpgradeCard[] = [];
  selectedCard = 0;

  generateNewUpgrades(deck: UpgradeCardDefinition[]) {
    console.log("# Generating New Hand #");
    this.upgrades = [];
    let newCard: UpgradeCard = undefined;
    for (let i = 0; i < this.cardsQuantity; i++) {
      newCard = this.getNewCard(deck);
      console.log("Get card with success:", newCard);
      let cardCount = 0;
      for (let n = 0; n < this.upgrades.length; n++) {
        if (cardCount > 0) break;

        const card = this.upgrades[n];
        if (card.id === newCard.id) cardCount++;
      }
      if (cardCount > 0) {
        let reserveCard = this.getNewCard(deck);
        while (newCard.id === reserveCard.id) {
          reserveCard = this.getNewCard(deck);
        }

        this.upgrades.push(reserveCard);
      } else {
        this.upgrades.push(newCard);
      }
    }
    console.log("Finished generating new hand!");
  }
  getNewCard(deck: UpgradeCardDefinition[]) {
    console.log("Generating UpgradeCard...");
    return new UpgradeCard(deck[Math.floor(Math.random() * deck.length)]);
  }
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

  getAllUpgrades() {
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
