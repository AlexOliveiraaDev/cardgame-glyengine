export enum GameState {
  WAITING_PLAYER_INPUT,
  PLAYER_TURN_ANIMATION,
  WAITING_ENEMY_TURN,
  ENEMY_TURN_ANIMATION,
  CALCULATING_RESULTS,
  GAME_OVER,
  CHOOSING_UPGRADE,
}

export class GameStateManager {
  private currentState: GameState;
}
