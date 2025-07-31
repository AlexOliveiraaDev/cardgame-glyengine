import { GlyStd } from "@gamely/gly-types";
import { Vector2 } from "../../core/spatial/vector2";
import { GameObject } from "../entities/gameObject";

export interface UpgradeCardDefinition {
  id: string;
  name: string;
  texture: string;
  special_effect: number;
}

export class UpgradeCard extends GameObject {
  active: boolean;
  private isUp: boolean = false;
  public name: string;
  public id: string;
  public texture: string;
  public special_effect: number;

  constructor(cardInfo: UpgradeCardDefinition) {
    super(new Vector2(100, 100), new Vector2(100, 100));
    this.id = cardInfo.id;
    this.name = cardInfo.name;
    this.texture = cardInfo.texture;
    this.special_effect = cardInfo.special_effect;
  }
  up() {
    console.log("card up");
    this.start({ x: this.transform.position.x, y: this.transform.position.y - 50 }, 0.5);
    this.isUp = true;
  }
  down() {
    if (!this.isUp) return;
    console.log("card down");
    this.start({ x: this.transform.position.x, y: this.transform.position.y + 50 }, 0.5);
    this.isUp = false;
  }

  drawCard(std: any) {
    std.image.draw("assets/cards/" + this.texture, this.transform.position.x, this.transform.position.y);
  }
}
