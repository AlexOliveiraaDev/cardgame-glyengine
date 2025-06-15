import { GlyStd, GlyStdNano } from "@gamely/gly-types";

/*####################################################################*/
/*############################  Configs  #############################*/
/*####################################################################*/

export const title = "Gly Engine Gamejam";
export const author = "Alex Oliveira";
export const version = "1.0.0";
export const description = "The best game in the world made in GlyEngine";
export const assets = [
  "src/card1.png:card1.png",
  "src/card2.png:card2.png",
  "src/card3.png:card3.png",
  "src/card4.png:card4.png",
];

const CARD_LIST: CardDefinition[] = [
  { id: "emperor", name: "Emperor", texture: "card1.png" },
  { id: "high_priestess", name: "High Priestess", texture: "card2.png" },
  { id: "sun", name: "Sun", texture: "card3.png" },
  { id: "magician", name: "Magician", texture: "card4.png" },
];

/*####################################################################*/
/*############################  Classes  #############################*/
/*####################################################################*/

class Vector2 {
  constructor(public x: number, public y: number) {}
}

class Transform {
  position: Vector2;
  scale: Vector2;
  constructor(position: Vector2, scale: Vector2) {
    this.position = position;
    this.scale = scale;
  }
}

class GameObject {
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
    this.animator.update(dt);
  }

  start(position: Vector2, duration: number) {
    this.animator.start(position, duration);
  }
}

class AnimationController {
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
    this.obj.transform.position.x = this.startPosition.x + (this.endPosition.x - this.startPosition.x) * easedT;
    this.obj.transform.position.y = this.startPosition.y + (this.endPosition.y - this.startPosition.y) * easedT;

    if (easedT >= 1) {
      this.active = false;
      this.obj.transform.position.x = this.endPosition.x;
      this.obj.transform.position.y = this.endPosition.y;
    }
  }
}

class Card extends GameObject {
  active: boolean;
  private isUp: boolean = false;
  public name: string;
  public id: string;
  private texture: string;
  constructor(cardInfo: CardDefinition) {
    super(new Vector2(100, 100), new Vector2(100, 100));
    this.id = cardInfo.id;
    this.name = cardInfo.name;
    this.texture = cardInfo.texture;
  }
  up() {
    this.start({ x: this.transform.position.x, y: this.transform.position.y - 50 }, 0.5);
    this.isUp = true;
  }
  down() {
    if (!this.isUp) return;
    this.start({ x: this.transform.position.x, y: this.transform.position.y + 50 }, 0.5);
    this.isUp = false;
  }

  drawCard(std: any) {
    std.draw.image(this.texture, this.transform.position.x, this.transform.position.y);
  }
}

interface CardDefinition {
  id: string;
  name: string;
  texture: string;
}

class Hand {
  private cards: Card[] = [];
  selectedCard = 0;
  generateNewHand() {
    console.log("# Generating New Hand #");
    let newCard: Card = undefined;
    for (let i = 0; i < 3; i++) {
      newCard = this.getNewCard();
      console.log("Get card with success:", newCard);
      let cardCount = 0;
      for (let n = 0; n < this.cards.length; n++) {
        if (cardCount == 2) break;
        const card = this.cards[n];
        if (card.id === newCard.id) cardCount++;
      }
      if (cardCount >= 2) {
        let reserveCard = this.getNewCard();
        while (newCard.id === reserveCard.id) {
          reserveCard = this.getNewCard();
        }

        this.cards.push(reserveCard);
      } else {
        this.cards.push(newCard);
      }
    }
    console.log("Finished generating new hand!");
  }
  getNewCard() {
    console.log("Generating Card...");
    return new Card(CARD_LIST[Math.floor(Math.random() * CARD_LIST.length)]);
  }
  drawHandCards(std: GlyStd) {
    this.cards.forEach((card) => {
      card.drawCard(std);
    });
  }
  updateState(std: GlyStd) {
    this.cards.forEach((card) => {
      card.update(std);
    });
  }
  setCardsPosition(screenWidth: number, screenHeight: number) {
    let newPosition: Vector2 = new Vector2(0, 0);
    const spacing = 50;
    const cardWidth = 126;
    const cardHeight = 186;
    const totalWidth = this.cards.length * spacing + (this.cards.length - 1) * cardWidth;
    let x = (screenWidth - totalWidth) / 2;

    this.cards.forEach((card) => {
      card.transform.position = new Vector2(x, screenHeight - cardHeight - spacing);
      x += 160;
    });
  }
}

/*####################################################################*/
/*######################  LOGICA DO JOGO  ############################*/
/*####################################################################*/

const hand = new Hand();

function init(std: GlyStd, game: any) {
  hand.generateNewHand();
  hand.setCardsPosition(game.width, game.height);
}

function loop(std: GlyStd, game: any) {
  hand.updateState(std);
}

function draw(std: GlyStd, game: any) {
  std.draw.clear(std.color.black);
  hand.drawHandCards(std);
}

function exit(std: GlyStd, game: any) {}

export { init, loop, draw, exit };
