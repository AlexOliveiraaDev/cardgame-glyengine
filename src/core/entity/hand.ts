import { GlyStd } from "@gamely/gly-types";
import { Vector2 } from "../spatial/vector2";
import { Card } from "./card";
import { CARD_LIST } from "../../cards/cardList";

export class Hand {
  private cards: Card[] = [];
  selectedCard = 0;
  cardsQuantity = 5;
  generateNewHand() {
    console.log("# Generating New Hand #");
    let newCard: Card = undefined;
    for (let i = 0; i < this.cardsQuantity; i++) {
      newCard = this.getNewCard();
      console.log("Get card with success:", newCard);
      let cardCount = 0;
      for (let n = 0; n < this.cards.length; n++) {
        if (cardCount == 2) break;

        const card = this.cards[n];
        if (card.id === newCard.id) cardCount++;
      }
      if (cardCount >= 2) {
        let reserveCard = this.getNewCard();
        while (newCard.id === reserveCard.id) {
          reserveCard = this.getNewCard();
        }

        this.cards.push(reserveCard);
      } else {
        this.cards.push(newCard);
      }
    }
    console.log("Finished generating new hand!");
  }
  getNewCard() {
    console.log("Generating Card...");
    return new Card(CARD_LIST[Math.floor(Math.random() * CARD_LIST.length)]);
  }
  drawHandCards(std: GlyStd) {
    this.cards.forEach((card) => {
      card.drawCard(std);
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

  use() {}
}
