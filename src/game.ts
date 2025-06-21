import { GlyStd } from "@gamely/gly-types";
import { Table } from "./game/entity/table";
import { Card } from "./game/entity/card";
import { Enemy } from "./game/enemy/enemy";
import { CARD_LIST } from "./game/cards/cardList";
import { Player } from "./game/player/player";
import { WaitManager } from "./core/utils/waitManager";
import { UpgradeOffer } from "./game/upgrades/upgradeOffer";
import { UPGRADE_CARD_LIST } from "./game/upgrades/upgradeList";

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
  if (gameState !== GameState.WAITING_PLAYER_INPUT) return;

  table.setPlayerCard(player.getSelectedCard());
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
      let enemySelectedCard: Card = opponent.getBestCard(table.getPlayerCard());
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
function handleChooseUpgradeCard() {
  gameState = GameState.CHOOSING_UPGRADE;
  upgradeDeck.generateNewUpgrades(UPGRADE_CARD_LIST);
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
  player.hand.generateNewHand(CARD_LIST);
  player.hand.setCardsPosition(std.app.width, std.app.height);

  opponent.hand.generateNewHand(CARD_LIST);
  handleChooseUpgradeCard();
  table = new Table(std, player);
}

async function loop(std: GlyStd, game: any) {
  handleGameStateText();
  waitManager.update(std.delta / 1000);
  table.tick(std.delta);
  player.hand.updateState(std);
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

  if (gameState === GameState.CHOOSING_UPGRADE) {
    upgradeDeck.drawHandCards(std);
  } else {
    table.renderCurrentCard();
    player.hand.drawHandCards(std);
  }

  std.draw.color(std.color.white);

  std.text.font_size(14);
  std.text.font_name("tiny.ttf");
  std.text.print(std.app.width / 2 - gameStateText.length * 3, 20, gameStateText);
  std.text.print(std.app.width / 2 - gameStateText.length * 3, 40, "Valor carta: " + table.playerCardValue);
}

function key(std: GlyStd, key) {
  if (GameState.WAITING_PLAYER_INPUT) {
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
  if (GameState.CHOOSING_UPGRADE) {
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
