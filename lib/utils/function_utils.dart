import 'package:audioplayers/audioplayers.dart';

/// 汎用的なメソッド群
class FunctionUtils {
  /// singleton
  static final FunctionUtils instance = FunctionUtils._();
  FunctionUtils._();

  /// フリック音を鳴らす
  Future swipeSound() async {
    final audioCache = AudioCache();
    await audioCache.play('swipe_sound.wav');
  }
}
