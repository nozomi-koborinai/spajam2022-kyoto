import 'package:flutter/material.dart';
import 'package:spajam2022_kyoto/components.dart';
import 'package:spajam2022_kyoto/utils/app_colors.dart';

///　状態管理用クラス
class States {
  /// singleton
  States._();
  static final States instance = States._();

  /// スワイプウィジェットのそれぞれのページ
  final pages = <GuideCard>[
    GuideCard(
        cardColor: AppColors.lightGreen,
        guideName: '銭湯の優しいおっちゃん',
        imagePath: 'images/20220924_225118.jpg'),
    GuideCard(
        cardColor: AppColors.skyGreen,
        guideName: 'バーのマスター',
        imagePath: 'images/IMG_4E7A57CF2D0F-1.jpeg'),
    GuideCard(
      cardColor: AppColors.lightOrange,
      guideName: 'まいこさん',
      imagePath: 'images/sp-038257700s1649383592.jpeg',
    ),
    GuideCard(
        cardColor: AppColors.lightYellow,
        guideName: 'お笑い芸人',
        imagePath: 'images/koume1_1.jpeg'),
  ];

  /// 選択中ガイド
  late GuideCard selectedGuide = States.instance.pages[0];

  /// チャットのメッセージリスト
  var chatMessageList = [
    ChatMessageBox(
        isMyMessage: true,
        message: 'どちらへ向かえばよろしいでしょうか?',
        sendDateTime: '09/25 09:21'),
    ChatMessageBox(
        isMyMessage: false,
        message: '本日の13:00に京都駅西口はどうでしょうか？',
        sendDateTime: '09/25 09:30'),
    ChatMessageBox(
        isMyMessage: false,
        message: '青のはちまきをしているのですぐ分かるかと思います',
        sendDateTime: '09/25 09:31'),
    ChatMessageBox(
        isMyMessage: true,
        message: '承知しました。よろしくお願いします。',
        sendDateTime: '09/25 10:02'),
  ];

  /// チャットのテキストコントローラー
  TextEditingController textController = TextEditingController(text: '');
}
