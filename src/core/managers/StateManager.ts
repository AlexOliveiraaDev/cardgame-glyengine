export enum GameState {
  WAITING_PLAYER_TURN,
  WAITING_OPPONENT_TURN,
  PLAYER_TURN_ANIMATION,
  OPPONENT_TURN_ANIMATION,
  CALCULATING_RESULTS,
  CHOOSING_UPGRADE,
  GAME_OVER,
  GAME_MENU,
}

export class StateManager {
  private currentState: GameState;
  stateMap: Record<string, GameState> = {
    player_turn: GameState.WAITING_PLAYER_TURN,
    opponent_turn: GameState.WAITING_OPPONENT_TURN,
    player_animation: GameState.PLAYER_TURN_ANIMATION,
    opponent_animation: GameState.OPPONENT_TURN_ANIMATION,
    calculating: GameState.CALCULATING_RESULTS,
    upgrade: GameState.CHOOSING_UPGRADE,
    game_over: GameState.GAME_OVER,
    game_menu: GameState.GAME_MENU,
  };

  getCurrentState(): GameState {
    return this.currentState;
  }

  setState(state: string) {
    const mapped = this.stateMap[state];
    if (mapped === undefined) throw new Error("State Inválido");
    this.currentState = mapped;
  }
  getTextState(): String {
    switch (this.currentState) {
      case GameState.WAITING_OPPONENT_TURN:
        return "VEZ DO OPONENTE";
      case GameState.GAME_OVER:
        return "GAME OVER";
      case GameState.WAITING_PLAYER_TURN:
        return "SUA VEZ";
      case GameState.CHOOSING_UPGRADE:
        return "ESCOLHA UM UPGRADE";
    }
  }
}
