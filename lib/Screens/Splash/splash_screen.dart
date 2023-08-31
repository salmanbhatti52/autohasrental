import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Screens/Authentication/LoginPage/login_page.dart';
import '../Introduction_screens/introduction_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;

  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in splashPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print("userId in splashPrefs is = $userId");
    if (userId != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarPage()));
    }
    else{
      bool firstRun = await IsFirstRun.isFirstRun();
      loading = false;
      setState(() {});
      Navigator.push(context, MaterialPageRoute(builder: (context) => firstRun ? IntroductionPage() : LoginPage()));
      print("userId value is = $userId");
    }
  }

  splashNavigator() {
    Timer(Duration(seconds: 3), () {
      sharedPrefs();
    });
  }

  @override
  void initState() {
    super.initState();
    splashNavigator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset('assets/splash/login_image.svg', fit: BoxFit.fill,)),
        ],
      ),
    );
  }
}
