import { Card } from "../../game/entity/card";
import { Hand } from "../player/hand";

export class Enemy {
  hand: Hand;
  constructor() {
    this.hand = new Hand();
    console.log("new hand enemy", this.hand);
  }

  getBestCard(card: Card) {
    console.log("1");
    const cards = this.hand.getAllCards();
    console.log("2");
    const sortedCards = cards.slice().sort((a, b) => a.value - b.value);
    console.log("3");

    for (let i = 0; i < sortedCards.length; i++) {
      const element = sortedCards[i];
      console.log(element.name);
      if (element.value > card.value) return element;
    }
    return sortedCards[0];
    // return sortedCards[0];
  }
}
