import { GlyStd } from "@gamely/gly-types";

import {
  printCurrentGameState,
  printOpponentPoints,
  printPlayerPoints,
  printControls,
  printUpgradeInfo,
} from "./ui/gameUI";
import { GameManager } from "./game/managers/GameManager";
import { GameConfig } from "./game/config/GameConfig";

/*####################################################################*/
/*############################  Configs  #############################*/
/*####################################################################*/

let gameManager: GameManager;
let pressed = false;

export const meta = {
  title: "Card Game",
  author: "",
  version: "1.0.0",
  description: "",
};

function init(std: GlyStd, game: any) {
  console.log("Initializing game...");
  gameManager = new GameManager(std);
}

async function loop(std: GlyStd, game: any) {
  if (std.key.press.any) {
    pressed = true;
  } else {
    pressed = false;
  }

  gameManager.update(std.delta);
}

function draw(std: GlyStd, game: any) {
  std.draw.clear(std.color.black);

  gameManager.render();

  std.draw.color(std.color.white);
  std.text.font_size(GameConfig.UI_FONT_SIZE_SMALL);
  std.text.font_name(GameConfig.UI_FONT_NAME);

  printCurrentGameState(std, gameManager.getGameStateText());
  printPlayerPoints(std, gameManager.getPlayer());
  printOpponentPoints(std, gameManager.getOpponent());

  const playerUpgrades = gameManager.getPlayer().getUpgrades();
  if (playerUpgrades.length > 0) {
    printUpgradeInfo(std, playerUpgrades);
  }

  printControls(std);

  if (GameConfig.DEBUG_MODE) {
    std.text.font_size(GameConfig.UI_FONT_SIZE_TINY);
    std.text.print(10, 10, `State: ${gameManager.getGameState()}`);
    std.text.print(10, 25, `Player Cards: ${gameManager.getPlayer().getHandCards().length}`);
    std.text.print(10, 40, `Player Points: ${gameManager.getPlayer().getMatchPoints()}`);
    std.text.print(10, 55, `Opponent Points: ${gameManager.getOpponent().getMatchPoints()}`);

    if (GameConfig.SHOW_OPPONENT_CARDS) {
      const opponentCards = gameManager.getOpponent().hand.getAllCards();
      std.text.print(10, 70, `Opponent Cards: ${opponentCards.map((c) => c.name).join(", ")}`);
    }
  }
}

function key(std: GlyStd, key) {
  if (pressed) return;

  if (std.key.press.left) {
    gameManager.handleInput("left");
  }

  if (std.key.press.right) {
    gameManager.handleInput("right");
  }

  if (std.key.press.a) {
    console.log("aaaa");
    gameManager.handleInput("action");
  }

  if (std.key.press.menu) {
    console.log("Resetting game...");
    gameManager = new GameManager(std);
  }
}

function exit(std: GlyStd, game: any) {
  console.log("Game exiting...");
}

export const config = {
  require: "http media.video",
};

export const callbacks = {
  init,
  loop,
  draw,
  exit,
  key,
};
