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
import 'package:spajam2022_kyoto/views/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey =
      'pk_test_51LlTbeE5GiTUmCGSnYF3JIM0h8ED1RXuZeFDYYnRaSBcMIUfejrAxPKZx8POqyHBSwIjRVwFmmGD2IJrffhvglOT0029NwuSMK';
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
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setupStripe(15000);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: createAppBar(context),
      body: createSwiper(context),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'payment',
        backgroundColor: AppColors.lightRed,
        icon: const Icon(Icons.payment_rounded),
        label: const Text('このガイドに決定'),
        onPressed: () async {
          try {
            await Stripe.instance.presentPaymentSheet();

            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()),
            );
          } catch (e) {
            final snackBar = SnackBar(
              content: Text(e.toString()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
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

  Future setupStripe(int amount) async {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? '0vXXhc25d1VsgU99a5I5x3vNr4o1';
    final docRef =
        await FirebaseFirestore.instance.collection('customers').doc(uid).collection("checkout_sessions").add({
      'client': 'mobile',
      'mode': 'payment',
      'amount': amount,
      'currency': 'jpy',
    });
    docRef.snapshots().listen((snap) async {
      final data = snap.data() as Map;
      print(data);

      try {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            // Main params
            paymentIntentClientSecret: data['paymentIntentClientSecret'],
            merchantDisplayName: 'Flutter Stripe Store Demo',
            // Customer params
            customerId: 'cus_MUjoijx8Hmlu8N',
            customerEphemeralKeySecret: data['ephemeralKeySecret'],
            //billingDetails: billingDetails,
          ),
        );
      } catch (e) {
        print(e);

        final snackBar = SnackBar(
          content: Text(e.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
