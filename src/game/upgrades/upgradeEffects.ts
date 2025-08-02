import { Card } from "../entities/card";

export function applyComboNaipes(cardHistory: Card[], value: number): number {
  const cardType = cardHistory[0].id.split("_")[0];
  let quant = 0;
  for (let i = 0; i < cardHistory.length; i++) {
    const card = cardHistory[i];
    if (card.id.split("_")[0] === cardType) quant++;
    if (i >= 3) break;
  }

  if (quant >= 3) {
    return value * 3;
  }
}

export function applyCartaMarcada() {}
