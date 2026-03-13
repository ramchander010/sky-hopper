import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String _bestScoreKey = 'best_score';

  static Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_bestScoreKey) ?? 0;
  }

  static Future<void> setBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_bestScoreKey, score);
  }
}