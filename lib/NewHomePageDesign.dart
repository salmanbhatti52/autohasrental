import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageDesignNew extends StatelessWidget {
  const HomePageDesignNew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey,
      body: Container(
        height: Get.height * 0.18,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: Get.width * 0.9,
                height: Get.height * 0.15,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(3,3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Tesla Model X",
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 14,
                                fontFamily: poppinBold,
                              ),
                            ),
                            Text(
                              "2018",
                              style: TextStyle(
                                color: textLabelColor,
                                fontSize: 14,
                                fontFamily: poppinSemiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 20,
              child: Row(
                children: [
                  Text(
                    "\$180",
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 14,
                      fontFamily: poppinSemiBold,
                    ),
                  ),
                  Text(
                    "/day",
                    style: TextStyle(
                      color: textLabelColor,
                      fontSize: 14,
                      fontFamily: poppinSemiBold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 19,
              bottom: 10,
              child: Container(
                width: Get.width * 0.4,
                height: 55,
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Click to see Details",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kWhite,
                      fontFamily: poppinMedium,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: -45,
              child: Image.asset(
                "assets/splash/bmwGreen.png",
                width: 180,
                height: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
