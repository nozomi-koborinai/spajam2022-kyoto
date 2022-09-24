import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:spajam2022_kyoto/states.dart';
import 'package:spajam2022_kyoto/utils/app_colors.dart';
import 'package:spajam2022_kyoto/utils/function_utils.dart';
import 'package:spajam2022_kyoto/views/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context),
      body: createSwiper(context),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'payment',
        backgroundColor: AppColors.lightRed,
        icon: const Icon(Icons.payment_rounded),
        label: const Text('このガイドに決定'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatPage()),
          );

          /// TODO：決済処理
        },
      ),
    );
  }

  AppBar createAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.gray),
      backgroundColor: AppColors.grayBackGround,
      title: Text(
        'ガイド一覧',
        style: TextStyle(color: AppColors.gray),
      ),
      elevation: 0,
    );
  }

  Widget createSwiper(BuildContext context) {
    return Container(
      color: AppColors.grayBackGround,
      child: Swiper(
          layout: SwiperLayout.CUSTOM,
          customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
            ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
            ..addTranslate(const [
              Offset(-370.0, -40.0),
              Offset(0.0, 0.0),
              Offset(370.0, -40.0)
            ]),
          itemWidth: 380.0,
          itemHeight: 700.0,
          itemBuilder: (context, index) {
            return States.instance.pages[index];
          },
          onIndexChanged: (int value) {
            FunctionUtils.instance.swipeSound();
            States.instance.selectedGuide = States.instance.pages[value];
          },
          itemCount: States.instance.pages.length),
    );
  }
}
