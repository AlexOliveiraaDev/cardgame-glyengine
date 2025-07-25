interface WaitItem {
  id: string;
  duration: number;
  elapsed: number;
  onComplete: () => void;
  onUpdate?: (progress: number) => void;
}

export class WaitManager {
  private waitQueue: WaitItem[] = [];

  addWait(config: { id: string; duration: number; onComplete: () => void; onUpdate?: (progress: number) => void }) {
    // Remove wait existente com mesmo ID
    this.removeWait(config.id);

    const waitItem: WaitItem = {
      id: config.id,
      duration: config.duration,
      elapsed: 0,
      onComplete: config.onComplete,
      onUpdate: config.onUpdate,
    };

    this.waitQueue.push(waitItem);
    console.log(`Added wait: ${config.id} for ${config.duration}s`);
  }

  removeWait(id: string) {
    const index = this.waitQueue.findIndex((item) => item.id === id);
    if (index !== -1) {
      this.waitQueue.splice(index, 1);
      console.log(`Removed wait: ${id}`);
    }
  }

  clear() {
    console.log(`Clearing ${this.waitQueue.length} waits`);
    this.waitQueue = [];
  }

  tick(deltaTime: number) {
    // Converter deltaTime de milissegundos para segundos se necessário
    const dt = deltaTime > 1 ? deltaTime / 1000 : deltaTime;

    for (let i = this.waitQueue.length - 1; i >= 0; i--) {
      const waitItem = this.waitQueue[i];
      waitItem.elapsed += dt;

      // Calcular progresso (0 a 1)
      const progress = Math.min(waitItem.elapsed / waitItem.duration, 1);

      // Chamar callback de update se existir
      if (waitItem.onUpdate) {
        waitItem.onUpdate(progress);
      }

      // Verificar se completou
      if (waitItem.elapsed >= waitItem.duration) {
        // Chamar callback de complete
        waitItem.onComplete();

        // Remover da fila
        this.waitQueue.splice(i, 1);
        console.log(`Completed wait: ${waitItem.id}`);
      }
    }
  }

  hasWait(id: string): boolean {
    return this.waitQueue.some((item) => item.id === id);
  }

  getWaitProgress(id: string): number {
    const waitItem = this.waitQueue.find((item) => item.id === id);
    if (!waitItem) return 0;

    return Math.min(waitItem.elapsed / waitItem.duration, 1);
  }

  getActiveWaits(): string[] {
    return this.waitQueue.map((item) => item.id);
  }
}
