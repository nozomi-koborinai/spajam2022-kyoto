import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spajam2022_kyoto/utils/app_colors.dart';

/// ガイドカード一枚分ウィジェット
class GuideCard extends StatelessWidget {
  final Color cardColor;
  final String guideName;
  const GuideCard(
      {required this.cardColor, required this.guideName, super.key});

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
                          child: Image.asset('images/20220924_225118.jpg')),
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
