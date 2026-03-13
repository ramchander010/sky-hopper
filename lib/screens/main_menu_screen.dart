import 'package:sky_hopper/components/outlined_game_text.dart';
import 'package:sky_hopper/game/assets.dart';
import 'package:sky_hopper/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  final FlappyBirdGame game;
  static const String id = 'mainMenu';

  const MainMenuScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove(id);
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedGameText(
                text: 'Sky Hopper',
                fontSize: 55,
                fillColor: Colors.white,
                strokeColor: Color(0xFF1E88E5),
              ),
              const SizedBox(height: 20),

              OutlinedGameText(
                text: 'Get Ready',
                fontSize: 36,
                fillColor: Color(0xFFFF9800),
                strokeColor: Colors.white,
              ),
              const SizedBox(height: 30),

              Image.asset(
                "assets/images/${Assets.birdMidFlap}",
                width: 80,
                height: 60,
              ),
              const SizedBox(height: 40),

              OutlinedGameText(
                text: 'Tap To Continue',
                fontSize: 30,
                fillColor: Colors.white,
                strokeColor: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
