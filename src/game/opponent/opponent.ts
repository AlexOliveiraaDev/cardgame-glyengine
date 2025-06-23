import { Vector2 } from "../../core/spatial/vector2";
import { Card, CardDefinition } from "../entity/card";
import { Hand } from "../player/hand";

export class Opponent {
  hand: Hand;
  matchPoints: number = 0;
  baseDumbness: number;
  constructor(baseDumbness: number) {
    this.hand = new Hand();
    console.log("new hand opponent", this.hand);
    this.baseDumbness = baseDumbness;
  }

  generateNewHand(deck: CardDefinition[]) {
    console.log("# Generating New Hand #");
    let newCard: Card = undefined;
    for (let i = 0; i < this.hand.cardsQuantity; i++) {
      newCard = this.hand.getNewCard(deck);
      console.log("Get card with success:", newCard);
      let cardCount = 0;
      let highCardCount = 0;
      for (let n = 0; n < this.hand.cards.length; n++) {
        if (cardCount == 2) break;
        if (highCardCount == 2) break;
        const card = this.hand.cards[n];
        if (card.id === newCard.id) cardCount++;
        if (card.value >= 10) highCardCount++;
      }
      if (cardCount >= 2 || highCardCount >= 2) {
        let reserveCard = this.hand.getNewCard(deck);
        while (newCard.id === reserveCard.id) {
          reserveCard = this.hand.getNewCard(deck);
        }

        this.hand.cards.push(reserveCard);
      } else {
        this.hand.cards.push(newCard);
      }
    }
    console.log("Finished generating new hand!");
  }

  getBestCard(card: Card) {
    const cards = this.hand.getAllCards().sort((a, b) => a.value - b.value);

    const winningCards = cards.filter((item) => item.value > card.value);

    const loseCards = cards.filter((item) => item.value < card.value);
    const variation = 25;

    const equalCards = cards.filter((item) => item.value === card.value);
    const dumbness = Math.min(100, Math.max(0, this.baseDumbness + (Math.random() * 2 - 1) * variation));

    if (dumbness >= 70) {
      const pool = loseCards.length > 0 ? loseCards : equalCards.length > 0 ? equalCards : winningCards;
      return pool[Math.floor(Math.random() * pool.length)];
    }

    if (dumbness >= 25) {
      return cards[Math.floor(Math.random() * cards.length)];
    }

    if (winningCards.length > 0) return winningCards[0];

    return cards[0];
  }

  setCardsPosition(screenWidth: number, screenHeight: number) {
    const spacing = 20;
    const cardWidth = 71;
    const cardHeight = 100;
    const totalWidth = this.hand.cards.length * spacing + (this.hand.cards.length - 1) * cardWidth;
    let x = (screenWidth - totalWidth) / 2;

    this.hand.cards.forEach((card) => {
      card.transform.position = new Vector2(x, cardHeight + 50);
      x += cardWidth + spacing;
    });
  }

  hideCards() {
    this.hand.cards.forEach((card) => (card.texture = "Card_2.png"));
  }
}
