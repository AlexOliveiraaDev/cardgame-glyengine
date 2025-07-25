import { Vector2 } from "../../core/spatial/vector2";
import { Card, CardDefinition } from "./card";
import { Hand } from "./hand";

export class Opponent {
  hand: Hand;
  matchPoints: number = 0;
  baseDumbness: number;
  cardHistory: Card[];

  constructor(baseDumbness: number) {
    this.hand = new Hand();
    this.baseDumbness = baseDumbness;
    this.cardHistory = []; // Inicializar array vazio
    console.log("New opponent created with dumbness:", baseDumbness);
  }

  removeSelectedCard(card: Card) {
    this.cardHistory.unshift(card);
    this.hand.removeCardById(card.id);
  }

  generateNewHand(deck: CardDefinition[]) {
    console.log("# Generating New Opponent Hand #");

    // Limpar mão atual
    this.hand.cards = [];

    for (let i = 0; i < this.hand.cardsQuantity; i++) {
      let newCard: Card = this.hand.getNewCard(deck);
      console.log("Got card:", newCard.name);

      let cardCount = 0;
      let highCardCount = 0;

      // Verificar duplicatas e cartas altas
      for (let n = 0; n < this.hand.cards.length; n++) {
        if (cardCount >= 2) break;
        if (highCardCount >= 2) break;

        const card = this.hand.cards[n];
        if (card.id === newCard.id) cardCount++;
        if (card.value >= 10) highCardCount++;
      }

      // Se há muitas duplicatas ou cartas altas, pegar carta alternativa
      if (cardCount >= 2 || highCardCount >= 2) {
        let reserveCard = this.hand.getNewCard(deck);
        let attempts = 0;

        // Evitar loop infinito
        while (newCard.id === reserveCard.id && attempts < 10) {
          reserveCard = this.hand.getNewCard(deck);
          attempts++;
        }

        this.hand.cards.push(reserveCard);
      } else {
        this.hand.cards.push(newCard);
      }
    }

    console.log("Finished generating opponent hand with", this.hand.cards.length, "cards");
  }

  getLastCard(): Card | undefined {
    return this.cardHistory[0];
  }

  getCardHistory(): Card[] {
    return this.cardHistory;
  }

  // Added method for consistency with Player class
  getMatchPoints(): number {
    return this.matchPoints;
  }

  getBestCard(playerCard: Card): Card {
    const cards = this.hand.getAllCards().sort((a, b) => a.value - b.value);

    if (cards.length === 0) {
      throw new Error("Opponent has no cards left");
    }

    const winningCards = cards.filter((item) => item.value > playerCard.value);
    const loseCards = cards.filter((item) => item.value < playerCard.value);
    const equalCards = cards.filter((item) => item.value === playerCard.value);

    const variation = 25;
    const dumbness = Math.min(100, Math.max(0, this.baseDumbness + (Math.random() * 2 - 1) * variation));

    let selectedCard: Card;

    // Muito burro - joga carta perdedora
    if (dumbness >= 70) {
      const pool = loseCards.length > 0 ? loseCards : equalCards.length > 0 ? equalCards : winningCards;
      selectedCard = pool[Math.floor(Math.random() * pool.length)];
    }
    // Mediamente burro - joga aleatório
    else if (dumbness >= 25) {
      selectedCard = cards[Math.floor(Math.random() * cards.length)];
    }
    // Inteligente - tenta ganhar com menor carta possível
    else {
      if (winningCards.length > 0) {
        selectedCard = winningCards[0]; // Menor carta vencedora
      } else {
        selectedCard = cards[0]; // Menor carta possível se não pode ganhar
      }
    }

    console.log(
      `Opponent chose: ${selectedCard.name} (value: ${selectedCard.value}) against player's ${playerCard.value}`
    );

    this.removeSelectedCard(selectedCard);
    return selectedCard;
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
    this.hand.cards.forEach((card) => {
      card.texture = "Card_2.png"; // Carta virada para baixo
    });
  }

  // Reset para nova partida
  resetForNewMatch() {
    this.matchPoints = 0;
    this.cardHistory = [];
  }
}
