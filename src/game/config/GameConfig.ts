export const GameConfig = {
  // Configurações das cartas
  HAND_SIZE: 7,
  CARD_WIDTH: 71,
  CARD_HEIGHT: 100,
  CARD_SPACING: 20,

  // Configurações do oponente
  DEFAULT_OPPONENT_DUMBNESS: 50,
  DUMBNESS_VARIATION: 25,

  // Configurações de upgrade
  UPGRADE_CARDS_PER_SELECTION: 4,
  UPGRADE_CARD_WIDTH: 107,
  UPGRADE_CARD_HEIGHT: 150,

  // Configurações de animação e timing
  CARD_ANIMATION_DURATION: 0.5,
  OPPONENT_THINKING_TIME: 1.0,
  RESULT_CALCULATION_TIME: 1.0,
  RESULT_DISPLAY_TIME: 1.5,

  // Configurações de mesa
  TABLE_CARD_WIDTH: 30,
  TABLE_CARD_HEIGHT: 120,
  PLAYER_CARD_OFFSET_X: -30,
  PLAYER_CARD_OFFSET_Y: 30,
  OPPONENT_CARD_OFFSET_X: 30,
  OPPONENT_CARD_OFFSET_Y: -30,

  // Texturas
  CARD_BACK_TEXTURE: "Card_2.png",
  CARD_DAMAGE_TEXTURE: "card_damage.png",

  // Configurações de UI
  UI_FONT_SIZE_LARGE: 50,
  UI_FONT_SIZE_MEDIUM: 16,
  UI_FONT_SIZE_SMALL: 12,
  UI_FONT_SIZE_TINY: 10,
  UI_FONT_NAME: "tiny.ttf",

  // Cores da UI (formato RGBA)
  UI_BACKGROUND_ALPHA: 0.7,
  UI_PLAYER_COLOR: [0, 100, 0, 0.7] as [number, number, number, number],
  UI_OPPONENT_COLOR: [100, 0, 0, 0.7] as [number, number, number, number],
  UI_INFO_COLOR: [0, 0, 0, 0.8] as [number, number, number, number],

  // Configurações de lógica do jogo
  MAX_DUPLICATE_CARDS_IN_HAND: 2,
  MAX_HIGH_VALUE_CARDS_IN_HAND: 2,
  HIGH_VALUE_CARD_THRESHOLD: 10,

  // Configurações de dificuldade do oponente
  VERY_DUMB_THRESHOLD: 70, // Joga cartas perdedoras de propósito
  MEDIUM_DUMB_THRESHOLD: 25, // Joga aleatoriamente
  // Abaixo de 25 = Inteligente (joga otimamente)

  // Configurações de efeitos especiais
  SPECIAL_EFFECTS: {
    JACK: 1, // Efeito do Valete
    QUEEN: 2, // Efeito da Dama
    KING: 3, // Efeito do Rei
    RED_JOKER: 4, // Efeito do Coringa Vermelho
    BLACK_JOKER: 5, // Efeito do Coringa Preto
  },

  // Configurações de upgrade effects
  UPGRADE_EFFECTS: {
    COMBO_NAIPES: 1, // 3 cartas do mesmo naipe: 3ª carta vale o dobro
    CARTA_MARCADA: 2, // valor aleatório escolhido no início: +2 se jogar ele
    BARALHO_ENSANGUENTADO: 3, // 1ª carta -1, restantes +1
    ECO_INVERSO: 4, // mesma carta em sequência: +3
    PRESTIGIO_ANTIGO: 5, // valor 10 vira 14 se for carta única
    NAIPE_CORINGA: 6, // escolhe 1 naipe, todas as cartas dele +1
    PRESSAGIO_DERROTA: 7, // após 2 derrotas seguidas, próxima carta +5
    CORACAO_FRIO: 8, // cartas especiais reduzem valor normal, mas dobram progresso
    RITUAL_DE_TRES: 9, // 4 vitórias seguidas: ganha carta especial aleatória
    ORDEM_IMPLACAVEL: 10, // mão ordenada: +1 em todas
    FALHA_CONTROLADA: 11, // perder por diferença ≤1: recupera 1 carta descartada
    AURA_INFLEXIVEL: 12, // imune a descarte de cartas
  },

  // Configurações de debug
  DEBUG_MODE: false,
  SHOW_OPPONENT_CARDS: false,
  LOG_CARD_SELECTIONS: true,
  LOG_UPGRADE_EFFECTS: true,
};
