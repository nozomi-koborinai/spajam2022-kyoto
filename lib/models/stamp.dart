import 'dart:async';

/// スタンプコレクションを管理するためのモデル
class Stamp {
  /// スタンプID（スタンプコレクション.ドキュメントIDを入れておく）
  String stampId;

  /// スタンプ画像URL
  String stampImageUrl;

  /// 場所画像URL
  String placeImageUrl;

  /// スタンプ場所の緯度
  String latitude;

  /// スタンプ場所の経度
  String longitude;

  /// スタンプラリーシートID（このスタンプ）
  String stampRallySheetID;

  /// コンストラクタ
  Stamp(
      {required this.stampId,
      required this.stampImageUrl,
      required this.placeImageUrl,
      required this.latitude,
      required this.longitude,
      required this.stampRallySheetID});
}
