import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:spajam2022_kyoto/firebase_options.dart';
import 'package:spajam2022_kyoto/states.dart';
import 'package:spajam2022_kyoto/utils/app_colors.dart';
import 'package:spajam2022_kyoto/utils/function_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ChatPage()),
          // );

          /// TODO：決済処理
          payStripe(1000);
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
            ..addTranslate(const [Offset(-370.0, -40.0), Offset(0.0, 0.0), Offset(370.0, -40.0)]),
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

  void payStripe(int amount) async {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? 'test';
    final docRef =
        await FirebaseFirestore.instance.collection('customers').doc(uid).collection("checkout_sessions").add({
      'client': 'mobile',
      'mode': 'payment',
      'amount': amount,
      'currency': 'jpy',
    });
    docRef.snapshots().listen((snap) async {
      final data = snap.data() as Map;
      // final sessionId = data['sessionId'];
      // if (sessionId != null) {
      //   await _redirectToCheckout(
      //     publishableKey: publishableKey,
      //     sessionId: sessionId,
      //   );
      // }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Main params
          paymentIntentClientSecret: data['paymentIntent'],
          merchantDisplayName: 'Flutter Stripe Store Demo',
          // Customer params
          customerId: data['customer'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          // Extra params
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'DE',
          ),
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: 'DE',
            testEnv: true,
          ),
          style: ThemeMode.dark,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.lightBlue,
              primary: Colors.blue,
              componentBorder: Colors.red,
            ),
            shapes: PaymentSheetShape(
              borderWidth: 4,
              shadow: PaymentSheetShadowParams(color: Colors.red),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Color.fromARGB(255, 231, 235, 30),
                  text: Color.fromARGB(255, 235, 92, 30),
                  border: Color.fromARGB(255, 235, 92, 30),
                ),
              ),
            ),
          ),
          //billingDetails: billingDetails,
        ),
      );
    });
  }
}
