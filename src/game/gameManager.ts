import { WaitManager } from "../core/utils/waitManager";
import { Opponent } from "./opponent/opponent";
import { Player } from "./player/player";

export class GameManager {
  private stateManager;
  private inputHandler;
  private combatSystem;
  private renderSystem;
  private upgradeSystem;
  private waitManager: WaitManager;

  private player: Player;
  private opponent: Opponent;

  constructor() {
    this.waitManager = new WaitManager();
    this.player = new Player();
    this.opponent = new Opponent(50);
  }
}
