import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'Screens/Splash/splash_screen.dart';
import 'Utils/colors.dart';
// import 'package:device_preview/device_preview.dart';

void main() => runApp(
  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) =>
        MyApp(), // Wrap your app
  // ),
);

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          title: 'AutoHausRental',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // primarySwatch: Colors.blue,
            primaryColor: appBgColor,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
