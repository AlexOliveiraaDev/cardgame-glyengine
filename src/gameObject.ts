// export interface Vector2 {
//   x: number;
//   y: number;
// }

// class Transform {
//   position: Vector2;
//   scale: Vector2;
// }

// export class GameObject {
//   transform: Transform = { position: { x: 0, y: 0 }, scale: { x: 0, y: 0 } };
//   animator: AnimationController;

//   constructor(position: Vector2, scale: Vector2) {
//     this.transform.position = position;
//     this.transform.scale = scale;
//     this.animator = new AnimationController(this);
//   }

//   draw(std: any) {
//     std.draw.rect(
//       0,
//       this.transform.position.x,
//       this.transform.position.x,
//       this.transform.scale.x,
//       this.transform.scale.y
//     );
//   }

//   update(dt) {
//     this.animator.update(dt);
//   }

//   start(position: Vector2, duration: number) {
//     this.animator.start(position, duration);
//   }
// }

// class AnimationController {
//   private active = false;
//   private startPosition: Vector2 = { x: 0, y: 0 };
//   private endPosition: Vector2 = { x: 0, y: 0 };
//   private duration = 0;
//   private elapsed = 0;

//   constructor(private obj: GameObject) {}

//   start(position: Vector2, duration: number) {
//     this.startPosition = this.obj.transform.position;
//     this.endPosition = position;
//     this.duration = duration;
//     this.elapsed = 0;
//     this.active = true;
//   }

//   update(dt) {
//     if (!this.active) return;
//     this.elapsed += dt / 1000;
//     const t = Math.min(this.elapsed / this.duration, 1);
//     const easedT = 1 - Math.pow(1 - t, 5);
//     this.obj.transform.position.x = this.startPosition.x + (this.endPosition.x - this.startPosition.x) * easedT;
//     this.obj.transform.position.y = this.startPosition.y + (this.endPosition.y - this.startPosition.y) * easedT;

//     if (easedT >= 1) {
//       this.active = false;
//       this.obj.transform.position.x = this.endPosition.x;
//       this.obj.transform.position.y = this.endPosition.y;
//     }
//   }
// }
