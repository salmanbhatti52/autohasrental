import 'dart:async';
import 'package:auto_haus_rental_app/Screens/Introduction_screens/introduction_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Screens/Authentication/LoginPage/login_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;
  bool _showIntro = true;

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
      loading = false;
      setState(() {});
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      print("userId value is = $userId");
    }
  }

  splashNavigator() {
    Timer(Duration(seconds: 3), () {
      sharedPrefs();
    });
  }

  introWidget(){
    SharedPreferences.getInstance().then((prefs) {
      bool hasSeenIntro = prefs.getBool('hasSeenIntro') ?? false;
      setState(() {
        _showIntro = !hasSeenIntro;
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('hasSeenIntro', true);
    });
    Future.delayed(Duration(seconds: 4), () {
      sharedPrefs();
      // Get.offAll(
      //   _showIntro ? IntroductionPage() : LoginPage(),
      // );
      Navigator.pushReplacement<void, void>(context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => _showIntro ? IntroductionPage() : LoginPage(),
        ),
      );
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
