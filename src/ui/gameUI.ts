import { GlyStd } from "@gamely/gly-types";
import { Player } from "../game/entities/Player";
import { Opponent } from "../game/entities/Opponent";

export function printCurrentGameState(std: GlyStd, gameStateText: string) {
  const x = std.app.width / 2 - gameStateText.length * 4;
  const y = 50;

  std.draw.color(std.color.white);
  std.text.font_size(18);
  std.text.print(x, y, gameStateText);
}

export function printPlayerPoints(std: GlyStd, player: Player) {
  const text = `Player: ${player.getMatchPoints()} pontos`;
  const x = 20;
  const y = std.app.height - 80;

  std.draw.color(0x006400b3);
  std.draw.rect(0, x - 5, y - 5, text.length * 7 + 10, 20);

  // Texto
  std.draw.color(std.color.white);
  std.text.font_size(12);
  std.text.print(x, y, text);

  // Mostrar cartas restantes
  const cardsText = `Cartas: ${player.getHandCards().length}`;
  std.text.print(x, y + 25, cardsText);
}

export function printOpponentPoints(std: GlyStd, opponent: Opponent) {
  const text = `Opponent: ${opponent.matchPoints} pontos`;
  const x = std.app.width - text.length * 7 - 20;
  const y = std.app.height - 80;

  // Fundo
  std.draw.color(0x640000b3);
  std.draw.rect(0, x - 5, y - 5, text.length * 7 + 10, 20);

  // Texto
  std.draw.color(std.color.white);
  std.text.font_size(12);
  std.text.print(x, y, text);

  // Mostrar cartas restantes
  const cardsText = `Cartas: ${opponent.hand.getAllCards().length}`;
  std.text.print(x, y + 25, cardsText);
}

export function printUpgradeInfo(std: GlyStd, upgrades: any[]) {
  if (upgrades.length === 0) return;

  const x = 20;
  const y = 100;

  // Título
  std.draw.color(0xffffffff);
  std.text.font_size(14);
  std.text.print(x, y, "Upgrades Ativos:");

  // Lista de upgrades
  upgrades.forEach((upgrade, index) => {
    const upgradeY = y + 20 + index * 15;
    std.text.font_size(10);
    std.text.print(x + 10, upgradeY, `• ${upgrade.name}`);
  });
}

export function printControls(std: GlyStd) {
  const controls = ["← → : Navegar", "A/Enter : Selecionar", "R : Reset (Debug)"];

  const x = std.app.width - 150;
  const y = 20;

  // Fundo
  std.draw.color(0x000000cc);
  std.draw.rect(0, x - 10, y - 5, 160, controls.length * 15 + 10);

  // Controles
  std.draw.color(0xffffffff);
  std.text.font_size(10);
  controls.forEach((control, index) => {
    std.text.print(x, y + index * 15, control);
  });
}

export function printCardInfo(std: GlyStd, card: any, x: number, y: number) {
  if (!card) return;

  const info = [`Nome: ${card.name}`, `Valor: ${card.value}`, card.is_special ? "Especial: Sim" : "Especial: Não"];

  // Fundo
  std.draw.color(0x000000e6);
  std.draw.rect(0, x - 5, y - 5, 120, info.length * 12 + 10);

  // Informações
  std.draw.color(0xffffffff);
  std.text.font_size(9);
  info.forEach((text, index) => {
    std.text.print(x, y + index * 12, text);
  });
}
