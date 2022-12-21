import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';
import '../Authentication/LoginPage/login_page.dart';
import '../Introduction_screens/introduction_page.dart';
import '../TabPages/tab_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;
  String? userId, userEmail;
  bool loading = true;
  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    userEmail = (prefs!.getString('user_email'));
    print("userId in  LoginPrefs is = $userId");
    print("userEmail in  LoginPrefs is = $userEmail");
    if (userId != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const TabBarPage()));
    }
    else{
      loading = false;
      setState(() {});
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      print("userId value is = $userId");
    }
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

  splashNavigator() {
    Timer(const Duration(seconds: 3), () {
      sharedPrefs();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }
}
