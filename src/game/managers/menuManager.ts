// MenuManager.ts
import { GlyStd } from "@gamely/gly-types";
import { WaitManager } from "../../core/utils/waitManager";
import { GameConfig } from "../config/GameConfig";

export enum MenuState {
  MAIN_MENU = "MAIN_MENU",
  TUTORIAL = "TUTORIAL",
  CREDITS = "CREDITS",
  GAME = "GAME",
}

export enum TutorialStep {
  WELCOME = 0,
  GAME_OVERVIEW = 1,
  HAND_BASICS = 2,
  CARD_SELECTION = 3,
  TURN_SYSTEM = 4,
  COMBAT_ATTACK = 5,
  COMBAT_RESPONSE = 6,
  SCORING_SYSTEM = 7,
  CARD_VALUES = 8,
  STRATEGY_TIPS = 9,
  UPGRADES_INTRO = 10,
  UPGRADES_EFFECTS = 11,
  WIN_CONDITIONS = 12,
  COMPLETE = 13,
}

export class MenuManager {
  private std: GlyStd;
  private waitManager: WaitManager;

  public menuState: MenuState = MenuState.MAIN_MENU;
  public tutorialStep: TutorialStep = TutorialStep.WELCOME;

  // Menu principal
  private mainMenuOptions = ["Jogar", "Tutorial", "Créditos"];
  private selectedMainOption = 0;

  // Tutorial expandido
  private tutorialTexts = [
    // WELCOME
    {
      title: "Bem-vindo ao Card Game!",
      content: [
        "Este é um jogo de cartas estratégico onde você",
        "enfrenta um oponente inteligente em batalhas",
        "táticas usando cartas numeradas.",
        "",
        "Prepare-se para uma experiência que combina",
        "estratégia, timing e um pouco de sorte!",
        "",
        "Use ← → para navegar nos menus",
        "Pressione A para confirmar",
        "",
        "Pressione A para começar o tutorial...",
      ],
    },
    // GAME_OVERVIEW
    {
      title: "Visão Geral do Jogo",
      content: [
        "OBJETIVO:",
        "Ganhe mais pontos que seu oponente",
        "ao final de todas as rodadas!",
        "",
        "ELEMENTOS PRINCIPAIS:",
        "• Sua mão: 5 cartas com valores únicos",
        "• Mesa: onde as cartas são jogadas",
        "• Pontuação: quem ganha mais rodadas vence",
        "• Upgrades: poderes especiais obtidos",
        "",
        "Pressione A para continuar...",
      ],
    },
    // HAND_BASICS
    {
      title: "Sua Mão de Cartas",
      content: [
        "Você começa cada partida com 5 cartas",
        "na sua mão, cada uma com um valor diferente.",
        "",
        "CARACTERÍSTICAS DAS CARTAS:",
        "• Valores de 1 a 13 (como cartas normais)",
        "• Diferentes naipes: ♠ ♥ ♦ ♣",
        "• Algumas podem ter efeitos especiais",
        "",
        "Sua mão fica na parte inferior da tela,",
        "sempre visível para você planejar sua estratégia.",
        "",
        "Pressione A para continuar...",
      ],
    },
    // CARD_SELECTION
    {
      title: "Selecionando Cartas",
      content: [
        "NAVEGAÇÃO:",
        "• Use ← → para escolher entre suas cartas",
        "• A carta selecionada fica destacada (sobe)",
        "• Pressione A para jogar a carta escolhida",
        "",
        "DICA IMPORTANTE:",
        "Uma vez jogada, você não pode recuperar",
        "a carta! Pense bem antes de confirmar.",
        "",
        "O oponente não vê qual carta você",
        "selecionou até você jogar.",
        "",
        "Pressione A para continuar...",
      ],
    },
    // TURN_SYSTEM
    {
      title: "Sistema de Turnos Alternados",
      content: [
        "O jogo usa um sistema de ATAQUE e RESPOSTA:",
        "",
        "RODADA ÍMPAR (1, 3, 5...):",
        "→ Você ataca primeiro",
        "→ Oponente responde vendo sua carta",
        "",
        "RODADA PAR (2, 4, 6...):",
        "→ Oponente ataca primeiro",
        "→ Você responde vendo a carta dele",
        "",
        "VANTAGEM DE ATACAR:",
        "O defensor vê a carta do atacante antes",
        "de escolher sua resposta!",
        "",
        "Pressione A para continuar...",
      ],
    },
    // COMBAT_ATTACK
    {
      title: "Fase de Ataque",
      content: [
        "Quando você ATACA primeiro:",
        "",
        "1. Escolha sua carta sem ver a do oponente",
        "2. Sua carta é revelada na mesa",
        "3. O oponente vê sua carta",
        "4. Oponente escolhe sua resposta",
        "5. Cartas são comparadas",
        "",
        "ESTRATÉGIA:",
        "• Cartas altas: mais chances de ganhar",
        "• Cartas médias: podem surpreender",
        "• Cartas baixas: economize as altas!",
        "",
        "Pressione A para continuar...",
      ],
    },
    // COMBAT_RESPONSE
    {
      title: "Fase de Resposta",
      content: [
        "Quando você RESPONDE a um ataque:",
        "",
        "1. Oponente joga primeira carta",
        "2. Você vê o valor da carta dele",
        "3. Escolha sua melhor resposta",
        "4. Cartas são comparadas",
        "",
        "VANTAGEM DA RESPOSTA:",
        "• Você sabe exatamente o que precisa",
        "• Pode usar a menor carta que ganhe",
        "• Ou jogar carta baixa se não pode ganhar",
        "",
        "Esta informação é CRUCIAL para vencer!",
        "",
        "Pressione A para continuar...",
      ],
    },
    // SCORING_SYSTEM
    {
      title: "Sistema de Pontuação",
      content: [
        "COMO GANHAR PONTOS:",
        "",
        "✓ Carta com MAIOR valor ganha a rodada",
        "✓ Ganhador recebe 1 ponto de partida",
        "✓ Em caso de empate: ninguém ganha ponto",
        "",
        "FIM DE PARTIDA:",
        "Quando todas as cartas acabam (5 rodadas),",
        "quem tiver mais pontos VENCE a partida!",
        "",
        "Possível: 3x2, 4x1, 5x0, ou até 0x0",
        "",
        "Pressione A para continuar...",
      ],
    },
    // CARD_VALUES
    {
      title: "Valores e Naipes das Cartas",
      content: [
        "VALORES DAS CARTAS:",
        "• Ás = 1 (menor valor)",
        "• Números = 2, 3, 4, 5, 6, 7, 8, 9, 10",
        "• Valete = 11",
        "• Dama = 12",
        "• Rei = 13 (maior valor)",
        "",
        "NAIPES:",
        "♠ Espadas, ♥ Copas, ♦ Ouros, ♣ Paus",
        "",
        "IMPORTANTE: Naipes podem ativar combos",
        "especiais com certos upgrades!",
        "",
        "Pressione A para continuar...",
      ],
    },
    // STRATEGY_TIPS
    {
      title: "Dicas Estratégicas",
      content: [
        "GERENCIAMENTO DE RECURSOS:",
        "• Não desperdice cartas altas cedo demais",
        "• Guarde Reis (13) para momentos críticos",
        "• Use cartas baixas quando souber que vai perder",
        "",
        "LEITURA DO OPONENTE:",
        "• Observe quais cartas ele já jogou",
        "• Estime que cartas ainda tem na mão",
        "• Adapte sua estratégia ao comportamento dele",
        "",
        "TIMING É TUDO!",
        "",
        "Pressione A para continuar...",
      ],
    },
    // UPGRADES_INTRO
    {
      title: "Sistema de Upgrades",
      content: [
        "Ao VENCER uma partida completa, você",
        "pode escolher um UPGRADE especial!",
        "",
        "COMO FUNCIONA:",
        "• Aparecem 3 opções de upgrade",
        "• Use ← → para navegar",
        "• Pressione A para escolher",
        "",
        "PERMANÊNCIA:",
        "Upgrades são permanentes e se acumulam!",
        "Cada vitória = novo upgrade adquirido.",
        "",
        "Estratégia evolui conforme você progride!",
        "",
        "Pressione A para continuar...",
      ],
    },
    // UPGRADES_EFFECTS
    {
      title: "Efeitos dos Upgrades",
      content: [
        "EXEMPLO - COMBO DE NAIPES:",
        "",
        "Se você jogar 3 cartas consecutivas",
        "do mesmo naipe (♠♠♠ ou ♥♥♥), a terceira",
        "carta tem seu valor DOBRADO!",
        "",
        "Exemplo: Rei de Copas (13) vira 26!",
        "",
        "OUTROS UPGRADES:",
        "Cada upgrade oferece diferentes",
        "vantagens táticas. Experimente",
        "combinações para criar sua estratégia ideal!",
        "",
        "Pressione A para continuar...",
      ],
    },
    // WIN_CONDITIONS
    {
      title: "Condições de Vitória",
      content: [
        "PARA VENCER UMA PARTIDA:",
        "• Ganhe mais rodadas que o oponente",
        "• Máximo: 5 rodadas por partida",
        "• Mínimo para vencer: 3 rodadas",
        "",
        "PROGRESSÃO NO JOGO:",
        "• Vitória = Escolha de upgrade",
        "• Derrota = Game Over (volta ao menu)",
        "• Cada partida fica mais desafiadora",
        "",
        "OBJETIVO FINAL:",
        "Colete upgrades e desenvolva a",
        "estratégia perfeita para dominar!",
        "",
        "Pressione A para finalizar tutorial...",
      ],
    },
  ];

  private tutorialAnimTime = 0;
  private creditsAnimTime = 0;

  constructor(std: GlyStd) {
    this.std = std;
    this.waitManager = new WaitManager();
  }

  public handleInput(key: string): boolean {
    switch (this.menuState) {
      case MenuState.MAIN_MENU:
        return this.handleMainMenuInput(key);
      case MenuState.TUTORIAL:
        return this.handleTutorialInput(key);
      case MenuState.CREDITS:
        return this.handleCreditsInput(key);
      default:
        return false;
    }
  }

  private handleMainMenuInput(key: string): boolean {
    switch (key) {
      case "up":
      case "left":
        if (this.selectedMainOption > 0) {
          this.selectedMainOption--;
        }
        return true;
      case "down":
      case "right":
        if (this.selectedMainOption < this.mainMenuOptions.length - 1) {
          this.selectedMainOption++;
        }
        return true;
      case "action":
        this.selectMainMenuOption();
        return true;
    }
    return false;
  }

  private handleTutorialInput(key: string): boolean {
    switch (key) {
      case "action":
        if (this.tutorialStep < TutorialStep.COMPLETE) {
          this.tutorialStep++;
          if (this.tutorialStep === TutorialStep.COMPLETE) {
            this.menuState = MenuState.MAIN_MENU;
            this.tutorialStep = TutorialStep.WELCOME;
          }
        }
        return true;
      case "menu":
        this.menuState = MenuState.MAIN_MENU;
        this.tutorialStep = TutorialStep.WELCOME;
        return true;
      case "left":
        // Permitir voltar no tutorial
        if (this.tutorialStep > TutorialStep.WELCOME) {
          this.tutorialStep--;
        }
        return true;
      case "right":
        // Permitir avançar no tutorial
        if (this.tutorialStep < TutorialStep.COMPLETE) {
          this.tutorialStep++;
          if (this.tutorialStep === TutorialStep.COMPLETE) {
            this.menuState = MenuState.MAIN_MENU;
            this.tutorialStep = TutorialStep.WELCOME;
          }
        }
        return true;
    }
    return false;
  }

  private handleCreditsInput(key: string): boolean {
    switch (key) {
      case "menu":
      case "action":
        this.menuState = MenuState.MAIN_MENU;
        return true;
    }
    return false;
  }

  private selectMainMenuOption() {
    switch (this.selectedMainOption) {
      case 0: // Jogar
        this.menuState = MenuState.GAME;
        break;
      case 1: // Tutorial
        this.menuState = MenuState.TUTORIAL;
        this.tutorialStep = TutorialStep.WELCOME;
        break;
      case 2: // Créditos
        this.menuState = MenuState.CREDITS;
        break;
    }
  }

  public update(dt: number) {
    this.waitManager.tick(dt);

    // Atualizar animações baseadas no tempo
    if (this.menuState === MenuState.TUTORIAL) {
      this.tutorialAnimTime += dt / 1000;
    }

    if (this.menuState === MenuState.CREDITS) {
      this.creditsAnimTime += dt / 1000;
    }

    // Reset do tempo de animação para evitar overflow
    if (this.tutorialAnimTime > 1000) {
      this.tutorialAnimTime = 0;
    }

    if (this.creditsAnimTime > 1000) {
      this.creditsAnimTime = 0;
    }
  }

  public render() {
    switch (this.menuState) {
      case MenuState.MAIN_MENU:
        this.renderMainMenu();
        break;
      case MenuState.TUTORIAL:
        this.renderTutorial();
        break;
      case MenuState.CREDITS:
        this.renderCredits();
        break;
    }
  }

  private renderMainMenu() {
    const centerX = this.std.app.width / 2;
    const centerY = this.std.app.height / 2;
    const time = this.tutorialAnimTime;

    // Background gradiente simulado
    this.std.draw.color(this.std.color.black);
    this.std.draw.rect(0, 0, 0, this.std.app.width, this.std.app.height);

    // Camadas de fundo para criar profundidade
    this.std.draw.color(this.std.color.darkpurple);
    this.std.draw.rect(0, 0, 0, this.std.app.width, this.std.app.height / 3);

    this.std.draw.color(this.std.color.maroon);
    this.std.draw.rect(0, 0, (this.std.app.height * 2) / 3, this.std.app.width, this.std.app.height / 3);

    // Decorações de fundo - cartões flutuantes
    for (let i = 0; i < 5; i++) {
      const offsetX = Math.sin(time + i) * 20;
      const offsetY = Math.cos(time * 0.5 + i) * 15;
      const cardX = 100 + i * 200 + offsetX;
      const cardY = 150 + offsetY;

      this.std.draw.color(this.std.color.darkgray);
      this.std.draw.rect(0, cardX, cardY, 60, 80);
      this.std.draw.color(this.std.color.lightgray);
      this.std.draw.rect(1, cardX, cardY, 60, 80);
    }

    // Caixa principal do menu com bordas elegantes
    const menuBoxWidth = 400;
    const menuBoxHeight = 350;
    const boxX = centerX - menuBoxWidth / 2;
    const boxY = centerY - menuBoxHeight / 2;

    // Sombra da caixa
    this.std.draw.color(this.std.color.black);
    this.std.draw.rect(0, boxX + 8, boxY + 8, menuBoxWidth, menuBoxHeight);

    // Caixa principal
    this.std.draw.color(this.std.color.darkblue);
    this.std.draw.rect(0, boxX, boxY, menuBoxWidth, menuBoxHeight);

    // Borda dourada
    this.std.draw.color(this.std.color.gold);
    this.std.draw.rect(1, boxX, boxY, menuBoxWidth, menuBoxHeight);
    this.std.draw.rect(1, boxX + 4, boxY + 4, menuBoxWidth - 8, menuBoxHeight - 8);

    // Título do jogo com efeito brilhante
    this.std.text.font_size(52);
    this.std.text.font_name(GameConfig.UI_FONT_NAME);

    // Sombra do título
    this.std.draw.color(this.std.color.black);
    this.std.text.print_ex(centerX + 3, centerY - 130 + 3, "CARD GAME", 0, 0);

    // Título principal com efeito pulsante
    const titlePulse = 1 + Math.sin(time * 2) * 0.05;
    this.std.text.font_size(52 * titlePulse);
    this.std.draw.color(this.std.color.gold);
    this.std.text.print_ex(centerX, centerY - 130, "CARD GAME", 0, 0);

    // Subtítulo com cor variável
    this.std.text.font_size(18);
    const subtitleColor = Math.sin(time) > 0 ? this.std.color.skyblue : this.std.color.lightgray;
    this.std.draw.color(subtitleColor);
    this.std.text.print_ex(centerX, centerY - 95, "⚔️ Estratégia • Fortuna • Vitória ⚔️", 0, 0);

    // Linha decorativa
    this.std.draw.color(this.std.color.gold);
    this.std.draw.line(centerX - 100, centerY - 75, centerX + 100, centerY - 75);

    // Opções do menu com design moderno
    this.std.text.font_size(26);
    const startY = centerY - 30;
    const spacing = 50;

    for (let i = 0; i < this.mainMenuOptions.length; i++) {
      const y = startY + i * spacing;
      const optionWidth = 250;
      const optionHeight = 40;
      const optionX = centerX - optionWidth / 2;
      const optionY = y - optionHeight / 2;

      if (i === this.selectedMainOption) {
        // Opção selecionada - caixa destacada
        this.std.draw.color(this.std.color.gold);
        this.std.draw.rect(0, optionX - 5, optionY - 5, optionWidth + 10, optionHeight + 10);

        this.std.draw.color(this.std.color.darkblue);
        this.std.draw.rect(0, optionX, optionY, optionWidth, optionHeight);

        // Bordas internas brilhantes
        this.std.draw.color(this.std.color.yellow);
        this.std.draw.rect(1, optionX + 2, optionY + 2, optionWidth - 4, optionHeight - 4);

        // Ícones decorativos
        this.std.draw.color(this.std.color.yellow);
        this.std.text.print_ex(optionX + 20, y, "►", 0, 0);
        this.std.text.print_ex(optionX + optionWidth - 20, y, "◄", 0, 0);

        // Texto da opção
        this.std.draw.color(this.std.color.white);
        this.std.text.print_ex(centerX, y, this.mainMenuOptions[i], 0, 0);

        // Efeito de brilho animado nas bordas
        if (Math.sin(time * 6) > 0.5) {
          this.std.draw.color(this.std.color.white);
          this.std.draw.rect(1, optionX, optionY, optionWidth, optionHeight);
        }
      } else {
        // Opção não selecionada - estilo sutil
        this.std.draw.color(this.std.color.gray);
        this.std.draw.rect(1, optionX + 10, optionY + 5, optionWidth - 20, optionHeight - 10);

        this.std.draw.color(this.std.color.lightgray);
        this.std.text.print_ex(centerX, y, this.mainMenuOptions[i], 0, 0);
      }
    }

    // Área de instruções estilizada
    const instructionY = this.std.app.height - 80;
    this.std.draw.color(this.std.color.darkgray);
    this.std.draw.rect(0, 50, instructionY - 10, this.std.app.width - 100, 60);

    this.std.draw.color(this.std.color.skyblue);
    this.std.draw.rect(1, 50, instructionY - 10, this.std.app.width - 100, 60);

    // Instruções com ícones
    this.std.text.font_size(16);
    this.std.draw.color(this.std.color.white);
    this.std.text.print_ex(centerX, instructionY + 10, "🎮 Use ← → para navegar • Pressione A para selecionar", 0, 0);
    this.std.text.print_ex(centerX, instructionY + 30, "📱 MENU para resetar jogo", 0, 0);

    // Versão do jogo no canto
    this.std.text.font_size(12);
    this.std.draw.color(this.std.color.gray);
    this.std.text.print_ex(this.std.app.width - 80, this.std.app.height - 20, "v1.0.0", 0, 0);

    // Efeitos de partículas simuladas
    for (let i = 0; i < 8; i++) {
      const particleX = (centerX + Math.sin(time + i * 0.8) * 200) % this.std.app.width;
      const particleY = (100 + Math.cos(time * 0.7 + i) * 50) % this.std.app.height;

      if (Math.sin(time * 2 + i) > 0.7) {
        this.std.draw.color(this.std.color.gold);
        this.std.text.font_size(8);
        this.std.text.print_ex(particleX, particleY, "✦", 0, 0);
      }
    }
  }

  private renderTutorial() {
    const centerX = this.std.app.width / 2;
    const centerY = this.std.app.height / 2;
    const time = this.tutorialAnimTime;

    // Background gradiente
    this.std.draw.color(this.std.color.darkgreen);
    this.std.draw.rect(0, 0, 0, this.std.app.width, this.std.app.height);

    // Overlay escuro nas bordas
    this.std.draw.color(this.std.color.black);
    this.std.draw.rect(0, 0, 0, this.std.app.width, 60);
    this.std.draw.rect(0, 0, this.std.app.height - 60, this.std.app.width, 60);

    // Painel principal do tutorial com design elegante
    const panelWidth = this.std.app.width - 120;
    const panelHeight = this.std.app.height - 180;
    const panelX = centerX - panelWidth / 2;
    const panelY = centerY - panelHeight / 2;

    // Sombra do painel
    this.std.draw.color(this.std.color.black);
    this.std.draw.rect(0, panelX + 6, panelY + 6, panelWidth, panelHeight);

    // Painel principal
    this.std.draw.color(this.std.color.white);
    this.std.draw.rect(0, panelX, panelY, panelWidth, panelHeight);

    // Borda decorativa
    this.std.draw.color(this.std.color.darkgreen);
    this.std.draw.rect(1, panelX + 2, panelY + 2, panelWidth - 4, panelHeight - 4);

    // Header do tutorial
    const headerHeight = 80;
    this.std.draw.color(this.std.color.darkgreen);
    this.std.draw.rect(0, panelX + 2, panelY + 2, panelWidth - 4, headerHeight);

    const currentTutorial = this.tutorialTexts[this.tutorialStep];

    // Título com efeito especial
    this.std.text.font_size(32);
    this.std.draw.color(this.std.color.gold);
    this.std.text.print_ex(centerX, panelY + 35, currentTutorial.title, 0, 0);

    // Linha separadora animada
    const lineWidth = Math.abs(Math.sin(time * 2)) * 200 + 100;
    this.std.draw.color(this.std.color.gold);
    this.std.draw.line(centerX - lineWidth / 2, panelY + 55, centerX + lineWidth / 2, panelY + 55);

    // Conteúdo do tutorial
    this.std.text.font_size(18);
    const contentStartY = panelY + 100;
    const lineHeight = 25;

    for (let i = 0; i < currentTutorial.content.length; i++) {
      const y = contentStartY + i * lineHeight;
      const line = currentTutorial.content[i];

      // Sistema de cores mais sofisticado
      if (
        line.includes("OBJETIVO:") ||
        line.includes("COMO FUNCIONA:") ||
        line.includes("VANTAGEM:") ||
        line.includes("IMPORTANTE:") ||
        line.includes("ESTRATÉGIA:") ||
        line.includes("DICA:")
      ) {
        this.std.draw.color(this.std.color.maroon);
        this.std.text.font_size(22);
      } else if (line.startsWith("•") || line.startsWith("→") || line.startsWith("✓")) {
        this.std.draw.color(this.std.color.darkblue);
        this.std.text.font_size(18);
      } else if (
        line.includes("RODADA") ||
        line.includes("ELEMENTOS") ||
        line.includes("CARACTERÍSTICAS") ||
        line.includes("PERMANÊNCIA:") ||
        line.includes("NAVEGAÇÃO:") ||
        line.includes("PROGRESSÃO:")
      ) {
        this.std.draw.color(this.std.color.purple);
        this.std.text.font_size(19);
      } else if (line === "" || line.trim() === "") {
        continue; // Pular linhas vazias
      } else {
        this.std.draw.color(this.std.color.black);
        this.std.text.font_size(18);
      }

      this.std.text.print_ex(centerX, y, line, 0, 0);
    }

    // Footer do painel
    const footerY = panelY + panelHeight - 70;
    this.std.draw.color(this.std.color.lightgray);
    this.std.draw.rect(0, panelX + 2, footerY, panelWidth - 4, 68);

    // Indicador de progresso sofisticado
    this.std.text.font_size(16);
    this.std.draw.color(this.std.color.darkgreen);
    const progressText = `Página ${this.tutorialStep + 1} de ${this.tutorialTexts.length}`;
    this.std.text.print_ex(this.std.app.width - 120, footerY + 20, progressText, 0, 0);

    // Barra de progresso moderna
    const progressBarWidth = 300;
    const progressBarHeight = 12;
    const progressBarX = centerX - progressBarWidth / 2;
    const progressBarY = footerY + 15;

    // Fundo da barra
    this.std.draw.color(this.std.color.darkgray);
    this.std.draw.rect(0, progressBarX, progressBarY, progressBarWidth, progressBarHeight);

    // Progresso atual
    const progressWidth = (progressBarWidth * (this.tutorialStep + 1)) / this.tutorialTexts.length;
    this.std.draw.color(this.std.color.green);
    this.std.draw.rect(0, progressBarX, progressBarY, progressWidth, progressBarHeight);

    // Borda da barra
    this.std.draw.color(this.std.color.gold);
    this.std.draw.rect(1, progressBarX, progressBarY, progressBarWidth, progressBarHeight);

    // Marcadores de seção na barra
    for (let i = 1; i < this.tutorialTexts.length; i++) {
      const markerX = progressBarX + (progressBarWidth * i) / this.tutorialTexts.length;
      this.std.draw.color(this.std.color.white);
      this.std.draw.line(markerX, progressBarY, markerX, progressBarY + progressBarHeight);
    }

    // Botão de continuar com animação pulsante
    const buttonY = footerY + 45;
    const buttonPulse = 1 + Math.sin(time * 4) * 0.1;

    if (Math.sin(time * 3) > 0) {
      this.std.draw.color(this.std.color.gold);
      this.std.text.font_size(22 * buttonPulse);
      this.std.text.print_ex(centerX, buttonY, "🎯 A para continuar", 0, 0);
    } else {
      this.std.draw.color(this.std.color.orange);
      this.std.text.font_size(20);
      this.std.text.print_ex(centerX, buttonY, "A para continuar", 0, 0);
    }

    // Instruções de navegação estilizadas
    this.std.text.font_size(14);
    this.std.draw.color(this.std.color.gray);
    this.std.text.print_ex(100, footerY + 15, "← → navegação", 0, 0);
    this.std.text.print_ex(100, footerY + 35, "MENU voltar", 0, 0);

    // Decoração lateral - ícones de cartas
    const sideDecoY = centerY;
    this.std.draw.color(this.std.color.gold);
    this.std.text.font_size(24);
    this.std.text.print_ex(80, sideDecoY - 60, "♠", 0, 0);
    this.std.text.print_ex(80, sideDecoY - 20, "♥", 0, 0);
    this.std.text.print_ex(80, sideDecoY + 20, "♦", 0, 0);
    this.std.text.print_ex(80, sideDecoY + 60, "♣", 0, 0);

    this.std.text.print_ex(this.std.app.width - 80, sideDecoY - 60, "♣", 0, 0);
    this.std.text.print_ex(this.std.app.width - 80, sideDecoY - 20, "♦", 0, 0);
    this.std.text.print_ex(this.std.app.width - 80, sideDecoY + 20, "♥", 0, 0);
    this.std.text.print_ex(this.std.app.width - 80, sideDecoY + 60, "♠", 0, 0);

    // Efeito de brilho nas decorações laterais
    if (Math.sin(time * 2) > 0.8) {
      this.std.draw.color(this.std.color.white);
      this.std.text.font_size(28);
      this.std.text.print_ex(80, sideDecoY, "✨", 0, 0);
      this.std.text.print_ex(this.std.app.width - 80, sideDecoY, "✨", 0, 0);
    }
  }

  private renderCredits() {
    const centerX = this.std.app.width / 2;
    const centerY = this.std.app.height / 2;
    const time = this.creditsAnimTime;

    // Background com gradiente simulado
    this.std.draw.color(this.std.color.black);
    this.std.draw.rect(0, 0, 0, this.std.app.width, this.std.app.height);

    // Camadas de cor para criar profundidade
    this.std.draw.color(this.std.color.maroon);
    this.std.draw.rect(0, 0, 0, this.std.app.width, this.std.app.height / 2);

    this.std.draw.color(this.std.color.darkpurple);
    this.std.draw.rect(0, 0, this.std.app.height / 2, this.std.app.width, this.std.app.height / 2);

    // Painel principal dos créditos
    const panelWidth = 500;
    const panelHeight = 400;
    const panelX = centerX - panelWidth / 2;
    const panelY = centerY - panelHeight / 2;

    // Sombra do painel
    this.std.draw.color(this.std.color.black);
    this.std.draw.rect(0, panelX + 8, panelY + 8, panelWidth, panelHeight);

    // Painel principal
    this.std.draw.color(this.std.color.darkblue);
    this.std.draw.rect(0, panelX, panelY, panelWidth, panelHeight);

    // Borda dourada elegante
    this.std.draw.color(this.std.color.gold);
    this.std.draw.rect(1, panelX, panelY, panelWidth, panelHeight);
    this.std.draw.rect(1, panelX + 4, panelY + 4, panelWidth - 8, panelHeight - 8);

    // Título com efeito especial
    this.std.text.font_size(42);
    this.std.text.font_name(GameConfig.UI_FONT_NAME);

    // Sombra do título
    this.std.draw.color(this.std.color.black);
    this.std.text.print_ex(centerX + 3, centerY - 150 + 3, "CRÉDITOS", 0, 0);

    // Título principal com brilho
    const titlePulse = 1 + Math.sin(time * 1.5) * 0.08;
    this.std.text.font_size(42 * titlePulse);
    this.std.draw.color(this.std.color.gold);
    this.std.text.print_ex(centerX, centerY - 150, "CRÉDITOS", 0, 0);

    // Linha decorativa sob o título
    this.std.draw.color(this.std.color.gold);
    this.std.draw.line(centerX - 120, centerY - 125, centerX + 120, centerY - 125);

    // Conteúdo dos créditos com formatação melhorada
    const credits = [
      { text: "Desenvolvido com ❤️", style: "header", color: "white" },
      { text: "", style: "spacer", color: "" },
      { text: "TECNOLOGIAS:", style: "section", color: "skyblue" },
      { text: "Engine: Gamely Framework", style: "item", color: "lightgray" },
      { text: "Linguagem: TypeScript", style: "item", color: "lightgray" },
      { text: "Renderização: Canvas 2D", style: "item", color: "lightgray" },
      { text: "", style: "spacer", color: "" },
      { text: "DESIGN:", style: "section", color: "skyblue" },
      { text: "Sistema de turnos alternados", style: "item", color: "lightgray" },
      { text: "Mecânicas de upgrade progressivo", style: "item", color: "lightgray" },
      { text: "Interface responsiva e intuitiva", style: "item", color: "lightgray" },
      { text: "", style: "spacer", color: "" },
      { text: "🎮 Obrigado por jogar! 🎮", style: "footer", color: "yellow" },
      { text: "", style: "spacer", color: "" },
      { text: "Versão 1.0.0 - 2025", style: "version", color: "gray" },
    ];

    const startY = centerY - 100;
    let currentY = startY;
    const lineSpacing = 25;

    for (let i = 0; i < credits.length; i++) {
      const credit = credits[i];

      if (credit.style === "spacer") {
        currentY += lineSpacing * 0.5;
        continue;
      }

      // Definir estilo baseado no tipo
      switch (credit.style) {
        case "header":
          this.std.text.font_size(24);
          this.std.draw.color(this.std.color.white);
          break;
        case "section":
          this.std.text.font_size(20);
          this.std.draw.color(this.std.color.skyblue);
          break;
        case "item":
          this.std.text.font_size(18);
          this.std.draw.color(this.std.color.lightgray);
          break;
        case "footer":
          this.std.text.font_size(22);
          this.std.draw.color(this.std.color.yellow);
          break;
        case "version":
          this.std.text.font_size(16);
          this.std.draw.color(this.std.color.gray);
          break;
        default:
          this.std.text.font_size(18);
          this.std.draw.color(this.std.color.lightgray);
      }

      this.std.text.print_ex(centerX, currentY, credit.text, 0, 0);
      currentY += lineSpacing;
    }

    // Animação especial do coração
    const heartScale = 1 + Math.sin(time * 4) * 0.3;
    if (Math.sin(time * 4) > 0.5) {
      this.std.draw.color(this.std.color.red);
      this.std.text.font_size(28 * heartScale);
      this.std.text.print_ex(centerX + 105, startY, "❤️", 0, 0);
    }

    // Decorações animadas - estrelas flutuantes
    for (let i = 0; i < 6; i++) {
      const starX = centerX + Math.sin(time * 0.8 + i * 1.2) * 180;
      const starY = centerY + Math.cos(time * 0.6 + i * 0.9) * 120;

      if (Math.sin(time * 3 + i) > 0.6) {
        this.std.draw.color(this.std.color.gold);
        this.std.text.font_size(12);
        this.std.text.print_ex(starX, starY, "⭐", 0, 0);
      }
    }

    // Área de instruções estilizada
    const instructionY = this.std.app.height - 80;
    this.std.draw.color(this.std.color.darkgray);
    this.std.draw.rect(0, 100, instructionY - 10, this.std.app.width - 200, 50);

    this.std.draw.color(this.std.color.gold);
    this.std.draw.rect(1, 100, instructionY - 10, this.std.app.width - 200, 50);

    // Instruções com animação
    this.std.text.font_size(18);
    const instructionPulse = Math.sin(time * 2) > 0 ? this.std.color.white : this.std.color.yellow;
    this.std.draw.color(instructionPulse);
    this.std.text.print_ex(centerX, instructionY + 15, "🎮 A ou MENU para voltar ao menu principal", 0, 0);

    // Partículas de fundo
    for (let i = 0; i < 10; i++) {
      const particleX = (50 + i * 100 + Math.sin(time + i) * 30) % this.std.app.width;
      const particleY = (80 + Math.cos(time * 0.7 + i) * 40) % (this.std.app.height - 160);

      if (Math.sin(time * 1.5 + i) > 0.8) {
        this.std.draw.color(this.std.color.gold);
        this.std.text.font_size(8);
        this.std.text.print_ex(particleX, particleY + 80, "✦", 0, 0);
      }
    }

    // Logo/ícone especial no canto superior
    this.std.draw.color(this.std.color.gold);
    this.std.text.font_size(32);
    this.std.text.print_ex(centerX, 40, "👑", 0, 0);
  }

  // Métodos auxiliares para melhor organização
  private drawAnimatedBorder(x: number, y: number, width: number, height: number, time: number) {
    const borderOffset = Math.sin(time * 4) * 2;
    this.std.draw.color(this.std.color.gold);
    this.std.draw.rect(1, x - borderOffset, y - borderOffset, width + borderOffset * 2, height + borderOffset * 2);
  }

  private drawGlowEffect(x: number, y: number, text: string, baseSize: number, time: number) {
    const glowIntensity = (Math.sin(time * 3) + 1) / 2;
    const glowSize = baseSize + glowIntensity * 4;

    // Efeito de brilho
    this.std.draw.color(this.std.color.yellow);
    this.std.text.font_size(glowSize);
    this.std.text.print_ex(x + 1, y + 1, text, 0, 0);

    // Texto principal
    this.std.draw.color(this.std.color.white);
    this.std.text.font_size(baseSize);
    this.std.text.print_ex(x, y, text, 0, 0);
  }

  private renderFloatingParticles(time: number, count: number = 8) {
    for (let i = 0; i < count; i++) {
      const particleX = (this.std.app.width / 2 + Math.sin(time + i * 0.8) * 300) % this.std.app.width;
      const particleY = (100 + Math.cos(time * 0.7 + i) * 80) % (this.std.app.height - 100);

      if (Math.sin(time * 2 + i) > 0.7) {
        this.std.draw.color(this.std.color.gold);
        this.std.text.font_size(10);
        this.std.text.print_ex(particleX, particleY, "✦", 0, 0);
      }
    }
  }

  // Getters públicos
  public getMenuState(): MenuState {
    return this.menuState;
  }

  public getTutorialStep(): TutorialStep {
    return this.tutorialStep;
  }

  public isInGame(): boolean {
    return this.menuState === MenuState.GAME;
  }

  public isInTutorial(): boolean {
    return this.menuState === MenuState.TUTORIAL;
  }

  public isInCredits(): boolean {
    return this.menuState === MenuState.CREDITS;
  }

  public isInMainMenu(): boolean {
    return this.menuState === MenuState.MAIN_MENU;
  }

  // Métodos de controle de estado
  public startGame() {
    this.menuState = MenuState.GAME;
  }

  public returnToMenu() {
    this.menuState = MenuState.MAIN_MENU;
    this.selectedMainOption = 0;
    this.tutorialStep = TutorialStep.WELCOME;
  }

  public goToCredits() {
    this.menuState = MenuState.CREDITS;
    this.creditsAnimTime = 0;
  }

  public goToTutorial() {
    this.menuState = MenuState.TUTORIAL;
    this.tutorialStep = TutorialStep.WELCOME;
    this.tutorialAnimTime = 0;
  }

  // Métodos para integração com outros sistemas
  public getCurrentMenuOption(): string {
    if (this.menuState === MenuState.MAIN_MENU) {
      return this.mainMenuOptions[this.selectedMainOption];
    }
    return "";
  }

  public getTutorialProgress(): number {
    return (this.tutorialStep + 1) / this.tutorialTexts.length;
  }

  public getTutorialTitle(): string {
    if (this.tutorialStep < this.tutorialTexts.length) {
      return this.tutorialTexts[this.tutorialStep].title;
    }
    return "";
  }

  // Método para reset completo (útil para debugging)
  public reset() {
    this.menuState = MenuState.MAIN_MENU;
    this.tutorialStep = TutorialStep.WELCOME;
    this.selectedMainOption = 0;
    this.tutorialAnimTime = 0;
    this.creditsAnimTime = 0;
  }

  // Método para pular tutorial (cheat/debug)
  public skipToTutorialEnd() {
    if (this.menuState === MenuState.TUTORIAL) {
      this.tutorialStep = TutorialStep.COMPLETE;
      this.menuState = MenuState.MAIN_MENU;
      this.tutorialStep = TutorialStep.WELCOME;
    }
  }

  // Método para verificar se pode navegar
  public canNavigateBack(): boolean {
    return this.menuState === MenuState.TUTORIAL && this.tutorialStep > TutorialStep.WELCOME;
  }

  public canNavigateForward(): boolean {
    return this.menuState === MenuState.TUTORIAL && this.tutorialStep < TutorialStep.COMPLETE;
  }

  // Método de limpeza (caso necessário)
  public dispose() {
    // Limpar recursos se necessário
    this.waitManager = null;
    this.std = null;
  }
}
