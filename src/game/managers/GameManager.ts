import { GlyStd } from "@gamely/gly-types";
import { Table } from "../entities/table";
import { Player } from "../entities/Player";
import { Opponent } from "../entities/Opponent";
import { UpgradeManager } from "../upgrades/UpgradeManager";
import { WaitManager } from "../../core/utils/waitManager";
import { CARD_LIST } from "../data/CardDefinitions";
import { Card } from "../entities/card";
import { GameConfig } from "../config/GameConfig";
// Fixed import path - assuming GameConfig is in the config folder

export enum GameState {
  WAITING_PLAYER_INPUT = "WAITING_PLAYER_INPUT",
  PLAYER_TURN_ANIMATION = "PLAYER_TURN_ANIMATION",
  WAITING_ENEMY_TURN = "WAITING_ENEMY_TURN",
  ENEMY_TURN_ANIMATION = "ENEMY_TURN_ANIMATION",
  CALCULATING_RESULTS = "CALCULATING_RESULTS",
  CHOOSING_UPGRADE = "CHOOSING_UPGRADE",
  GAME_OVER = "GAME_OVER",
}

export class GameManager {
  private std: GlyStd;
  private table: Table;
  private player: Player;
  private opponent: Opponent;
  private upgradeManager: UpgradeManager;
  private waitManager: WaitManager;

  public gameState: GameState = GameState.WAITING_PLAYER_INPUT;
  public gameStateText: string = "Escolha sua carta";

  constructor(std: GlyStd) {
    this.std = std;
    this.waitManager = new WaitManager();
    this.initializeGame();
  }

  private initializeGame() {
    console.log("intializing game");
    this.player = new Player();
    this.opponent = new Opponent(GameConfig.DEFAULT_OPPONENT_DUMBNESS);
    this.table = new Table(this.std);
    this.upgradeManager = new UpgradeManager(this.player);

    this.gameState = GameState.CHOOSING_UPGRADE;
    this.upgradeManager.setCardsCenterPosition(this.std.app.width, this.std.app.height);
    this.gameStateText = "Escolha sua carta";
  }

  public handlePlayerCardSelection() {
    if (this.gameState !== GameState.WAITING_PLAYER_INPUT) return;

    const selectedCard = this.player.getSelectedCard();
    this.table.setPlayerCard(selectedCard);

    this.gameState = GameState.PLAYER_TURN_ANIMATION;
    this.gameStateText = "Jogador jogou!";

    this.waitManager.addWait({
      id: "player_card_animation",
      duration: GameConfig.CARD_ANIMATION_DURATION,
      onComplete: () => {
        console.log("Turno do oponente");
        this.gameState = GameState.WAITING_ENEMY_TURN;
        this.gameStateText = "Oponente pensando...";
        this.handleOpponentTurn();
      },
      onUpdate: (progress) => {},
    });
  }
  public cleanTable() {
    this.table.cleanTable();
  }

  private handleOpponentTurn() {
    if (this.gameState !== GameState.WAITING_ENEMY_TURN) return;

    this.gameState = GameState.ENEMY_TURN_ANIMATION;

    this.waitManager.addWait({
      id: "opponent_thinking",
      duration: GameConfig.OPPONENT_THINKING_TIME,
      onComplete: () => {
        const opponentSelectedCard: Card = this.opponent.getBestCard(this.table.getPlayerCard());
        console.log(`Oponente jogou: ${opponentSelectedCard.name}`);
        this.table.setOpponentCard(opponentSelectedCard);

        this.waitManager.addWait({
          id: "opponent_card_animation",
          duration: GameConfig.CARD_ANIMATION_DURATION,
          onComplete: () => {
            this.handleGameCalculation();
          },
        });
      },
      onUpdate: (progress) => {},
    });
  }

  private handleGameCalculation() {
    this.gameState = GameState.CALCULATING_RESULTS;
    this.gameStateText = "Calculando resultado...";

    const playerCard = this.table.getPlayerCard();
    const opponentCard = this.table.getOpponentCard();

    let playerValue = this.calculateCardValue(playerCard, this.player);
    let opponentValue = opponentCard.value;

    console.log(`Jogador: ${playerValue} vs Oponente: ${opponentValue}`);
    console.log("Duração do cálculo:", GameConfig.RESULT_CALCULATION_TIME);

    this.waitManager.addWait({
      id: "calculating_results",
      duration: GameConfig.RESULT_CALCULATION_TIME,
      onComplete: () => {
        // Determinar vencedor da rodada
        if (playerValue > opponentValue) {
          this.player.matchPoints++;
          this.table.hitOpponent();
          this.gameStateText = "Jogador ganhou a rodada!";
        } else if (opponentValue > playerValue) {
          this.opponent.matchPoints++;
          this.table.hitPlayer();
          this.gameStateText = "Oponente ganhou a rodada!";
        } else {
          this.gameStateText = "Empate!";
        }

        // Verificar fim de jogo
        if (this.player.getHandCards().length === 0) {
          this.handleEndGame();
        } else {
          // Continuar jogo
          this.waitManager.addWait({
            id: "finish_player_turn",
            duration: 1,
            onComplete: () => {
              console.log("limpando mesa");
              this.cleanTable();
            },
          });

          console.log("timeout");
          this.gameState = GameState.WAITING_PLAYER_INPUT;
          this.gameStateText = "Escolha sua carta";
        }
      },
      onUpdate: (progress) => {
        console.log(`Calculando resultado: ${Math.round(progress * 100)}%`);
      },
    });
  }

  private calculateCardValue(card: Card, player: Player): number {
    let value = card.value;

    // Aplicar efeitos de upgrade aqui
    const upgrades = player.getUpgrades();
    for (const upgrade of upgrades) {
      // switch (upgrade.special_effect) {
      //   case 1: // Combo de Naipes
      //     value = this.applyComboNaipes(player.getCardHistory(), value);
      //     break;
      //   // Adicionar outros efeitos conforme necessário
      // }
    }
    value = this.applyComboNaipes(player.getCardHistory(), value);

    return value;
  }

  private applyComboNaipes(cardHistory: Card[], value: number): number {
    if (cardHistory.length < 3) return value;

    const cardType = cardHistory[0].id.split("_")[0];
    let count = 0;

    for (let i = 0; i < Math.min(cardHistory.length, 3); i++) {
      const card = cardHistory[i];
      if (card.id.split("_")[0] === cardType) count++;
    }

    if (count >= 3) {
      console.log("aplicando dobro do valor");
      return value * 2; // Dobrar valor na 3ª carta do mesmo naipe
    }

    return value;
  }

  private handleEndGame() {
    if (this.player.getMatchPoints() > this.opponent.matchPoints) {
      console.log("Jogador ganhou a partida!");
      this.gameState = GameState.CHOOSING_UPGRADE;
      this.gameStateText = "Escolha um upgrade!";
      this.upgradeManager.setCardsCenterPosition(this.std.app.width, this.std.app.height);
    } else {
      console.log("Jogador perdeu a partida!");
      this.gameState = GameState.GAME_OVER;
      this.gameStateText = "Game Over";
    }
  }

  public handleUpgradeSelection() {
    const selectedUpgrade = this.upgradeManager.getSelectedUpgrade();
    this.player.addUpgrade(selectedUpgrade);
    console.log(`Upgrade selecionado: ${selectedUpgrade.name}`);

    this.resetGame();
    this.gameState = GameState.WAITING_PLAYER_INPUT;
    this.gameStateText = "Escolha sua carta";
  }

  private resetGame() {
    console.log("reseting game");
    // Reset match points
    this.player.matchPoints = 0;
    this.opponent.matchPoints = 0;

    // Gerar novas mãos
    this.player.hand.generateNewHand(CARD_LIST);
    this.opponent.generateNewHand(CARD_LIST);

    // Reposicionar cartas
    this.player.hand.setCardsPosition(this.std.app.width, this.std.app.height);
    this.opponent.setCardsPosition(this.std.app.width, this.std.app.height);
    //this.opponent.hideCards();

    // Selecionar primeira carta
    if (this.player.hand.getAllCards().length > 0) {
      this.player.hand.getAllCards()[0].up();
    }

    // Limpar mesa
    this.table.lastPlayerCard = null;
    this.table.lastOpponentCard = null;
  }

  public handleInput(key: string) {
    if (this.gameState === GameState.GAME_OVER) return;

    if (this.gameState === GameState.WAITING_PLAYER_INPUT) {
      switch (key) {
        case "left":
          this.player.hand.switchActiveCard(false);
          break;
        case "right":
          this.player.hand.switchActiveCard(true);
          break;
        case "action":
          this.handlePlayerCardSelection();
          break;
      }
    }

    if (this.gameState === GameState.CHOOSING_UPGRADE) {
      switch (key) {
        case "left":
          this.upgradeManager.switchActiveCard(false);
          break;
        case "right":
          this.upgradeManager.switchActiveCard(true);
          break;
        case "action":
          this.handleUpgradeSelection();
          break;
      }
    }
  }

  public update(dt: number) {
    this.waitManager.tick(dt);
    this.table.tick(dt);

    // Update card animations
    this.player.hand.updateState(this.std);
    this.upgradeManager.updateState(this.std);
  }

  public render() {
    if (this.gameState === GameState.GAME_OVER) {
      this.std.draw.color(this.std.color.white);
      this.std.text.font_size(50);
      this.std.text.print(this.std.app.width / 2 - 100, this.std.app.height / 2 - 25, "Game Over");
      return;
    }

    switch (this.gameState) {
      case GameState.CHOOSING_UPGRADE:
        this.upgradeManager.drawHandCards(this.std);
        break;
      default:
        this.table.renderCurrentCard();
        this.player.hand.drawHandCards(this.std, false);
        this.opponent.hand.drawHandCards(this.std, true);
        break;
    }
  }

  // Getters para UI
  public getGameState(): GameState {
    return this.gameState;
  }

  public getGameStateText(): string {
    return this.gameStateText;
  }

  public getPlayer(): Player {
    return this.player;
  }

  public getOpponent(): Opponent {
    return this.opponent;
  }
}
