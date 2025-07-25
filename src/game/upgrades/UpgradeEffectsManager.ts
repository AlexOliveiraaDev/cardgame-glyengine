import { Card } from "../entities/card";
import { UpgradeCard } from "./upgradeCard";
import { GameConfig } from "../config/GameConfig";

export class UpgradeEffectsManager {
  /**
   * Aplica todos os efeitos de upgrade aplicáveis a uma carta
   */
  static applyUpgradeEffects(card: Card, upgrades: UpgradeCard[], cardHistory: Card[], gameContext?: any): number {
    let finalValue = card.value;

    for (const upgrade of upgrades) {
      const modifiedValue = this.applySpecificUpgrade(
        upgrade.special_effect,
        card,
        finalValue,
        cardHistory,
        gameContext
      );

      if (GameConfig.LOG_UPGRADE_EFFECTS && modifiedValue !== finalValue) {
        console.log(`Upgrade '${upgrade.name}' modificou valor de ${finalValue} para ${modifiedValue}`);
      }

      finalValue = modifiedValue;
    }

    return finalValue;
  }

  /**
   * Aplica um efeito de upgrade específico
   */
  private static applySpecificUpgrade(
    effectId: number,
    card: Card,
    currentValue: number,
    cardHistory: Card[],
    gameContext?: any
  ): number {
    switch (effectId) {
      case GameConfig.UPGRADE_EFFECTS.COMBO_NAIPES:
        return this.applyComboNaipes(cardHistory, currentValue);

      case GameConfig.UPGRADE_EFFECTS.CARTA_MARCADA:
        return this.applyCartaMarcada(card, currentValue, gameContext);

      case GameConfig.UPGRADE_EFFECTS.BARALHO_ENSANGUENTADO:
        return this.applyBaralhoEnsanguentado(cardHistory, currentValue);

      case GameConfig.UPGRADE_EFFECTS.ECO_INVERSO:
        return this.applyEcoInverso(cardHistory, currentValue);

      case GameConfig.UPGRADE_EFFECTS.PRESTIGIO_ANTIGO:
        return this.applyPrestigioAntigo(card, currentValue, cardHistory);

      case GameConfig.UPGRADE_EFFECTS.NAIPE_CORINGA:
        return this.applyNaipeCoringa(card, currentValue, gameContext);

      case GameConfig.UPGRADE_EFFECTS.PRESSAGIO_DERROTA:
        return this.applyPressagioDerrota(currentValue, gameContext);

      case GameConfig.UPGRADE_EFFECTS.CORACAO_FRIO:
        return this.applyCoracaoFrio(card, currentValue);

      case GameConfig.UPGRADE_EFFECTS.ORDEM_IMPLACAVEL:
        return this.applyOrdemImplacavel(currentValue, gameContext);

      default:
        return currentValue;
    }
  }

  /**
   * Combo de Naipe: 3 cartas do mesmo naipe fazem a 3ª valer o dobro
   */
  private static applyComboNaipes(cardHistory: Card[], value: number): number {
    if (cardHistory.length < 3) return value;

    const currentSuit = cardHistory[0].id.split("_")[0];
    let suitCount = 0;

    // Contar cartas do mesmo naipe nas últimas 3 jogadas
    for (let i = 0; i < Math.min(cardHistory.length, 3); i++) {
      const card = cardHistory[i];
      if (card.id.split("_")[0] === currentSuit) {
        suitCount++;
      }
    }

    // Se 3 cartas do mesmo naipe foram jogadas, dobrar o valor
    if (suitCount >= 3) {
      return value * 2;
    }

    return value;
  }

  /**
   * Carta Marcada: valor aleatório escolhido no início recebe +2
   */
  private static applyCartaMarcada(card: Card, value: number, gameContext?: any): number {
    // Verificar se esta carta é a "marcada" (implementar lógica de contexto)
    const markedValue = gameContext?.markedCardValue || 7; // Valor padrão para exemplo

    if (card.value === markedValue) {
      return value + 2;
    }

    return value;
  }

  /**
   * Baralho Ensanguentado: 1ª carta -1, restantes +1
   */
  private static applyBaralhoEnsanguentado(cardHistory: Card[], value: number): number {
    const isFirstCard = cardHistory.length === 0;

    if (isFirstCard) {
      return Math.max(1, value - 1); // Não pode ficar menor que 1
    } else {
      return value + 1;
    }
  }

  /**
   * Eco Inverso: mesma carta em sequência recebe +3
   */
  private static applyEcoInverso(cardHistory: Card[], value: number): number {
    if (cardHistory.length === 0) return value;

    const currentCard = cardHistory[0];
    const previousCard = cardHistory[1];

    if (previousCard && currentCard.id === previousCard.id) {
      return value + 3;
    }

    return value;
  }

  /**
   * Prestígio Antigo: valor 10 vira 14 se for carta única na mão
   */
  private static applyPrestigioAntigo(card: Card, value: number, cardHistory: Card[]): number {
    if (card.value !== 10) return value;

    // Verificar se é carta única (implementar lógica de contexto se necessário)
    // Por simplicidade, aplicar sempre que for valor 10
    return 14;
  }

  /**
   * Naipe Coringa: todas as cartas de um naipe escolhido recebem +1
   */
  private static applyNaipeCoringa(card: Card, value: number, gameContext?: any): number {
    const chosenSuit = gameContext?.chosenSuit || "hearts"; // Padrão para exemplo
    const cardSuit = card.id.split("_")[0];

    if (cardSuit === chosenSuit) {
      return value + 1;
    }

    return value;
  }

  /**
   * Presságio de Derrota: após 2 derrotas seguidas, próxima carta +5
   */
  private static applyPressagioDerrota(value: number, gameContext?: any): number {
    const consecutiveLosses = gameContext?.consecutiveLosses || 0;

    if (consecutiveLosses >= 2) {
      return value + 5;
    }

    return value;
  }

  /**
   * Coração Frio: cartas especiais reduzem valor normal mas dobram progresso
   */
  private static applyCoracaoFrio(card: Card, value: number): number {
    if (card.is_special) {
      // Reduzir valor mas indicar que progresso deve ser dobrado
      // (implementar lógica de contexto para progresso)
      return Math.max(1, value - 2);
    }

    return value;
  }

  /**
   * Ordem Implacável: mão ordenada dá +1 em todas as cartas
   */
  private static applyOrdemImplacavel(value: number, gameContext?: any): number {
    const isHandOrdered = gameContext?.isHandOrdered || false;

    if (isHandOrdered) {
      return value + 1;
    }

    return value;
  }

  /**
   * Verifica se uma mão está ordenada por valor
   */
  static isHandOrdered(cards: Card[]): boolean {
    if (cards.length <= 1) return true;

    for (let i = 1; i < cards.length; i++) {
      if (cards[i].value < cards[i - 1].value) {
        return false;
      }
    }

    return true;
  }

  /**
   * Seleciona um naipe aleatório para efeitos que precisam
   */
  static selectRandomSuit(): string {
    const suits = ["clubs", "diamonds", "hearts", "spades"];
    return suits[Math.floor(Math.random() * suits.length)];
  }

  /**
   * Seleciona um valor aleatório para carta marcada
   */
  static selectRandomCardValue(): number {
    return Math.floor(Math.random() * 13) + 2; // Valores de 2 a 14
  }
}
