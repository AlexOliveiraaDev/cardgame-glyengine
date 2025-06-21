import { Vector2 } from "../../core/spatial/vector2";
import { Transform } from "../../core/spatial/transform";
import { AnimationController } from "../../core/animation/animationController";

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
