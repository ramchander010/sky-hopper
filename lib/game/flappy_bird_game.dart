import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sky_hopper/components/background.dart';
import 'package:sky_hopper/components/bird.dart';
import 'package:sky_hopper/components/ground.dart';
import 'package:sky_hopper/components/pipe_group.dart';
import 'package:sky_hopper/game/assets.dart';
import 'package:sky_hopper/game/configuration.dart';
import 'package:flutter/painting.dart';
import 'package:sky_hopper/game/local_storage.dart';

class FlappyBirdGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {
  FlappyBirdGame();

  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;

  int bestScore = 0;

  @override
  Future<void> onLoad() async {
    bestScore = await LocalStorage.getBestScore();
    await FlameAudio.audioCache.loadAll([
      // Assets.flying,
      Assets.collision,
      Assets.point,
    ]);

    addAll([Background(), Ground(), bird = Bird(), score = buildScore()]);

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          fontFamily: 'Game',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }

  void resetGame() {
    // Remove old pipes
    children.whereType<PipeGroup>().forEach(remove);

    // Reset bird
    bird.reset();

    // Reset score
    score.text = 'Score: 0';

    // Reset flags
    isHit = false;

    // Reset timer
    interval.stop();
    interval.start();
  }
}
