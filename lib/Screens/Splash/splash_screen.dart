import 'dart:async';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Authentication/LoginPage/login_page.dart';
import '../Introduction_screens/introduction_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loading = true;
  String? userFirstName, userLastName, userImage;
  sharedPrefs() async {
    loading = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    userEmail = (prefs!.getString('user_email'));
    userFirstName = (prefs!.getString('user_first_name'));
    userLastName = (prefs!.getString('user_last_name'));
    print("userId in LoginPrefs is = $userId");
    print("userEmail in LoginPrefs is = $userEmail");
    print("userFirstName in LoginPrefs is = $userFirstName $userLastName");

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
    Timer(Duration(seconds: 3), () {
      sharedPrefs();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
}
