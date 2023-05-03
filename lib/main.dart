import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'Screens/Splash/splash_screen.dart';
import 'Utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType){
      return GetMaterialApp(
      title: 'AutoHausRental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        // primarySwatch: Colors.blue,
        primaryColor: appBgColor,
      ),
      home: SplashScreen(),
    );
  });
  }
}
