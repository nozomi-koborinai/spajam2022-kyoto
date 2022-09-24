import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// 汎用的なメソッド群
class FunctionUtils {
  /// singleton
  static final FunctionUtils instance = FunctionUtils._();
  FunctionUtils._();

  /// フリック音を鳴らす
  void swipeSound() {
    final audioCache = AudioCache();
    audioCache.play('swipe_sound.wav');
  }
}
