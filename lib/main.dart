import 'Utils/colors.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'Screens/Splash/splash_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:auto_haus_rental_app/Widget/StripeKeysFetching.dart';

// Flutter Version :: 3.7.8 //

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("4f793a22-6af2-47f1-ae82-fff9e12139b1");
  final stripeKeys = await StripeKeysFetcher.fetchStripeKeys();
  Stripe.publishableKey = stripeKeys['publishableKey']!;
  print("stripeKeys ${stripeKeys['publishableKey']}");
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
