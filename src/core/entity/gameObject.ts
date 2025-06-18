import { Vector2 } from "../spatial/vector2";
import { Transform } from "../spatial/transform";
import { AnimationController } from "../animation/animationController";

export class GameObject {
  transform: Transform;
  animator: AnimationController;

  constructor(position: Vector2, scale: Vector2) {
    this.transform = new Transform(position, scale);
    this.animator = new AnimationController(this);
  }

  draw(std: any) {
    std.draw.rect(
      0,
      this.transform.position.x,
      this.transform.position.y,
      this.transform.scale.x,
      this.transform.scale.y
    );
  }

  update(dt) {
    this.animator.update(dt.delta);
  }

  start(position: Vector2, duration: number) {
    this.animator.start(position, duration);
  }
}
