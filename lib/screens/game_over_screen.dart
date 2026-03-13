// ignore_for_file: deprecated_member_use

import 'dart:ui';

// import 'package:sky_hopper/game/assets.dart';
import 'package:sky_hopper/components/outlined_game_text.dart';
import 'package:sky_hopper/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.black38,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Score: ${game.bird.score}',
            style: const TextStyle(
              fontSize: 60,
              color: Colors.white,
              fontFamily: 'Game',
            ),
          ),
          const SizedBox(height: 8),

          Text(
            'Best: ${game.bestScore}',
            style: const TextStyle(
              fontSize: 34,
              color: Color(0xFFFFD54F),  
              fontFamily: 'Game',
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          // Image.asset(Assets.gameOver),
          Center(child: OutlinedGameText(text: 'GAME OVER')),
          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),
                child: TextButton(
                  onPressed: onRestart,
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontFamily: 'Game',
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // void onRestart() {
  //   game.bird.reset();
  //   game.overlays.remove('gameOver');
  //   game.resumeEngine();
  // }
  void onRestart() {
    game.resetGame();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
