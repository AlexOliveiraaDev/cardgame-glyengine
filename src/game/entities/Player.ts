import { Card, CardDefinition } from "./card";
import { Hand } from "./hand";
import { UpgradeCard } from "../upgrades/upgradeCard";

export class Player {
  hand = new Hand();
  upgrades: UpgradeCard[] = [];
  matchPoints: number = 0;
  private cardHistory: Card[] = [];

  constructor() {
    // Inicializar o histórico de cartas vazio
    this.cardHistory = [];
  }

  getSelectedCard(): Card {
    const card = this.hand.getSelectedCard();
    if (!card) {
      throw new Error("No card selected");
    }

    console.log(`Player selected: ${card.name}`);

    // Adicionar ao histórico
    this.cardHistory.unshift(card);

    // Remover da mão
    this.hand.removeCardById(card.id);

    return card;
  }

  getLastCard(): Card | undefined {
    return this.cardHistory[0];
  }

  getCardHistory(): Card[] {
    return this.cardHistory;
  }

  addUpgrade(upgrade: UpgradeCard) {
    this.upgrades.push(upgrade);
    console.log(`Added upgrade: ${upgrade.name}`);
  }

  getUpgrades(): UpgradeCard[] {
    return this.upgrades;
  }

  getMatchPoints(): number {
    return this.matchPoints;
  }

  getHandCards(): Card[] {
    return this.hand.getAllCards();
  }

  hasCards(): boolean {
    return this.hand.getAllCards().length > 0;
  }

  // Reset para nova partida (mantém upgrades)
  resetForNewMatch() {
    this.matchPoints = 0;
    this.cardHistory = [];
  }

  // Reset completo (remove upgrades também)
  resetCompletely() {
    this.matchPoints = 0;
    this.cardHistory = [];
    this.upgrades = [];
  }
}
