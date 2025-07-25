import { Card, CardDefinition } from "../entities/card";

export function createCardInstance(card: Card) {
  const cardInfo: CardDefinition = {
    id: card.id,
    name: card.name,
    texture: card.texture,
    value: card.value,
    is_special: card.is_special,
    special_effect: card.special_effect,
  };
  return new Card(cardInfo);
}
