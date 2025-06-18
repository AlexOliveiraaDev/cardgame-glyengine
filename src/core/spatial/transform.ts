import { Vector2 } from "./vector2";

export class Transform {
  position: Vector2;
  scale: Vector2;
  constructor(position: Vector2, scale: Vector2) {
    this.position = position;
    this.scale = scale;
  }
}
