import { GlyStd } from "@gamely/gly-types";
import { Table } from "./game/entity/table";
import { Card } from "./game/entity/card";

import { CARD_LIST } from "./game/cards/cardList";
import { Player } from "./game/player/player";
import { WaitManager } from "./core/utils/waitManager";
import { UpgradeOffer } from "./game/upgrades/upgradeOffer";
import { UPGRADE_CARD_LIST } from "./game/upgrades/upgradeList";
import { printCurrentGameState, printOpponentPoints, printPlayerPoints } from "./core/ui/ui";
import { Opponent } from "./game/opponent/opponent";

enum GameState {
  WAITING_PLAYER_INPUT,
  PLAYER_TURN_ANIMATION,
  WAITING_ENEMY_TURN,
  ENEMY_TURN_ANIMATION,
  CALCULATING_RESULTS,
  GAME_OVER,
  CHOOSING_UPGRADE,
}

/*####################################################################*/
/*############################  Configs  #############################*/
/*####################################################################*/

const upgradeDeck = new UpgradeOffer();

let gameState: GameState = GameState.WAITING_PLAYER_INPUT;
let gameStateText: string = "";
const waitManager = new WaitManager();
const player = new Player();
let std: GlyStd;

function handleGameStateText() {
  switch (gameState) {
    case GameState.WAITING_ENEMY_TURN:
      gameStateText = "VEZ DO OPONENTE";
      break;
    case GameState.GAME_OVER:
      gameStateText = "GAME OVER";
      break;
    case GameState.WAITING_PLAYER_INPUT:
      gameStateText = "SUA VEZ";
      break;
    case GameState.CHOOSING_UPGRADE:
      gameStateText = "ESCOLHA UM UPGRADE";
    default:
      break;
  }
}

function handlePlayerCardSelection(std: GlyStd) {
  console.log("step1 handlePlayerCardSelection");
  if (gameState !== GameState.WAITING_PLAYER_INPUT) return;
  console.log("step2 handlePlayerCardSelection");
  table.setPlayerCard(player.getSelectedCard());
  console.log("step3 handlePlayerCardSelection");
  table.lastOpponentCard = null;
  console.log("step4 handlePlayerCardSelection");

  gameState = GameState.PLAYER_TURN_ANIMATION;

  waitManager.addWait({
    id: "player_card_animation",
    duration: 0.5,
    onComplete: () => {
      console.log("opponent turn");
      gameState = GameState.WAITING_ENEMY_TURN;
      handleOpponentTurn();
    },
    onUpdate: (progress) => {},
  });
}

function handleOpponentTurn() {
  console.log("handleOpponentTurn");
  if (gameState !== GameState.WAITING_ENEMY_TURN) return;
  gameState = GameState.ENEMY_TURN_ANIMATION;
  waitManager.addWait({
    id: "opponent_thinking",
    duration: 0.5,
    onComplete: () => {
      let opponentSelectedCard: Card = opponent.getBestCard(table.getPlayerCard());
      console.log(opponentSelectedCard.name);
      table.setOpponentCard(opponentSelectedCard);

      waitManager.addWait({
        id: "opponent_card_animation",
        duration: 0.5,
        onComplete: () => {
          handleGameCalculation();
        },
      });
    },
    onUpdate: (progress) => {},
  });
}

function resetGame() {
  player.matchPoints = 0;
  opponent.matchPoints = 0;
  player.hand.generateNewHand(CARD_LIST);
  player.hand.setCardsPosition(std.app.width, std.app.height);
  opponent.hand.generateNewHand(CARD_LIST);
  opponent.setCardsPosition(std.app.width, std.app.height);
}

function handleGameCalculation() {
  console.log("handleGameCalculation");
  gameState = GameState.CALCULATING_RESULTS;
  waitManager.addWait({
    id: "calculating_results",
    duration: 0.5,
    onComplete: () => {
      console.log("=== STACK TRACE oncomplete handlegamecalculation ===");
      console.trace();
      console.log("oncomplete");
      table.calculeWin();
      if (player.hand.cards.length === 0) {
        console.log("Calculando vitoria");
        if (player.matchPoints > opponent.matchPoints) {
          console.log("Jogador ganhou");
          waitManager.clear();
          gameState = GameState.CHOOSING_UPGRADE;
          upgradeDeck.generateNewUpgrades(UPGRADE_CARD_LIST);
          upgradeDeck.setCardsCenterPosition(std.app.width, std.app.height);
        } else {
          console.log("Jogador perdeu");
          waitManager.clear();
          gameState = GameState.GAME_OVER;
        }
        upgradeDeck.setCardsCenterPosition(std.app.width, std.app.height);
      } else gameState = GameState.WAITING_PLAYER_INPUT;
    },
    onUpdate: (progress) => {
      console.log(`Calculando resultado: ${Math.round(progress * 100)}%`);
    },
  });
}
function handleChooseUpgradeCard() {
  console.log("handleChooseUpgradeCard");
  gameState = GameState.CHOOSING_UPGRADE;
  upgradeDeck.generateNewUpgrades(UPGRADE_CARD_LIST);
}

const opponent = new Opponent(80);
let table: Table;
let pressed = false;

export const meta = {
  title: "Your Awesome Game",
  author: "IntellectualAuthor",
  version: "1.0.0",
  description: "The best game in the world made in GlyEngine",
};
function init(std: GlyStd, game: any) {
  std = std;
  player.hand.generateNewHand(CARD_LIST);
  player.hand.setCardsPosition(std.app.width, std.app.height);
  opponent.hand.generateNewHand(CARD_LIST);
  opponent.setCardsPosition(std.app.width, std.app.height);

  handleChooseUpgradeCard();
  table = new Table(std, player, opponent);
}

async function loop(std: GlyStd, game: any) {
  waitManager.update(std.delta / 1000);
  handleGameStateText();
  if (gameState === GameState.GAME_OVER) return;

  table.tick(std.delta);
  player.hand.updateState(std);
  opponent.hand.updateState(std);
  upgradeDeck.updateState(std);
  if (std.key.press.any) pressed = true;
  else pressed = false;
}

let doOnce = false;

function draw(std: GlyStd, game: any) {
  if (doOnce === false) {
    std.media.video().src("bg.mp4").resize(std.app.width, std.app.height).play();
    upgradeDeck.setCardsCenterPosition(std.app.width, std.app.height);
    doOnce = true;
  }
  console.log(gameState);
  if (gameState === GameState.GAME_OVER) {
    std.draw.color(std.color.white);
    std.text.font_size(50);
    std.text.print(std.app.width / 2 - 30, std.app.height / 2 - 4, "Game Over");
    return;
  }
  switch (gameState) {
    case GameState.CHOOSING_UPGRADE:
      upgradeDeck.drawHandCards(std);
      break;

    default:
      table.renderCurrentCard();
      player.hand.drawHandCards(std);
      opponent.hand.drawHandCards(std);
      break;
  }

  std.draw.color(std.color.white);

  std.text.font_size(14);
  std.text.font_name("tiny.ttf");
  printCurrentGameState(std, gameStateText);
  printPlayerPoints(std, player);
  printOpponentPoints(std, opponent);
}

function key(std: GlyStd, key) {
  if (gameState === GameState.GAME_OVER) return;

  if (gameState === GameState.WAITING_PLAYER_INPUT) {
    if (std.key.press.left) {
      if (!pressed) {
        console.log("pressed left");
        player.hand.switchActiveCard(false);
      }
    }
    if (std.key.press.right) {
      if (!pressed) {
        console.log("pressed right");
        player.hand.switchActiveCard(true);
      }
    }

    if (std.key.press.a) {
      if (!pressed) {
        console.log("pressed z");
        handlePlayerCardSelection(std);
      }
    }
  }
  if (gameState === GameState.CHOOSING_UPGRADE) {
    if (std.key.press.left) {
      if (!pressed) {
        console.log("pressed left");
        upgradeDeck.switchActiveCard(false);
      }
    }

    if (std.key.press.right) {
      if (!pressed) {
        console.log("pressed right");
        upgradeDeck.switchActiveCard(true);
      }
    }
    if (std.key.press.a) {
      resetGame();
      player.addUpgrade(upgradeDeck.getSelectedUpgrade());
      gameState = GameState.WAITING_PLAYER_INPUT;
    }
  }
}

function exit(std: GlyStd, game: any) {}

export const config = { require: "http media.video" };

export const callbacks = {
  init,
  loop,
  draw,
  exit,
  key,
};
