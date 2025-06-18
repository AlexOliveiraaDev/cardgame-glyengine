import { GlyStd } from "@gamely/gly-types";
import { Hand } from "./core/entity/hand";
import { Table } from "./core/entity/table";
import { Enemy } from "./core/enemy/enemy";
import { Card } from "./core/entity/card";

interface WaitAction {
  id: string;
  duration: number;
  onComplete: () => void;
  onUpdate?: (progress: number) => void;
}

class WaitManager {
  private waitActions: Map<string, { timeLeft: number; action: WaitAction }> = new Map();

  addWait(action: WaitAction) {
    this.waitActions.set(action.id, { timeLeft: action.duration, action: action });
  }

  removeWait(id: string) {
    this.waitActions.delete(id);
  }

  isWaiting(id: string) {
    return this.waitActions.has(id);
  }

  isAnyWaiting(): boolean {
    return this.waitActions.size > 0;
  }

  update(dt: number) {
    const completedActions: string[] = [];
    this.waitActions.forEach((waitData, id) => {
      waitData.timeLeft -= dt;
      const progress = 1 - (waitData.timeLeft - waitData.action.duration);

      if (waitData.action.onUpdate) {
        waitData.action.onUpdate(Math.min(progress, 1));
      }

      if (waitData.timeLeft <= 0) {
        completedActions.push(id);
      }

      completedActions.forEach((id) => {
        const waitData = this.waitActions.get(id);
        if (waitData) {
          waitData.action.onComplete();
          this.waitActions.delete(id);
        }
      });
    });
  }

  getProgress(id: string): number {
    const waitData = this.waitActions.get(id);
    if (!waitData) return 0;

    return 1 - waitData.timeLeft / waitData.action.duration;
  }

  clear() {
    this.waitActions.clear();
  }
}

enum GameState {
  WAITING_PLAYER_INPUT,
  PLAYER_TURN_ANIMATION,
  WAITING_ENEMY_TURN,
  ENEMY_TURN_ANIMATION,
  CALCULATING_RESULTS,
  GAME_OVER,
}

/*####################################################################*/
/*############################  Configs  #############################*/
/*####################################################################*/

const playerHand = new Hand();
let timeWait = 0;
let isWaiting = false;
let waitingEnemy = false;
let playerSelectedCard: Card;
let gameState: GameState = GameState.WAITING_PLAYER_INPUT;
let gameStateText: string = "";
const waitManager = new WaitManager();

function handleGameStateText() {
  switch (gameState) {
    case GameState.CALCULATING_RESULTS:
      gameStateText = "CALCULANDO";
      break;
    case GameState.ENEMY_TURN_ANIMATION:
      gameStateText = "ENEMY TURN";
      break;
    case GameState.GAME_OVER:
      gameStateText = "GAME OVER";
      break;
    case GameState.WAITING_PLAYER_INPUT:
      gameStateText = "PLAYERS TURN";
      break;
    default:
      break;
  }
}

function handlePlayerCardSelection(std: GlyStd) {
  if (gameState !== GameState.WAITING_PLAYER_INPUT) return;

  playerSelectedCard = playerHand.getSelectedCard();
  table.setPlayerCard(playerSelectedCard);
  table.lastOpponentCard = null;

  gameState = GameState.PLAYER_TURN_ANIMATION;

  waitManager.addWait({
    id: "player_card_animation",
    duration: 0.5,
    onComplete: () => {
      gameState = GameState.WAITING_ENEMY_TURN;
      handleEnemyTurn();
    },
    onUpdate: (progress) => {},
  });
}

function handleEnemyTurn() {
  if (gameState !== GameState.WAITING_ENEMY_TURN) return;
  gameState = GameState.ENEMY_TURN_ANIMATION;
  waitManager.addWait({
    id: "enemy_thinking",
    duration: 0.5,
    onComplete: () => {
      let enemySelectedCard: Card = opponent.getBestCard(playerSelectedCard);
      console.log(enemySelectedCard.name);
      table.setOpponentCard(enemySelectedCard);

      waitManager.addWait({
        id: "enemy_card_animation",
        duration: 0.5,
        onComplete: () => {
          handleGameCalculation();
        },
      });
    },
    onUpdate: (progress) => {},
  });
}

function handleGameCalculation() {
  console.log(waitManager.isAnyWaiting());

  gameState = GameState.CALCULATING_RESULTS;
  waitManager.addWait({
    id: "calculating_results",
    duration: 0.5,
    onComplete: () => {
      table.calculeWin();
      gameState = GameState.WAITING_PLAYER_INPUT;
    },
    onUpdate: (progress) => {
      console.log(`Calculando resultado: ${Math.round(progress * 100)}%`);
    },
  });
}

const opponent = new Enemy();
let table: Table;
let pressed = false;

export const meta = {
  title: "Your Awesome Game",
  author: "IntellectualAuthor",
  version: "1.0.0",
  description: "The best game in the world made in GlyEngine",
};
function init(std: GlyStd, game: any) {
  playerHand.generateNewHand();
  playerHand.setCardsPosition(std.app.width, std.app.height);
  opponent.hand.generateNewHand();
  table = new Table(std);
}

async function loop(std: GlyStd, game: any) {
  handleGameStateText();
  waitManager.update(std.delta / 1000);

  table.tick(std.delta);

  if (std.key.press.left && gameState === GameState.WAITING_PLAYER_INPUT) {
    if (!pressed) {
      console.log("pressed left");
      playerHand.switchActiveCard(false);
    }
  }
  if (std.key.press.right && gameState === GameState.WAITING_PLAYER_INPUT) {
    if (!pressed) {
      console.log("pressed right");
      playerHand.switchActiveCard(true);
    }
  }
  if (std.key.press.a) {
    if (!pressed) {
      console.log("pressed z");
      handlePlayerCardSelection(std);
    }
  }

  if (std.key.press.any) pressed = true;
  else pressed = false;
  playerHand.updateState(std);
}

let doOnce = false;

function draw(std: GlyStd, game: any) {
  std.text.put(100, 100, gameStateText, 10);
  if (doOnce === false) {
    std.media.video().src("bg.mp4").resize(std.app.width, std.app.height).play();
    doOnce = true;
  }
  table.renderCurrentCard();
  playerHand.drawHandCards(std);
}

function key(key) {}

function exit(std: GlyStd, game: any) {}

export const config = { require: "http media.video" };

export const callbacks = {
  init,
  loop,
  draw,
  exit,
  key,
};
