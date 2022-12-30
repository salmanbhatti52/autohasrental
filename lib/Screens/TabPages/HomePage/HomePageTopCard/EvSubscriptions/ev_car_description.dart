import 'package:flutter/material.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Widget/month_slot.dart';
import '../../Home/home_page_details.dart';
import 'EvTabbar/tabbar_description_page.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';

class EVCarDescription extends StatefulWidget {
  const EVCarDescription({super.key});

  @override
  State<EVCarDescription> createState() => _EVCarDescriptionState();
}

class _EVCarDescriptionState extends State<EVCarDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarDoubleImageRichText(
        frontImage: "assets/live_chat_images/back_arrow.png",
        title: "Tesla S series, ",
        year: "2022",
        backImage: "assets/car_description_images/chat.png",
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.37,
              decoration: const BoxDecoration(
                color: Color(0xff0f172a),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/car_description_images/rating.png',
                          width: 75, height: 12),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Text('4.0',
                          style: TextStyle(
                              fontSize: 16,
                              color: kWhite,
                              fontFamily: poppinSemiBold)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset(
                            'assets/car_description_images/tesla.png',
                            width: 41,
                            height: 41),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                            'assets/car_description_images/heart.png',
                            width: 24,
                            height: 20),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: Image.asset(
                            'assets/car_description_images/car.png',
                            width: 307,
                            height: 192),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          'assets/car_description_images/circle.png',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.092,
                child: const MonthSlotContainer(),
              ),
            ),
            const TabbarEVCarDescription(),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePageDetails()));
                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }
}
