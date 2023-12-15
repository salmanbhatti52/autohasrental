import 'Utils/colors.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'Screens/Splash/splash_screen.dart';


    // Flutter Version :: 3.7.8 //

void main() => runApp(
      MyApp(),
    );

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
