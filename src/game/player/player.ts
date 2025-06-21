import { Card, CardDefinition } from "../entity/card";
import { Hand } from "./hand";
import { UpgradeCard } from "../upgrades/upgradeCard";

export class Player {
  hand = new Hand();
  upgrades: UpgradeCard[] = [];

  getSelectedCard() {
    return this.hand.getSelectedCard();
  }

  addUpgrade(upgrade: UpgradeCard) {
    this.upgrades.push(upgrade);
  }
}
