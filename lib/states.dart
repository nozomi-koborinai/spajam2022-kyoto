import 'package:flutter/material.dart';
import 'package:spajam2022_kyoto/components.dart';
import 'package:spajam2022_kyoto/utils/app_colors.dart';

///　状態管理用クラス
class States {
  /// singleton
  States._();
  static final States instance = States._();

  /// スワイプウィジェットのそれぞれのページ
  final pages = [
    GuideCard(cardColor: AppColors.lightGreen, guideName: '銭湯の優しいおっちゃん'),
    GuideCard(cardColor: AppColors.skyGreen, guideName: '銭湯の優しいおっちゃん'),
    GuideCard(cardColor: AppColors.lightOrange, guideName: '銭湯の優しいおっちゃん'),
    GuideCard(cardColor: AppColors.lightYellow, guideName: '銭湯の優しいおっちゃん'),
  ];
}
