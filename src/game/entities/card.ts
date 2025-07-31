import { GlyStd } from "@gamely/gly-types";
import { Vector2 } from "../../core/spatial/vector2";
import { GameObject } from "./gameObject";

export interface CardDefinition {
  id: string;
  name: string;
  texture: string;
  value: number;
  is_special: number;
  special_effect: number;
}

export class Card extends GameObject {
  active: boolean;
  private isUp: boolean = false;
  public name: string;
  public id: string;
  public texture: string;
  public value: number;
  public is_special: number;
  public special_effect: number;
  private std: GlyStd;

  constructor(cardInfo: CardDefinition) {
    super(new Vector2(100, 100), new Vector2(100, 100));
    this.id = cardInfo.id;
    this.name = cardInfo.name;
    this.texture = cardInfo.texture;
    this.value = cardInfo.value;
    this.is_special = cardInfo.is_special;
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

  drawCard(std: any, hide: boolean = false) {
    if (hide) {
      std.image.draw("assets/cards/Card_2.png", this.transform.position.x, this.transform.position.y);
    } else {
      std.image.draw("assets/cards/" + this.texture, this.transform.position.x, this.transform.position.y);
    }
  }

  damage(std: any) {
    let time = 0;
    const originalTexture = this.texture.toString();
    this.texture = "card_damage.png";
    while (time < 2) {
      this.drawCard(std);
      console.log("time", time);
      time += std.delta / 1000;
      console.log("texture", this.texture);
    }
    console.log("finished damage");

    this.texture = originalTexture;
  }

  testDamage(std) {
    std.image.draw("assets/cards/card_damage.png", this.transform.position.x, this.transform.position.y);
  }
}
