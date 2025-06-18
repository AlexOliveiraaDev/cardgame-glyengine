import { Vector2 } from "../spatial/vector2";
import { GameObject } from "../entity/gameObject";

export class AnimationController {
  private active = false;
  private startPosition: Vector2;
  private endPosition: Vector2;
  private duration = 0;
  private elapsed = 0;

  constructor(private obj: GameObject) {}

  start(position: Vector2, duration: number) {
    this.startPosition = this.obj.transform.position;
    this.endPosition = position;
    this.duration = duration;
    this.elapsed = 0;
    this.active = true;
  }

  update(dt) {
    if (!this.active) return;

    this.elapsed += dt / 1000;
    const t = Math.min(this.elapsed / this.duration, 1);
    const easedT = 1 - Math.pow(1 - t, 5);

    const newX = this.startPosition.x + (this.endPosition.x - this.startPosition.x) * easedT;
    const newY = this.startPosition.y + (this.endPosition.y - this.startPosition.y) * easedT;

    this.obj.transform.position.x = newX;
    this.obj.transform.position.y = newY;

    if (easedT >= 1) {
      this.active = false;
      this.obj.transform.position.x = this.endPosition.x;
      this.obj.transform.position.y = this.endPosition.y;
    }
  }
}
