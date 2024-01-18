import 'package:flutter_stripe/flutter_stripe.dart';

import 'Utils/colors.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'Screens/Splash/splash_screen.dart';


    // Flutter Version :: 3.7.8 //

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51MCIlnAKaZkeJzUqrlMsIfqg6yVEmZTVGGqCImU2CFSejO1BDBykgCK2ue7C1LAg65WARxcXPKtMujKUAYvKStWY0025YZd14E';
  Stripe.merchantIdentifier = 'MYR';
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          title: 'AutoHausRental',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: appBgColor,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
