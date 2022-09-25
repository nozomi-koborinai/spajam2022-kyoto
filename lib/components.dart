import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spajam2022_kyoto/states.dart';
import 'package:spajam2022_kyoto/utils/app_colors.dart';
import 'package:spajam2022_kyoto/utils/hex_color.dart';

/// ガイドカード一枚分ウィジェット
class GuideCard extends StatelessWidget {
  final Color cardColor;
  final String guideName;
  final String imagePath;
  const GuideCard(
      {required this.cardColor,
      required this.guideName,
      required this.imagePath,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: cardColor, // Card自体の色
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
      elevation: 10, // 影の離れ具合
      shadowColor: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  // 枠線
                  border: Border.all(color: AppColors.white, width: 1),
                  // 角丸
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: SizedBox(
                              height: 465,
                              child: Image.asset(
                                imagePath,
                              ))),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 14, bottom: 30, left: 8),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            guideName,
                            style: TextStyle(
                              letterSpacing: 5.0,
                              fontSize: 20,
                              color: AppColors.gray,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 240),
                        child: RegistButton(
                            caption: '¥15,000', onPressed: () => {}),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 登録系ボタン
class RegistButton extends StatelessWidget {
  final String caption;
  final Function onPressed;
  const RegistButton({required this.caption, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.gray2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      onPressed: () => onPressed.call(),
      child: Text(caption),
    );
  }
}

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.gray),
      backgroundColor: AppColors.lightGray,
      title: Text(
        'ガイド一覧',
        style: TextStyle(color: AppColors.gray),
      ),
      elevation: 0,
    );
  }
}

class TextInputField extends StatefulWidget {
  final Function onUpdate;
  const TextInputField({required this.onUpdate, super.key});

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.camera_alt_outlined),
            iconSize: 28,
            color: Colors.black54,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.photo_outlined),
            iconSize: 28,
            color: Colors.black54,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: States.instance.textController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                /// 表示用のチャットリストにチャットメッセージを追加
                States.instance.chatMessageList.add(ChatMessageBox(
                    isMyMessage: true,
                    message: States.instance.textController.text,
                    sendDateTime: DateTime.now().toString()));
                States.instance.textController.text = '';
                widget.onUpdate.call();
              });
            },
            icon: Icon(Icons.send),
            iconSize: 28,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

/// チャットメッセージ表示用
class ChatMessageBox extends StatelessWidget {
  /// 自分のチャットメッセージかどうか（ture：自分、false：相手）
  /// 左寄せ、右寄せ判定用
  final bool isMyMessage;
  final String message;
  final String sendDateTime;

  const ChatMessageBox(
      {required this.isMyMessage,
      required this.message,
      required this.sendDateTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    return isMyMessage

        /// 自分が書いたメッセージの場合のレイアウト（右寄せ）
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 10.0,
                    maxWidth: 250.0,
                    minWidth: 50,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#38b48b'),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#38b48b'), //色
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message,
                              style: TextStyle(color: AppColors.white)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(sendDateTime,
                                style: TextStyle(color: AppColors.gray2)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )

        /// 相手が書いたメッセージの場合のレイアウト（左寄せ）
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 10.0,
                    maxWidth: 250.0,
                    minWidth: 50,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.white, //色
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message,
                              style: TextStyle(
                                  color: AppColors.gray,
                                  fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(sendDateTime,
                                style: TextStyle(color: AppColors.gray2)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
