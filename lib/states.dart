import 'package:flutter/material.dart';

///　状態管理用クラス
class States {
  /// singleton
  States._();
  static final States instance = States._();

  /// スワイプウィジェットのそれぞれのページ
  final pages = [
    Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text(''),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.red,
        child: Center(child: Text('1人目')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          '¥10,000',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(''),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Center(child: Text('2人目')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          '¥20,000',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
    Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow,
        title: const Text(''),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.yellow,
        child: Center(child: Text('3人目')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          '¥30,000',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  ];
}
