import 'dart:async';
import 'package:flame/components.dart';
import 'package:sky_hopper/game/assets.dart';
import 'package:sky_hopper/game/flappy_bird_game.dart';

class Background extends SpriteComponent with HasGameReference<FlappyBirdGame> {
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite(Assets.backgorund);

    final imageRatio = sprite!.image.width / sprite!.image.height;
    final screenRatio = game.size.x / game.size.y;

    if (imageRatio > screenRatio) {
      size.y = game.size.y;
      size.x = size.y * imageRatio;
    } else {
      size.x = game.size.x;
      size.y = size.x / imageRatio;
    }

    position = Vector2((game.size.x - size.x) / 2, (game.size.y - size.y) / 2);
  }
}
