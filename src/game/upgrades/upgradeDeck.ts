import { GlyStd } from "@gamely/gly-types";
import { Vector2 } from "../../core/spatial/vector2";
import { UpgradeCard, UpgradeCardDefinition } from "./upgradeCard";

export class UpgradeDeck {
  private deck: UpgradeCardDefinition[];
  private upgrades: UpgradeCard[] = [];
  constructor(deck: UpgradeCardDefinition[]) {
    this.deck = deck;
  }

  getNewCard(deck: UpgradeCardDefinition[]) {
    console.log("Generating UpgradeCard...");
    return new UpgradeCard(deck[Math.floor(Math.random() * deck.length)]);
  }

  generateNewUpgrades(cardsQuantity: number) {
    console.log("# Generating New Hand #");
    this.upgrades = [];
    let newCard: UpgradeCard = undefined;
    for (let i = 0; i < cardsQuantity; i++) {
      newCard = this.getNewCard(this.deck);
      console.log("Get card with success:", newCard);
      let cardCount = 0;
      for (let n = 0; n < this.upgrades.length; n++) {
        if (cardCount > 0) break;

        const card = this.upgrades[n];
        if (card.id === newCard.id) cardCount++;
      }
      if (cardCount > 0) {
        let reserveCard = this.getNewCard(this.deck);
        while (newCard.id === reserveCard.id) {
          reserveCard = this.getNewCard(this.deck);
        }

        this.upgrades.push(reserveCard);
      } else {
        this.upgrades.push(newCard);
      }
    }
    console.log("Finished generating new hand!");
  }

  getUpgradeCards() {
    return this.upgrades;
  }
}
