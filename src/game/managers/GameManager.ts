import { GlyStd } from "@gamely/gly-types";
import { Table } from "../entities/table";
import { Player } from "../entities/Player";
import { Opponent } from "../entities/Opponent";
import { UpgradeManager } from "../upgrades/UpgradeManager";
import { WaitManager } from "../../core/utils/waitManager";
import { CARD_LIST } from "../data/CardDefinitions";
import { Card } from "../entities/card";
import { GameConfig } from "../config/GameConfig";
import { MenuManager } from "./menuManager";

// Fixed import path - assuming GameConfig is in the config folder

export enum GameState {
  MENU = "MENU",
  WAITING_PLAYER_INPUT = "WAITING_PLAYER_INPUT",
  PLAYER_TURN_ANIMATION = "PLAYER_TURN_ANIMATION",
  WAITING_ENEMY_TURN = "WAITING_ENEMY_TURN",
  ENEMY_TURN_ANIMATION = "ENEMY_TURN_ANIMATION",
  CALCULATING_RESULTS = "CALCULATING_RESULTS",
  CHOOSING_UPGRADE = "CHOOSING_UPGRADE",
  GAME_OVER = "GAME_OVER",
}

export enum TurnType {
  PLAYER_FIRST = "PLAYER_FIRST",
  OPPONENT_FIRST = "OPPONENT_FIRST",
}

export class GameManager {
  private std: GlyStd;
  private table: Table;
  private player: Player;
  private opponent: Opponent;
  private upgradeManager: UpgradeManager;
  private waitManager: WaitManager;
  private menuManager: MenuManager;

  private currentTurn: TurnType = TurnType.PLAYER_FIRST;
  private roundNumber: number = 1;
  private firstPlayerCard: Card | null = null;
  private isWaitingForSecondPlayer: boolean = false;

  public gameState: GameState = GameState.WAITING_PLAYER_INPUT;
  public gameStateText: string = "Escolha sua carta";

  constructor(std: GlyStd) {
    this.std = std;
    this.waitManager = new WaitManager();
    this.menuManager = new MenuManager(std);
    this.initializeGame();
    this.gameState = GameState.MENU;
    this.gameStateText = "Menu Principal";
  }

  // private initializeGame() {
  //   console.log("intializing game");
  //   this.player = new Player();
  //   this.opponent = new Opponent(GameConfig.DEFAULT_OPPONENT_DUMBNESS);
  //   this.table = new Table(this.std);
  //   this.upgradeManager = new UpgradeManager(this.player);

  //   this.gameState = GameState.CHOOSING_UPGRADE;
  //   this.upgradeManager.setCardsCenterPosition(this.std.app.width, this.std.app.height);
  //   this.gameStateText = "Escolha sua carta";
  // }

  private initializeGame() {
    console.log("Initializing game from menu...");
    this.player = new Player();
    this.opponent = new Opponent(GameConfig.DEFAULT_OPPONENT_DUMBNESS);
    this.table = new Table(this.std);
    this.upgradeManager = new UpgradeManager(this.player);
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

    // Determinar quem atacou e quem revidou
    const playerAttacked = this.currentTurn === TurnType.PLAYER_FIRST;
    const attackerValue = playerAttacked ? playerValue : opponentValue;
    const defenderValue = playerAttacked ? opponentValue : playerValue;

    console.log(`Rodada ${this.roundNumber}`);
    console.log(`${playerAttacked ? "Jogador" : "Oponente"} atacou: ${attackerValue}`);
    console.log(`${playerAttacked ? "Oponente" : "Jogador"} revidou: ${defenderValue}`);

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
          // Alternar turnos para próxima rodada
          this.alternateFirstPlayer();

          this.waitManager.addWait({
            id: "finish_round",
            duration: 1,
            onComplete: () => {
              this.cleanTable();
              this.startNewRound();
            },
          });
        }
      },
      onUpdate: (progress) => {
        console.log(`Calculando resultado: ${Math.round(progress * 100)}%`);
      },
    });
  }

  // Nova função para alternar quem começa
  private alternateFirstPlayer() {
    this.currentTurn = this.currentTurn === TurnType.PLAYER_FIRST ? TurnType.OPPONENT_FIRST : TurnType.PLAYER_FIRST;

    this.roundNumber++;
    console.log(
      `Próxima rodada (${this.roundNumber}): ${
        this.currentTurn === TurnType.PLAYER_FIRST ? "Jogador" : "Oponente"
      } começa`
    );
  }

  // Nova função para iniciar uma nova rodada
  private startNewRound() {
    this.firstPlayerCard = null;

    if (this.currentTurn === TurnType.PLAYER_FIRST) {
      this.gameState = GameState.WAITING_PLAYER_INPUT;
      this.gameStateText = "Sua vez de atacar!";
    } else {
      this.gameState = GameState.WAITING_ENEMY_TURN;
      this.gameStateText = "Oponente vai atacar primeiro...";
      // Pequeno delay antes do oponente jogar para dar tempo do jogador ler
      this.waitManager.addWait({
        id: "opponent_first_delay",
        duration: 0.5,
        onComplete: () => {
          this.handleOpponentFirstMove();
        },
      });
    }
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

  public handleInput(key: string) {
    // Se estamos no menu, delegar para o MenuManager
    if (this.gameState === GameState.MENU) {
      const handled = this.menuManager.handleInput(key);

      // Se o menu mudou para GAME, inicializar o jogo
      if (this.menuManager.isInGame()) {
        this.initializeGame();
        this.gameState = GameState.CHOOSING_UPGRADE;
        this.upgradeManager.setCardsCenterPosition(this.std.app.width, this.std.app.height);
        this.gameStateText = "Escolha seu primeiro upgrade!";
      }

      return;
    }

    // Game Over - permitir voltar ao menu
    if (this.gameState === GameState.GAME_OVER) {
      if (key === "menu" || key === "action") {
        this.menuManager.returnToMenu();
        this.gameState = GameState.MENU;
        return;
      }
      return;
    }

    // Sistema de turnos alternados - input do jogador
    if (this.gameState === GameState.WAITING_PLAYER_INPUT) {
      switch (key) {
        case "left":
          this.player.hand.switchActiveCard(false);
          break;
        case "right":
          this.player.hand.switchActiveCard(true);
          break;
        case "action":
          if (this.currentTurn === TurnType.PLAYER_FIRST) {
            this.handlePlayerCardSelection();
          } else {
            this.handlePlayerResponse();
          }
          break;
      }
    }

    // Seleção de upgrade
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
  private resetGame() {
    console.log("reseting game");

    // Reset das propriedades de turno
    this.currentTurn = TurnType.PLAYER_FIRST;
    this.roundNumber = 1;
    this.firstPlayerCard = null;

    // Reset match points
    this.player.matchPoints = 0;
    this.opponent.matchPoints = 0;

    // Gerar novas mãos
    this.player.hand.generateNewHand(CARD_LIST);
    this.opponent.generateNewHand(CARD_LIST);

    // Reposicionar cartas
    this.player.hand.setCardsPosition(this.std.app.width, this.std.app.height);
    this.opponent.setCardsPosition(this.std.app.width, this.std.app.height);

    // Selecionar primeira carta
    if (this.player.hand.getAllCards().length > 0) {
      this.player.hand.getAllCards()[0].up();
    }

    // Limpar mesa
    this.table.lastPlayerCard = null;
    this.table.lastOpponentCard = null;
  }
  public getCurrentTurnInfo(): { turn: TurnType; round: number } {
    return {
      turn: this.currentTurn,
      round: this.roundNumber,
    };
  }
  // Nova função para lidar com o jogador atacando primeiro
  public handlePlayerCardSelection() {
    if (this.gameState !== GameState.WAITING_PLAYER_INPUT) return;
    if (this.currentTurn !== TurnType.PLAYER_FIRST) return;

    const selectedCard = this.player.getSelectedCard();
    this.table.setPlayerCard(selectedCard);
    this.firstPlayerCard = selectedCard;

    this.gameState = GameState.PLAYER_TURN_ANIMATION;
    this.gameStateText = "Jogador atacou! Oponente vai revidar...";

    this.waitManager.addWait({
      id: "player_card_animation",
      duration: GameConfig.CARD_ANIMATION_DURATION,
      onComplete: () => {
        this.gameState = GameState.WAITING_ENEMY_TURN;
        this.gameStateText = "Oponente revidando...";
        this.handleOpponentResponse();
      },
      onUpdate: (progress) => {},
    });
  }

  public handleOpponentFirstMove() {
    if (this.gameState !== GameState.WAITING_ENEMY_TURN) return;

    this.gameState = GameState.ENEMY_TURN_ANIMATION;
    this.gameStateText = "Oponente atacando...";

    this.waitManager.addWait({
      id: "opponent_thinking",
      duration: GameConfig.OPPONENT_THINKING_TIME,
      onComplete: () => {
        // Oponente escolhe carta sem saber a do jogador
        const opponentCards = this.opponent.hand.getAllCards();
        const randomCard = opponentCards[Math.floor(Math.random() * opponentCards.length)];

        console.log(`Oponente atacou com: ${randomCard.name}`);
        this.opponent.removeSelectedCard(randomCard);
        this.table.setOpponentCard(randomCard);
        this.firstPlayerCard = randomCard;

        this.waitManager.addWait({
          id: "opponent_card_animation",
          duration: GameConfig.CARD_ANIMATION_DURATION,
          onComplete: () => {
            this.gameState = GameState.WAITING_PLAYER_INPUT;
            this.gameStateText = "Oponente atacou! Sua vez de revidar!";
          },
        });
      },
      onUpdate: (progress) => {},
    });
  }

  private handleOpponentResponse() {
    if (this.gameState !== GameState.WAITING_ENEMY_TURN) return;

    this.gameState = GameState.ENEMY_TURN_ANIMATION;

    this.waitManager.addWait({
      id: "opponent_thinking",
      duration: GameConfig.OPPONENT_THINKING_TIME,
      onComplete: () => {
        const opponentSelectedCard: Card = this.opponent.getBestCard(this.firstPlayerCard!);
        console.log(`Oponente revidou com: ${opponentSelectedCard.name}`);
        this.table.setOpponentCard(opponentSelectedCard);

        this.waitManager.addWait({
          id: "opponent_response_animation",
          duration: GameConfig.CARD_ANIMATION_DURATION,
          onComplete: () => {
            this.handleGameCalculation();
          },
        });
      },
      onUpdate: (progress) => {},
    });
  }

  public handlePlayerResponse() {
    if (this.gameState !== GameState.WAITING_PLAYER_INPUT) return;
    if (this.currentTurn !== TurnType.OPPONENT_FIRST) return;

    const selectedCard = this.player.getSelectedCard();
    this.table.setPlayerCard(selectedCard);

    this.gameState = GameState.PLAYER_TURN_ANIMATION;
    this.gameStateText = "Jogador revidou!";

    this.waitManager.addWait({
      id: "player_response_animation",
      duration: GameConfig.CARD_ANIMATION_DURATION,
      onComplete: () => {
        this.handleGameCalculation();
      },
      onUpdate: (progress) => {},
    });
  }

  public update(dt: number) {
    if (this.gameState === GameState.MENU) {
      this.menuManager.update(dt);
      return;
    }
    this.waitManager.tick(dt);
    this.table.tick(dt);

    // Update card animations
    this.player.hand.updateState(this.std);
    this.upgradeManager.updateState(this.std);
  }

  public render() {
    if (this.gameState === GameState.MENU) {
      this.menuManager.render();
      return;
    }

    if (this.gameState === GameState.GAME_OVER) {
      this.std.draw.color(this.std.color.white);
      this.std.text.font_size(50);
      this.std.text.print_ex(this.std.app.width / 2, this.std.app.height / 2 - 50, "Game Over", 0, 0);

      this.std.text.font_size(20);
      this.std.draw.color(this.std.color.gray);
      this.std.text.print_ex(
        this.std.app.width / 2,
        this.std.app.height / 2 + 20,
        "A ou MENU para voltar ao menu",
        0,
        0
      );
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

  public getMenuManager(): MenuManager {
    return this.menuManager;
  }
}
