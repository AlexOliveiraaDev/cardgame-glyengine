import { UpgradeCardDefinition } from "./upgradeCard";

export const UPGRADE_CARD_LIST: UpgradeCardDefinition[] = [
  {
    id: "combo_naipes",
    name: "Combo de Naipe",
    texture: "card1.png",
    special_effect: 1, // 3 cartas do mesmo naipe: 3ª carta vale o dobro
  },
  {
    id: "carta_marcada",
    name: "Carta Marcada",
    texture: "card2.png",
    special_effect: 2, // valor aleatório escolhido no início: +2 se jogar ele
  },
  {
    id: "baralho_ensanguentado",
    name: "Baralho Ensanguentado",
    texture: "card3.png",
    special_effect: 3, // 1ª carta -1, restantes +1
  },
  {
    id: "eco_inverso",
    name: "Eco Inverso",
    texture: "card4.png",
    special_effect: 4, // mesma carta em sequência: +3
  },
  {
    id: "prestigio_antigo",
    name: "Prestígio Antigo",
    texture: "card5.png",
    special_effect: 5, // valor 10 vira 14 se for carta única
  },
  {
    id: "naipe_coringa",
    name: "Naipe Coringa",
    texture: "card6.png",
    special_effect: 6, // escolhe 1 naipe, todas as cartas dele +1
  },
  {
    id: "pressagio_derrota",
    name: "Presságio de Derrota",
    texture: "card7.png",
    special_effect: 7, // após 2 derrotas seguidas, próxima carta +5
  },
  {
    id: "coracao_frio",
    name: "Coração Frio",
    texture: "card8.png",
    special_effect: 8, // cartas especiais reduzem valor normal, mas dobram progresso
  },
  {
    id: "ritual_de_tres",
    name: "Ritual de Três",
    texture: "card9.png",
    special_effect: 9, // 4 vitórias seguidas: ganha carta especial aleatória
  },
  {
    id: "ordem_implacavel",
    name: "Ordem Implacável",
    texture: "card10.png",
    special_effect: 10, // mão ordenada: +1 em todas
  },
  {
    id: "falha_controlada",
    name: "Falha Controlada",
    texture: "card11.png",
    special_effect: 11, // perder por diferença ≤1: recupera 1 carta descartada
  },
  {
    id: "aura_inflexivel",
    name: "Aura Inflexível",
    texture: "card12.png",
    special_effect: 12, // imune a descarte de cartas
  },
];
