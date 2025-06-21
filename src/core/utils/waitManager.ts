interface WaitAction {
  id: string;
  duration: number;
  onComplete: () => void;
  onUpdate?: (progress: number) => void;
}

export class WaitManager {
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
