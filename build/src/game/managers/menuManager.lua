-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end
-- End of Lua Library inline imports
local ____exports = {}
local ____waitManager = require("src.core.utils.waitManager")
local WaitManager = ____waitManager.WaitManager
local ____GameConfig = require("src.game.config.GameConfig")
local GameConfig = ____GameConfig.GameConfig
____exports.MenuState = MenuState or ({})
____exports.MenuState.MAIN_MENU = "MAIN_MENU"
____exports.MenuState.TUTORIAL = "TUTORIAL"
____exports.MenuState.CREDITS = "CREDITS"
____exports.MenuState.GAME = "GAME"
____exports.TutorialStep = TutorialStep or ({})
____exports.TutorialStep.WELCOME = 0
____exports.TutorialStep[____exports.TutorialStep.WELCOME] = "WELCOME"
____exports.TutorialStep.GAME_OVERVIEW = 1
____exports.TutorialStep[____exports.TutorialStep.GAME_OVERVIEW] = "GAME_OVERVIEW"
____exports.TutorialStep.HAND_BASICS = 2
____exports.TutorialStep[____exports.TutorialStep.HAND_BASICS] = "HAND_BASICS"
____exports.TutorialStep.CARD_SELECTION = 3
____exports.TutorialStep[____exports.TutorialStep.CARD_SELECTION] = "CARD_SELECTION"
____exports.TutorialStep.TURN_SYSTEM = 4
____exports.TutorialStep[____exports.TutorialStep.TURN_SYSTEM] = "TURN_SYSTEM"
____exports.TutorialStep.COMBAT_ATTACK = 5
____exports.TutorialStep[____exports.TutorialStep.COMBAT_ATTACK] = "COMBAT_ATTACK"
____exports.TutorialStep.COMBAT_RESPONSE = 6
____exports.TutorialStep[____exports.TutorialStep.COMBAT_RESPONSE] = "COMBAT_RESPONSE"
____exports.TutorialStep.SCORING_SYSTEM = 7
____exports.TutorialStep[____exports.TutorialStep.SCORING_SYSTEM] = "SCORING_SYSTEM"
____exports.TutorialStep.CARD_VALUES = 8
____exports.TutorialStep[____exports.TutorialStep.CARD_VALUES] = "CARD_VALUES"
____exports.TutorialStep.STRATEGY_TIPS = 9
____exports.TutorialStep[____exports.TutorialStep.STRATEGY_TIPS] = "STRATEGY_TIPS"
____exports.TutorialStep.UPGRADES_INTRO = 10
____exports.TutorialStep[____exports.TutorialStep.UPGRADES_INTRO] = "UPGRADES_INTRO"
____exports.TutorialStep.UPGRADES_EFFECTS = 11
____exports.TutorialStep[____exports.TutorialStep.UPGRADES_EFFECTS] = "UPGRADES_EFFECTS"
____exports.TutorialStep.WIN_CONDITIONS = 12
____exports.TutorialStep[____exports.TutorialStep.WIN_CONDITIONS] = "WIN_CONDITIONS"
____exports.TutorialStep.COMPLETE = 13
____exports.TutorialStep[____exports.TutorialStep.COMPLETE] = "COMPLETE"
____exports.MenuManager = __TS__Class()
local MenuManager = ____exports.MenuManager
MenuManager.name = "MenuManager"
function MenuManager.prototype.____constructor(self, std)
    self.menuState = ____exports.MenuState.MAIN_MENU
    self.tutorialStep = ____exports.TutorialStep.WELCOME
    self.mainMenuOptions = {"Jogar", "Tutorial", "Créditos"}
    self.selectedMainOption = 0
    self.tutorialTexts = {
        {title = "Bem-vindo ao Card Game!", content = {
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
            "Pressione A para começar o tutorial..."
        }},
        {title = "Visão Geral do Jogo", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Sua Mão de Cartas", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Selecionando Cartas", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Sistema de Turnos Alternados", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Fase de Ataque", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Fase de Resposta", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Sistema de Pontuação", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Valores e Naipes das Cartas", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Dicas Estratégicas", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Sistema de Upgrades", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Efeitos dos Upgrades", content = {
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
            "Pressione A para continuar..."
        }},
        {title = "Condições de Vitória", content = {
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
            "Pressione A para finalizar tutorial..."
        }}
    }
    self.tutorialAnimTime = 0
    self.creditsAnimTime = 0
    self.std = std
    self.waitManager = __TS__New(WaitManager)
end
function MenuManager.prototype.handleInput(self, key)
    repeat
        local ____switch4 = self.menuState
        local ____cond4 = ____switch4 == ____exports.MenuState.MAIN_MENU
        if ____cond4 then
            return self:handleMainMenuInput(key)
        end
        ____cond4 = ____cond4 or ____switch4 == ____exports.MenuState.TUTORIAL
        if ____cond4 then
            return self:handleTutorialInput(key)
        end
        ____cond4 = ____cond4 or ____switch4 == ____exports.MenuState.CREDITS
        if ____cond4 then
            return self:handleCreditsInput(key)
        end
        do
            return false
        end
    until true
end
function MenuManager.prototype.handleMainMenuInput(self, key)
    repeat
        local ____switch6 = key
        local ____cond6 = ____switch6 == "up" or ____switch6 == "left"
        if ____cond6 then
            if self.selectedMainOption > 0 then
                self.selectedMainOption = self.selectedMainOption - 1
            end
            return true
        end
        ____cond6 = ____cond6 or (____switch6 == "down" or ____switch6 == "right")
        if ____cond6 then
            if self.selectedMainOption < #self.mainMenuOptions - 1 then
                self.selectedMainOption = self.selectedMainOption + 1
            end
            return true
        end
        ____cond6 = ____cond6 or ____switch6 == "action"
        if ____cond6 then
            self:selectMainMenuOption()
            return true
        end
    until true
    return false
end
function MenuManager.prototype.handleTutorialInput(self, key)
    repeat
        local ____switch10 = key
        local ____cond10 = ____switch10 == "action"
        if ____cond10 then
            if self.tutorialStep < ____exports.TutorialStep.COMPLETE then
                self.tutorialStep = self.tutorialStep + 1
                if self.tutorialStep == ____exports.TutorialStep.COMPLETE then
                    self.menuState = ____exports.MenuState.MAIN_MENU
                    self.tutorialStep = ____exports.TutorialStep.WELCOME
                end
            end
            return true
        end
        ____cond10 = ____cond10 or ____switch10 == "menu"
        if ____cond10 then
            self.menuState = ____exports.MenuState.MAIN_MENU
            self.tutorialStep = ____exports.TutorialStep.WELCOME
            return true
        end
        ____cond10 = ____cond10 or ____switch10 == "left"
        if ____cond10 then
            if self.tutorialStep > ____exports.TutorialStep.WELCOME then
                self.tutorialStep = self.tutorialStep - 1
            end
            return true
        end
        ____cond10 = ____cond10 or ____switch10 == "right"
        if ____cond10 then
            if self.tutorialStep < ____exports.TutorialStep.COMPLETE then
                self.tutorialStep = self.tutorialStep + 1
                if self.tutorialStep == ____exports.TutorialStep.COMPLETE then
                    self.menuState = ____exports.MenuState.MAIN_MENU
                    self.tutorialStep = ____exports.TutorialStep.WELCOME
                end
            end
            return true
        end
    until true
    return false
end
function MenuManager.prototype.handleCreditsInput(self, key)
    repeat
        local ____switch17 = key
        local ____cond17 = ____switch17 == "menu" or ____switch17 == "action"
        if ____cond17 then
            self.menuState = ____exports.MenuState.MAIN_MENU
            return true
        end
    until true
    return false
end
function MenuManager.prototype.selectMainMenuOption(self)
    repeat
        local ____switch19 = self.selectedMainOption
        local ____cond19 = ____switch19 == 0
        if ____cond19 then
            self.menuState = ____exports.MenuState.GAME
            break
        end
        ____cond19 = ____cond19 or ____switch19 == 1
        if ____cond19 then
            self.menuState = ____exports.MenuState.TUTORIAL
            self.tutorialStep = ____exports.TutorialStep.WELCOME
            break
        end
        ____cond19 = ____cond19 or ____switch19 == 2
        if ____cond19 then
            self.menuState = ____exports.MenuState.CREDITS
            break
        end
    until true
end
function MenuManager.prototype.update(self, dt)
    self.waitManager:tick(dt)
    if self.menuState == ____exports.MenuState.TUTORIAL then
        self.tutorialAnimTime = self.tutorialAnimTime + dt / 1000
    end
    if self.menuState == ____exports.MenuState.CREDITS then
        self.creditsAnimTime = self.creditsAnimTime + dt / 1000
    end
    if self.tutorialAnimTime > 1000 then
        self.tutorialAnimTime = 0
    end
    if self.creditsAnimTime > 1000 then
        self.creditsAnimTime = 0
    end
end
function MenuManager.prototype.render(self)
    repeat
        local ____switch26 = self.menuState
        local ____cond26 = ____switch26 == ____exports.MenuState.MAIN_MENU
        if ____cond26 then
            self:renderMainMenu()
            break
        end
        ____cond26 = ____cond26 or ____switch26 == ____exports.MenuState.TUTORIAL
        if ____cond26 then
            self:renderTutorial()
            break
        end
        ____cond26 = ____cond26 or ____switch26 == ____exports.MenuState.CREDITS
        if ____cond26 then
            self:renderCredits()
            break
        end
    until true
end
function MenuManager.prototype.renderMainMenu(self)
    local centerX = self.std.app.width / 2
    local centerY = self.std.app.height / 2
    local time = self.tutorialAnimTime
    self.std.draw.color(self.std.color.black)
    self.std.draw.rect(
        0,
        0,
        0,
        self.std.app.width,
        self.std.app.height
    )
    self.std.draw.color(self.std.color.darkpurple)
    self.std.draw.rect(
        0,
        0,
        0,
        self.std.app.width,
        self.std.app.height / 3
    )
    self.std.draw.color(self.std.color.maroon)
    self.std.draw.rect(
        0,
        0,
        self.std.app.height * 2 / 3,
        self.std.app.width,
        self.std.app.height / 3
    )
    do
        local i = 0
        while i < 5 do
            local offsetX = math.sin(time + i) * 20
            local offsetY = math.cos(time * 0.5 + i) * 15
            local cardX = 100 + i * 200 + offsetX
            local cardY = 150 + offsetY
            self.std.draw.color(self.std.color.darkgray)
            self.std.draw.rect(
                0,
                cardX,
                cardY,
                60,
                80
            )
            self.std.draw.color(self.std.color.lightgray)
            self.std.draw.rect(
                1,
                cardX,
                cardY,
                60,
                80
            )
            i = i + 1
        end
    end
    local menuBoxWidth = 400
    local menuBoxHeight = 350
    local boxX = centerX - menuBoxWidth / 2
    local boxY = centerY - menuBoxHeight / 2
    self.std.draw.color(self.std.color.black)
    self.std.draw.rect(
        0,
        boxX + 8,
        boxY + 8,
        menuBoxWidth,
        menuBoxHeight
    )
    self.std.draw.color(self.std.color.darkblue)
    self.std.draw.rect(
        0,
        boxX,
        boxY,
        menuBoxWidth,
        menuBoxHeight
    )
    self.std.draw.color(self.std.color.gold)
    self.std.draw.rect(
        1,
        boxX,
        boxY,
        menuBoxWidth,
        menuBoxHeight
    )
    self.std.draw.rect(
        1,
        boxX + 4,
        boxY + 4,
        menuBoxWidth - 8,
        menuBoxHeight - 8
    )
    self.std.text.font_size(52)
    self.std.text.font_name(GameConfig.UI_FONT_NAME)
    self.std.draw.color(self.std.color.black)
    self.std.text.print_ex(
        centerX + 3,
        centerY - 130 + 3,
        "CARD GAME",
        0,
        0
    )
    local titlePulse = 1 + math.sin(time * 2) * 0.05
    self.std.text.font_size(52 * titlePulse)
    self.std.draw.color(self.std.color.gold)
    self.std.text.print_ex(
        centerX,
        centerY - 130,
        "CARD GAME",
        0,
        0
    )
    self.std.text.font_size(18)
    local ____temp_0
    if math.sin(time) > 0 then
        ____temp_0 = self.std.color.skyblue
    else
        ____temp_0 = self.std.color.lightgray
    end
    local subtitleColor = ____temp_0
    self.std.draw.color(subtitleColor)
    self.std.text.print_ex(
        centerX,
        centerY - 95,
        "⚔️ Estratégia • Fortuna • Vitória ⚔️",
        0,
        0
    )
    self.std.draw.color(self.std.color.gold)
    self.std.draw.line(centerX - 100, centerY - 75, centerX + 100, centerY - 75)
    self.std.text.font_size(26)
    local startY = centerY - 30
    local spacing = 50
    do
        local i = 0
        while i < #self.mainMenuOptions do
            local y = startY + i * spacing
            local optionWidth = 250
            local optionHeight = 40
            local optionX = centerX - optionWidth / 2
            local optionY = y - optionHeight / 2
            if i == self.selectedMainOption then
                self.std.draw.color(self.std.color.gold)
                self.std.draw.rect(
                    0,
                    optionX - 5,
                    optionY - 5,
                    optionWidth + 10,
                    optionHeight + 10
                )
                self.std.draw.color(self.std.color.darkblue)
                self.std.draw.rect(
                    0,
                    optionX,
                    optionY,
                    optionWidth,
                    optionHeight
                )
                self.std.draw.color(self.std.color.yellow)
                self.std.draw.rect(
                    1,
                    optionX + 2,
                    optionY + 2,
                    optionWidth - 4,
                    optionHeight - 4
                )
                self.std.draw.color(self.std.color.yellow)
                self.std.text.print_ex(
                    optionX + 20,
                    y,
                    "►",
                    0,
                    0
                )
                self.std.text.print_ex(
                    optionX + optionWidth - 20,
                    y,
                    "◄",
                    0,
                    0
                )
                self.std.draw.color(self.std.color.white)
                self.std.text.print_ex(
                    centerX,
                    y,
                    self.mainMenuOptions[i + 1],
                    0,
                    0
                )
                if math.sin(time * 6) > 0.5 then
                    self.std.draw.color(self.std.color.white)
                    self.std.draw.rect(
                        1,
                        optionX,
                        optionY,
                        optionWidth,
                        optionHeight
                    )
                end
            else
                self.std.draw.color(self.std.color.gray)
                self.std.draw.rect(
                    1,
                    optionX + 10,
                    optionY + 5,
                    optionWidth - 20,
                    optionHeight - 10
                )
                self.std.draw.color(self.std.color.lightgray)
                self.std.text.print_ex(
                    centerX,
                    y,
                    self.mainMenuOptions[i + 1],
                    0,
                    0
                )
            end
            i = i + 1
        end
    end
    local instructionY = self.std.app.height - 80
    self.std.draw.color(self.std.color.darkgray)
    self.std.draw.rect(
        0,
        50,
        instructionY - 10,
        self.std.app.width - 100,
        60
    )
    self.std.draw.color(self.std.color.skyblue)
    self.std.draw.rect(
        1,
        50,
        instructionY - 10,
        self.std.app.width - 100,
        60
    )
    self.std.text.font_size(16)
    self.std.draw.color(self.std.color.white)
    self.std.text.print_ex(
        centerX,
        instructionY + 10,
        "🎮 Use ← → para navegar • Pressione A para selecionar",
        0,
        0
    )
    self.std.text.print_ex(
        centerX,
        instructionY + 30,
        "📱 MENU para resetar jogo",
        0,
        0
    )
    self.std.text.font_size(12)
    self.std.draw.color(self.std.color.gray)
    self.std.text.print_ex(
        self.std.app.width - 80,
        self.std.app.height - 20,
        "v1.0.0",
        0,
        0
    )
    do
        local i = 0
        while i < 8 do
            local particleX = (centerX + math.sin(time + i * 0.8) * 200) % self.std.app.width
            local particleY = (100 + math.cos(time * 0.7 + i) * 50) % self.std.app.height
            if math.sin(time * 2 + i) > 0.7 then
                self.std.draw.color(self.std.color.gold)
                self.std.text.font_size(8)
                self.std.text.print_ex(
                    particleX,
                    particleY,
                    "✦",
                    0,
                    0
                )
            end
            i = i + 1
        end
    end
end
function MenuManager.prototype.renderTutorial(self)
    local centerX = self.std.app.width / 2
    local centerY = self.std.app.height / 2
    local time = self.tutorialAnimTime
    self.std.draw.color(self.std.color.darkgreen)
    self.std.draw.rect(
        0,
        0,
        0,
        self.std.app.width,
        self.std.app.height
    )
    self.std.draw.color(self.std.color.black)
    self.std.draw.rect(
        0,
        0,
        0,
        self.std.app.width,
        60
    )
    self.std.draw.rect(
        0,
        0,
        self.std.app.height - 60,
        self.std.app.width,
        60
    )
    local panelWidth = self.std.app.width - 120
    local panelHeight = self.std.app.height - 180
    local panelX = centerX - panelWidth / 2
    local panelY = centerY - panelHeight / 2
    self.std.draw.color(self.std.color.black)
    self.std.draw.rect(
        0,
        panelX + 6,
        panelY + 6,
        panelWidth,
        panelHeight
    )
    self.std.draw.color(self.std.color.white)
    self.std.draw.rect(
        0,
        panelX,
        panelY,
        panelWidth,
        panelHeight
    )
    self.std.draw.color(self.std.color.darkgreen)
    self.std.draw.rect(
        1,
        panelX + 2,
        panelY + 2,
        panelWidth - 4,
        panelHeight - 4
    )
    local headerHeight = 80
    self.std.draw.color(self.std.color.darkgreen)
    self.std.draw.rect(
        0,
        panelX + 2,
        panelY + 2,
        panelWidth - 4,
        headerHeight
    )
    local currentTutorial = self.tutorialTexts[self.tutorialStep + 1]
    self.std.text.font_size(32)
    self.std.draw.color(self.std.color.gold)
    self.std.text.print_ex(
        centerX,
        panelY + 35,
        currentTutorial.title,
        0,
        0
    )
    local lineWidth = math.abs(math.sin(time * 2)) * 200 + 100
    self.std.draw.color(self.std.color.gold)
    self.std.draw.line(centerX - lineWidth / 2, panelY + 55, centerX + lineWidth / 2, panelY + 55)
    self.std.text.font_size(18)
    local contentStartY = panelY + 100
    local lineHeight = 25
    do
        local i = 0
        while i < #currentTutorial.content do
            do
                local __continue40
                repeat
                    local y = contentStartY + i * lineHeight
                    local line = currentTutorial.content[i + 1]
                    if __TS__StringIncludes(line, "OBJETIVO:") or __TS__StringIncludes(line, "COMO FUNCIONA:") or __TS__StringIncludes(line, "VANTAGEM:") or __TS__StringIncludes(line, "IMPORTANTE:") or __TS__StringIncludes(line, "ESTRATÉGIA:") or __TS__StringIncludes(line, "DICA:") then
                        self.std.draw.color(self.std.color.maroon)
                        self.std.text.font_size(22)
                    elseif __TS__StringStartsWith(line, "•") or __TS__StringStartsWith(line, "→") or __TS__StringStartsWith(line, "✓") then
                        self.std.draw.color(self.std.color.darkblue)
                        self.std.text.font_size(18)
                    elseif __TS__StringIncludes(line, "RODADA") or __TS__StringIncludes(line, "ELEMENTOS") or __TS__StringIncludes(line, "CARACTERÍSTICAS") or __TS__StringIncludes(line, "PERMANÊNCIA:") or __TS__StringIncludes(line, "NAVEGAÇÃO:") or __TS__StringIncludes(line, "PROGRESSÃO:") then
                        self.std.draw.color(self.std.color.purple)
                        self.std.text.font_size(19)
                    elseif line == "" or __TS__StringTrim(line) == "" then
                        __continue40 = true
                        break
                    else
                        self.std.draw.color(self.std.color.black)
                        self.std.text.font_size(18)
                    end
                    self.std.text.print_ex(
                        centerX,
                        y,
                        line,
                        0,
                        0
                    )
                    __continue40 = true
                until true
                if not __continue40 then
                    break
                end
            end
            i = i + 1
        end
    end
    local footerY = panelY + panelHeight - 70
    self.std.draw.color(self.std.color.lightgray)
    self.std.draw.rect(
        0,
        panelX + 2,
        footerY,
        panelWidth - 4,
        68
    )
    self.std.text.font_size(16)
    self.std.draw.color(self.std.color.darkgreen)
    local progressText = (("Página " .. tostring(self.tutorialStep + 1)) .. " de ") .. tostring(#self.tutorialTexts)
    self.std.text.print_ex(
        self.std.app.width - 120,
        footerY + 20,
        progressText,
        0,
        0
    )
    local progressBarWidth = 300
    local progressBarHeight = 12
    local progressBarX = centerX - progressBarWidth / 2
    local progressBarY = footerY + 15
    self.std.draw.color(self.std.color.darkgray)
    self.std.draw.rect(
        0,
        progressBarX,
        progressBarY,
        progressBarWidth,
        progressBarHeight
    )
    local progressWidth = progressBarWidth * (self.tutorialStep + 1) / #self.tutorialTexts
    self.std.draw.color(self.std.color.green)
    self.std.draw.rect(
        0,
        progressBarX,
        progressBarY,
        progressWidth,
        progressBarHeight
    )
    self.std.draw.color(self.std.color.gold)
    self.std.draw.rect(
        1,
        progressBarX,
        progressBarY,
        progressBarWidth,
        progressBarHeight
    )
    do
        local i = 1
        while i < #self.tutorialTexts do
            local markerX = progressBarX + progressBarWidth * i / #self.tutorialTexts
            self.std.draw.color(self.std.color.white)
            self.std.draw.line(markerX, progressBarY, markerX, progressBarY + progressBarHeight)
            i = i + 1
        end
    end
    local buttonY = footerY + 45
    local buttonPulse = 1 + math.sin(time * 4) * 0.1
    if math.sin(time * 3) > 0 then
        self.std.draw.color(self.std.color.gold)
        self.std.text.font_size(22 * buttonPulse)
        self.std.text.print_ex(
            centerX,
            buttonY,
            "🎯 A para continuar",
            0,
            0
        )
    else
        self.std.draw.color(self.std.color.orange)
        self.std.text.font_size(20)
        self.std.text.print_ex(
            centerX,
            buttonY,
            "A para continuar",
            0,
            0
        )
    end
    self.std.text.font_size(14)
    self.std.draw.color(self.std.color.gray)
    self.std.text.print_ex(
        100,
        footerY + 15,
        "← → navegação",
        0,
        0
    )
    self.std.text.print_ex(
        100,
        footerY + 35,
        "MENU voltar",
        0,
        0
    )
    local sideDecoY = centerY
    self.std.draw.color(self.std.color.gold)
    self.std.text.font_size(24)
    self.std.text.print_ex(
        80,
        sideDecoY - 60,
        "♠",
        0,
        0
    )
    self.std.text.print_ex(
        80,
        sideDecoY - 20,
        "♥",
        0,
        0
    )
    self.std.text.print_ex(
        80,
        sideDecoY + 20,
        "♦",
        0,
        0
    )
    self.std.text.print_ex(
        80,
        sideDecoY + 60,
        "♣",
        0,
        0
    )
    self.std.text.print_ex(
        self.std.app.width - 80,
        sideDecoY - 60,
        "♣",
        0,
        0
    )
    self.std.text.print_ex(
        self.std.app.width - 80,
        sideDecoY - 20,
        "♦",
        0,
        0
    )
    self.std.text.print_ex(
        self.std.app.width - 80,
        sideDecoY + 20,
        "♥",
        0,
        0
    )
    self.std.text.print_ex(
        self.std.app.width - 80,
        sideDecoY + 60,
        "♠",
        0,
        0
    )
    if math.sin(time * 2) > 0.8 then
        self.std.draw.color(self.std.color.white)
        self.std.text.font_size(28)
        self.std.text.print_ex(
            80,
            sideDecoY,
            "✨",
            0,
            0
        )
        self.std.text.print_ex(
            self.std.app.width - 80,
            sideDecoY,
            "✨",
            0,
            0
        )
    end
end
function MenuManager.prototype.renderCredits(self)
    local centerX = self.std.app.width / 2
    local centerY = self.std.app.height / 2
    local time = self.creditsAnimTime
    self.std.draw.color(self.std.color.black)
    self.std.draw.rect(
        0,
        0,
        0,
        self.std.app.width,
        self.std.app.height
    )
    self.std.draw.color(self.std.color.maroon)
    self.std.draw.rect(
        0,
        0,
        0,
        self.std.app.width,
        self.std.app.height / 2
    )
    self.std.draw.color(self.std.color.darkpurple)
    self.std.draw.rect(
        0,
        0,
        self.std.app.height / 2,
        self.std.app.width,
        self.std.app.height / 2
    )
    local panelWidth = 500
    local panelHeight = 400
    local panelX = centerX - panelWidth / 2
    local panelY = centerY - panelHeight / 2
    self.std.draw.color(self.std.color.black)
    self.std.draw.rect(
        0,
        panelX + 8,
        panelY + 8,
        panelWidth,
        panelHeight
    )
    self.std.draw.color(self.std.color.darkblue)
    self.std.draw.rect(
        0,
        panelX,
        panelY,
        panelWidth,
        panelHeight
    )
    self.std.draw.color(self.std.color.gold)
    self.std.draw.rect(
        1,
        panelX,
        panelY,
        panelWidth,
        panelHeight
    )
    self.std.draw.rect(
        1,
        panelX + 4,
        panelY + 4,
        panelWidth - 8,
        panelHeight - 8
    )
    self.std.text.font_size(42)
    self.std.text.font_name(GameConfig.UI_FONT_NAME)
    self.std.draw.color(self.std.color.black)
    self.std.text.print_ex(
        centerX + 3,
        centerY - 150 + 3,
        "CRÉDITOS",
        0,
        0
    )
    local titlePulse = 1 + math.sin(time * 1.5) * 0.08
    self.std.text.font_size(42 * titlePulse)
    self.std.draw.color(self.std.color.gold)
    self.std.text.print_ex(
        centerX,
        centerY - 150,
        "CRÉDITOS",
        0,
        0
    )
    self.std.draw.color(self.std.color.gold)
    self.std.draw.line(centerX - 120, centerY - 125, centerX + 120, centerY - 125)
    local credits = {
        {text = "Desenvolvido com ❤️", style = "header", color = "white"},
        {text = "", style = "spacer", color = ""},
        {text = "TECNOLOGIAS:", style = "section", color = "skyblue"},
        {text = "Engine: Gamely Framework", style = "item", color = "lightgray"},
        {text = "Linguagem: TypeScript", style = "item", color = "lightgray"},
        {text = "Renderização: Canvas 2D", style = "item", color = "lightgray"},
        {text = "", style = "spacer", color = ""},
        {text = "DESIGN:", style = "section", color = "skyblue"},
        {text = "Sistema de turnos alternados", style = "item", color = "lightgray"},
        {text = "Mecânicas de upgrade progressivo", style = "item", color = "lightgray"},
        {text = "Interface responsiva e intuitiva", style = "item", color = "lightgray"},
        {text = "", style = "spacer", color = ""},
        {text = "🎮 Obrigado por jogar! 🎮", style = "footer", color = "yellow"},
        {text = "", style = "spacer", color = ""},
        {text = "Versão 1.0.0 - 2025", style = "version", color = "gray"}
    }
    local startY = centerY - 100
    local currentY = startY
    local lineSpacing = 25
    do
        local i = 0
        while i < #credits do
            do
                local __continue53
                repeat
                    local credit = credits[i + 1]
                    if credit.style == "spacer" then
                        currentY = currentY + lineSpacing * 0.5
                        __continue53 = true
                        break
                    end
                    repeat
                        local ____switch55 = credit.style
                        local ____cond55 = ____switch55 == "header"
                        if ____cond55 then
                            self.std.text.font_size(24)
                            self.std.draw.color(self.std.color.white)
                            break
                        end
                        ____cond55 = ____cond55 or ____switch55 == "section"
                        if ____cond55 then
                            self.std.text.font_size(20)
                            self.std.draw.color(self.std.color.skyblue)
                            break
                        end
                        ____cond55 = ____cond55 or ____switch55 == "item"
                        if ____cond55 then
                            self.std.text.font_size(18)
                            self.std.draw.color(self.std.color.lightgray)
                            break
                        end
                        ____cond55 = ____cond55 or ____switch55 == "footer"
                        if ____cond55 then
                            self.std.text.font_size(22)
                            self.std.draw.color(self.std.color.yellow)
                            break
                        end
                        ____cond55 = ____cond55 or ____switch55 == "version"
                        if ____cond55 then
                            self.std.text.font_size(16)
                            self.std.draw.color(self.std.color.gray)
                            break
                        end
                        do
                            self.std.text.font_size(18)
                            self.std.draw.color(self.std.color.lightgray)
                        end
                    until true
                    self.std.text.print_ex(
                        centerX,
                        currentY,
                        credit.text,
                        0,
                        0
                    )
                    currentY = currentY + lineSpacing
                    __continue53 = true
                until true
                if not __continue53 then
                    break
                end
            end
            i = i + 1
        end
    end
    local heartScale = 1 + math.sin(time * 4) * 0.3
    if math.sin(time * 4) > 0.5 then
        self.std.draw.color(self.std.color.red)
        self.std.text.font_size(28 * heartScale)
        self.std.text.print_ex(
            centerX + 105,
            startY,
            "❤️",
            0,
            0
        )
    end
    do
        local i = 0
        while i < 6 do
            local starX = centerX + math.sin(time * 0.8 + i * 1.2) * 180
            local starY = centerY + math.cos(time * 0.6 + i * 0.9) * 120
            if math.sin(time * 3 + i) > 0.6 then
                self.std.draw.color(self.std.color.gold)
                self.std.text.font_size(12)
                self.std.text.print_ex(
                    starX,
                    starY,
                    "⭐",
                    0,
                    0
                )
            end
            i = i + 1
        end
    end
    local instructionY = self.std.app.height - 80
    self.std.draw.color(self.std.color.darkgray)
    self.std.draw.rect(
        0,
        100,
        instructionY - 10,
        self.std.app.width - 200,
        50
    )
    self.std.draw.color(self.std.color.gold)
    self.std.draw.rect(
        1,
        100,
        instructionY - 10,
        self.std.app.width - 200,
        50
    )
    self.std.text.font_size(18)
    local ____temp_1
    if math.sin(time * 2) > 0 then
        ____temp_1 = self.std.color.white
    else
        ____temp_1 = self.std.color.yellow
    end
    local instructionPulse = ____temp_1
    self.std.draw.color(instructionPulse)
    self.std.text.print_ex(
        centerX,
        instructionY + 15,
        "🎮 A ou MENU para voltar ao menu principal",
        0,
        0
    )
    do
        local i = 0
        while i < 10 do
            local particleX = (50 + i * 100 + math.sin(time + i) * 30) % self.std.app.width
            local particleY = (80 + math.cos(time * 0.7 + i) * 40) % (self.std.app.height - 160)
            if math.sin(time * 1.5 + i) > 0.8 then
                self.std.draw.color(self.std.color.gold)
                self.std.text.font_size(8)
                self.std.text.print_ex(
                    particleX,
                    particleY + 80,
                    "✦",
                    0,
                    0
                )
            end
            i = i + 1
        end
    end
    self.std.draw.color(self.std.color.gold)
    self.std.text.font_size(32)
    self.std.text.print_ex(
        centerX,
        40,
        "👑",
        0,
        0
    )
end
function MenuManager.prototype.drawAnimatedBorder(self, x, y, width, height, time)
    local borderOffset = math.sin(time * 4) * 2
    self.std.draw.color(self.std.color.gold)
    self.std.draw.rect(
        1,
        x - borderOffset,
        y - borderOffset,
        width + borderOffset * 2,
        height + borderOffset * 2
    )
end
function MenuManager.prototype.drawGlowEffect(self, x, y, text, baseSize, time)
    local glowIntensity = (math.sin(time * 3) + 1) / 2
    local glowSize = baseSize + glowIntensity * 4
    self.std.draw.color(self.std.color.yellow)
    self.std.text.font_size(glowSize)
    self.std.text.print_ex(
        x + 1,
        y + 1,
        text,
        0,
        0
    )
    self.std.draw.color(self.std.color.white)
    self.std.text.font_size(baseSize)
    self.std.text.print_ex(
        x,
        y,
        text,
        0,
        0
    )
end
function MenuManager.prototype.renderFloatingParticles(self, time, count)
    if count == nil then
        count = 8
    end
    do
        local i = 0
        while i < count do
            local particleX = (self.std.app.width / 2 + math.sin(time + i * 0.8) * 300) % self.std.app.width
            local particleY = (100 + math.cos(time * 0.7 + i) * 80) % (self.std.app.height - 100)
            if math.sin(time * 2 + i) > 0.7 then
                self.std.draw.color(self.std.color.gold)
                self.std.text.font_size(10)
                self.std.text.print_ex(
                    particleX,
                    particleY,
                    "✦",
                    0,
                    0
                )
            end
            i = i + 1
        end
    end
end
function MenuManager.prototype.getMenuState(self)
    return self.menuState
end
function MenuManager.prototype.getTutorialStep(self)
    return self.tutorialStep
end
function MenuManager.prototype.isInGame(self)
    return self.menuState == ____exports.MenuState.GAME
end
function MenuManager.prototype.isInTutorial(self)
    return self.menuState == ____exports.MenuState.TUTORIAL
end
function MenuManager.prototype.isInCredits(self)
    return self.menuState == ____exports.MenuState.CREDITS
end
function MenuManager.prototype.isInMainMenu(self)
    return self.menuState == ____exports.MenuState.MAIN_MENU
end
function MenuManager.prototype.startGame(self)
    self.menuState = ____exports.MenuState.GAME
end
function MenuManager.prototype.returnToMenu(self)
    self.menuState = ____exports.MenuState.MAIN_MENU
    self.selectedMainOption = 0
    self.tutorialStep = ____exports.TutorialStep.WELCOME
end
function MenuManager.prototype.goToCredits(self)
    self.menuState = ____exports.MenuState.CREDITS
    self.creditsAnimTime = 0
end
function MenuManager.prototype.goToTutorial(self)
    self.menuState = ____exports.MenuState.TUTORIAL
    self.tutorialStep = ____exports.TutorialStep.WELCOME
    self.tutorialAnimTime = 0
end
function MenuManager.prototype.getCurrentMenuOption(self)
    if self.menuState == ____exports.MenuState.MAIN_MENU then
        return self.mainMenuOptions[self.selectedMainOption + 1]
    end
    return ""
end
function MenuManager.prototype.getTutorialProgress(self)
    return (self.tutorialStep + 1) / #self.tutorialTexts
end
function MenuManager.prototype.getTutorialTitle(self)
    if self.tutorialStep < #self.tutorialTexts then
        return self.tutorialTexts[self.tutorialStep + 1].title
    end
    return ""
end
function MenuManager.prototype.reset(self)
    self.menuState = ____exports.MenuState.MAIN_MENU
    self.tutorialStep = ____exports.TutorialStep.WELCOME
    self.selectedMainOption = 0
    self.tutorialAnimTime = 0
    self.creditsAnimTime = 0
end
function MenuManager.prototype.skipToTutorialEnd(self)
    if self.menuState == ____exports.MenuState.TUTORIAL then
        self.tutorialStep = ____exports.TutorialStep.COMPLETE
        self.menuState = ____exports.MenuState.MAIN_MENU
        self.tutorialStep = ____exports.TutorialStep.WELCOME
    end
end
function MenuManager.prototype.canNavigateBack(self)
    return self.menuState == ____exports.MenuState.TUTORIAL and self.tutorialStep > ____exports.TutorialStep.WELCOME
end
function MenuManager.prototype.canNavigateForward(self)
    return self.menuState == ____exports.MenuState.TUTORIAL and self.tutorialStep < ____exports.TutorialStep.COMPLETE
end
function MenuManager.prototype.dispose(self)
    self.waitManager = nil
    self.std = nil
end
return ____exports
