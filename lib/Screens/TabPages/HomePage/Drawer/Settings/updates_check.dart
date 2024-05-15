import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';

class CheckAppUpdates extends StatefulWidget {
  const CheckAppUpdates({super.key});

  @override
  State<CheckAppUpdates> createState() => _CheckAppUpdatesState();
}

class _CheckAppUpdatesState extends State<CheckAppUpdates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarSingleImage(
          title: "Updates", backImage: "assets/home_page/back_arrow.png"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "New Update Available",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: poppinBold,
                color: kBlack,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Text(
              "Update you app to enjoy the latest\nfeatures.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: poppinMedium,
                color: kBlack,
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            GestureDetector(
              onTap: () async {
                StoreRedirect.redirect(
                  androidAppId: "com.autohausrental.app",
                  iOSAppId: "6463710495",
                );
              },
              child: yesButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget yesButton() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.05,
      width: screenWidth * 0.6,
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text("Check for Updates",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: kWhite, fontFamily: poppinRegular, fontSize: 16)),
      ),
    );
  }
}
