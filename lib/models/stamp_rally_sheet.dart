/// スタンプラリーシートコレクションを管理するためのモデル
class StampRallySheet {
  /// スタンプラリーシートID（スタンプラリーシートコレクション.ドキュメントIDを入れておく）
  String stampRallySheetId;

  /// スタンプラリーシート名
  String stampRallySheetName;

  /// 事業者ID
  String businessPersonId;

  /// コンストラクタ
  StampRallySheet(
      {required this.stampRallySheetId,
      required this.stampRallySheetName,
      required this.businessPersonId});
}
