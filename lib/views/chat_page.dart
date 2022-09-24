import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spajam2022_kyoto/components.dart';
import 'package:spajam2022_kyoto/states.dart';
import 'package:spajam2022_kyoto/utils/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final guide = States.instance.selectedGuide;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColors.gray),
          backgroundColor: AppColors.grayBackGround,
          title: Text(
            guide.guideName,
            style: TextStyle(color: AppColors.gray),
          ),
          elevation: 0,
        ),
        body: Container(
          color: AppColors.grayBackGround,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: States.instance.chatMessageList,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: MultipleLineTextField(),
              ),
            ],
          ),
        ));
  }
}
