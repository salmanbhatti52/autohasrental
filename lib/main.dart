import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/Splash/splash_screen.dart';
import 'Utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AutoHausRental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        primaryColor: appBgColor,
      ),
      home: const SplashScreen(),
    );
  }
}

