/// 事業者コレクションを管理するためのモデル
class BusinessPerson {
  /// 事業者ID（事業者コレクション.ドキュメントIDを入れておく）
  String businessPersonId;

  /// 事業者名
  String businessPersonName;

  /// コンストラクタ
  BusinessPerson(
      {required this.businessPersonId, required this.businessPersonName});
}
