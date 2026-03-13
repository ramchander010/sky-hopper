// ignore_for_file: deprecated_member_use

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sky_hopper/game/bird_movement.dart';
import 'package:sky_hopper/game/assets.dart';
import 'package:sky_hopper/game/configuration.dart';
import 'package:sky_hopper/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';
import 'package:sky_hopper/game/local_storage.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  int score = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);

    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    current = BirdMovement.middle;

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
  }

  // double _lastFlySound = 0;

  void fly() {
    // final now = gameRef.currentTime();
    // if (now - _lastFlySound > 0.12) {
    //   FlameAudio.play(Assets.flying, volume: 0.8);
    //   _lastFlySound = now;
    // }
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    // FlameAudio.play(Assets.flying);
    current = BirdMovement.up;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    gameOver();
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }

  Future<void> gameOver() async {
    if (game.isHit) return;
    FlameAudio.play(Assets.collision);
    if (score > game.bestScore) {
      game.bestScore = score;
      await LocalStorage.setBestScore(score);
    }
    game.isHit = true;
    gameRef.pauseEngine();
    gameRef.overlays.add('gameOver');
  }
}
