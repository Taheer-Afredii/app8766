import 'package:app_876/core/provider/providers.dart';
import 'package:app_876/ui/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51LVaiXGVj1b6RabbrChlXCoZ0d56rGHk4ZQ447NdUaoBA5G172vWboPc83k33NrjkT88abQOjWSxkxOWLBn7aaBI000x2YZoz4";
  await Firebase.initializeApp();
  runApp(MyApp(title: 'App 876'));
}

class MyApp extends StatelessWidget {
  final String title;

  static const double _designWidth = 428;
  static const double _designHeight = 926;
  const MyApp({required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: ScreenUtilInit(
        designSize: Size(_designWidth, _designHeight),
        builder: (context, widget) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
