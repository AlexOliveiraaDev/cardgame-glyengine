import { GlyStd } from "@gamely/gly-types";
import { Vector2 } from "../../core/spatial/vector2";
import { Card, CardDefinition } from "./card";

export class Hand {
  cards: Card[] = [];
  upgrades: Card[] = [];
  selectedCard = 0;
  cardsQuantity = 5;
  generateNewHand(deck: CardDefinition[]) {
    console.log("# Generating New Hand #");
    let newCard: Card = undefined;
    for (let i = 0; i < this.cardsQuantity; i++) {
      newCard = this.getNewCard(deck);
      console.log("Get card with success:", newCard);
      let cardCount = 0;
      for (let n = 0; n < this.cards.length; n++) {
        if (cardCount == 2) break;

        const card = this.cards[n];
        if (card.id === newCard.id) cardCount++;
      }
      if (cardCount >= 2) {
        let reserveCard = this.getNewCard(deck);
        while (newCard.id === reserveCard.id) {
          reserveCard = this.getNewCard(deck);
        }

        this.cards.push(reserveCard);
      } else {
        this.cards.push(newCard);
      }
    }
    console.log("Finished generating new hand!");
  }
  getNewCard(deck: CardDefinition[]) {
    console.log("Generating Card...");
    return new Card(deck[Math.floor(Math.random() * deck.length)]);
  }
  drawHandCards(std: GlyStd, hide: boolean = false) {
    this.cards.forEach((card) => {
      card.drawCard(std, hide);
    });
  }
  updateState(std: GlyStd) {
    this.cards.forEach((card) => {
      card.update(std);
    });
  }
  setCardsPosition(screenWidth: number, screenHeight: number) {
    const spacing = 20;
    const cardWidth = 71;
    const cardHeight = 100;
    const totalWidth = this.cards.length * spacing + (this.cards.length - 1) * cardWidth;
    let x = (screenWidth - totalWidth) / 2;

    this.cards.forEach((card) => {
      card.transform.position = new Vector2(x, screenHeight - cardHeight - spacing * 2);
      x += cardWidth + spacing;
    });
  }
  switchActiveCard(sum: boolean) {
    if (sum) {
      if (this.selectedCard < this.cards.length - 1) {
        this.selectedCard++;
        this.cards[this.selectedCard].up();

        for (let i = 0; i < this.cards.length; i++) {
          const card = this.cards[i];
          if (i !== this.selectedCard) {
            card.down();
          }
        }
      }
    } else {
      if (this.selectedCard >= 1) {
        this.selectedCard--;
        this.cards[this.selectedCard].up();
        for (let i = 0; i < this.cards.length; i++) {
          const card = this.cards[i];
          if (i !== this.selectedCard) card.down();
        }
      }
    }
  }
  getSelectedCard() {
    return this.cards[this.selectedCard];
  }
  setSelectedCard(index: number) {
    if (index >= 0 && index < this.cards.length - 1) this.selectedCard = index;
    else console.warn("Invalid card index");
  }

  getAllCards() {
    return this.cards;
  }

  addNewUpgrade(upgrade: Card) {
    this.upgrades.push(upgrade);
  }

  removeCardById(id: string) {
    const index = this.cards.findIndex((card) => card.id === id);
    if (index !== -1) this.cards.splice(index, 1);
  }

  use() {}
}
