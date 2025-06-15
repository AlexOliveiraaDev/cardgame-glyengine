export const meta = {
  title: "Cong",
  version: "0.1.1",
  description: "simple pong game write in typescript + gly engine",
};

export const assets = ["src/mike.png:mike.png"];

function init(std: any, game: any) {
  game.score = 0;
  game.highscore = game.highscore == null ? 0 : game.highscore;
  game.player_size = game.height / 8;
  game.player_pos = game.height / 2 - game.player_size / 2;
  game.ball_pos_x = game.width / 2;
  game.ball_pos_y = game.height / 2;
  game.ball_spd_x = 0.6;
  game.ball_spd_y = 0.12;
  game.ball_size = 8;
}

function loop(std: any, game: any) {
  const new_player_pos: number = game.player_pos + std.key.axis.y * 7;
  game.player_pos = std.math.clamp(new_player_pos, 0, game.height - game.player_size);

  game.ball_pos_x += game.ball_spd_x * std.delta;
  game.ball_pos_y += game.ball_spd_y * std.delta;

  if (game.ball_pos_x >= game.width - game.ball_size) {
    game.ball_spd_x = -std.math.abs(game.ball_spd_x);
  }
  if (game.ball_pos_y >= game.height - game.ball_size) {
    game.ball_spd_y = -std.math.abs(game.ball_spd_y);
  }
  if (game.ball_pos_y <= 0) {
    game.ball_spd_y = std.math.abs(game.ball_spd_y);
  }
  if (game.ball_pos_x <= 0) {
    if (std.math.clamp(game.ball_pos_y, game.player_pos, game.player_pos + game.player_size) == game.ball_pos_y) {
      const new_spd_y: number = game.ball_spd_y + (game.player_pos % 10) - 5;
      const clamped_y: number = std.math.clamp(new_spd_y, -10, 10);
      game.ball_spd_y = game.ball_spd_y == 0 && clamped_y == 0 ? 20 : clamped_y;
      game.ball_spd_y /= 16;
      game.ball_spd_x = std.math.abs(game.ball_spd_x) * 1.003;
      game.score++;
    } else {
      std.app.reset();
    }
  }
}

function draw(std: any, game: any) {
  std.draw.clear(std.color.black);
  std.draw.color(std.color.white);
  std.draw.rect(0, 4, game.player_pos, 8, game.player_size);
  std.draw.color(std.color.red);
  //std.draw.rect(0, game.ball_pos_x, game.ball_pos_y, game.ball_size, game.ball_size);
  std.draw.image("mike.png", game.ball_pos_x, game.ball_pos_y, game.ball_size, game.ball_size);
  std.text.put(20, 1, game.score.toString());
  std.text.put(60, 1, game.highscore.toString());
}

function exit(std: any, game: any) {
  game.highscore = std.math.max(game.highscore, game.score);
}

export const callbacks = {
  init,
  loop,
  draw,
  exit,
};
