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
export { assets } from "./assets";

/*####################################################################*/
/*############################  Configs  #############################*/
/*####################################################################*/

let gameManager: GameManager;
let pressed = false;
let doOnce = false;

export const meta = {
  title: "Card Game",
  author: "",
  version: "1.0.0",
  description: "",
};

function init(_: never, std: GlyStd) {
  console.log("Initializing game...");
  gameManager = new GameManager(std);
}

async function loop(_: never, std: GlyStd) {
  if (std.key.press.any) {
    pressed = true;
  } else {
    pressed = false;
  }

  gameManager.update(std.delta);
}

function draw(_: never, std: GlyStd) {
  std.image.draw("assets/bg.png", 0, 0);

  std.draw.color(std.color.white);
  std.text.font_size(GameConfig.UI_FONT_SIZE_SMALL);
  std.text.font_name(GameConfig.UI_FONT_NAME);

  printCurrentGameState(std, gameManager.getGameStateText());
  printPlayerPoints(std, gameManager.getPlayer());
  printOpponentPoints(std, gameManager.getOpponent());
  gameManager.render();
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

function key(_:never, std: GlyStd) {
  if (pressed) return;

  let keyString = "";

  if (std.key.press.left) keyString = "left";
  else if (std.key.press.right) keyString = "right";
  else if (std.key.press.up) keyString = "up";
  else if (std.key.press.down) keyString = "down";
  else if (std.key.press.a) keyString = "action";
  else if (std.key.press.menu) keyString = "menu";

  if (keyString) {
    gameManager.handleInput(keyString);
  }
}
function exit(_: never, std: GlyStd) {
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
