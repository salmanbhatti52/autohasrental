import 'package:flutter/material.dart';

import '../../../../../Widget/button.dart';
import '../../../../../Widget/colors.dart';
import 'EvTaBBar/description_page/description_page_top_card.dart';
import 'EvTaBBar/tabbar_description_page.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';

class CarDescription extends StatefulWidget {
  const CarDescription({super.key});

  @override
  State<CarDescription> createState() => _CarDescriptionState();
}

class _CarDescriptionState extends State<CarDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const myAppBarDoubleImageRichText(frontImage: "assets/live_chat_images/back_arrow.png",
        title: "Tesla S series, ", year: "2022", backImage: "assets/car_description_images/chat.png",
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
                      Text(
                        '4.0',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-SemiBold',
                            color: kWhite),
                      ),
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
            myHorizontalCard2(context),
            const TabbarCarDescription(),
            loginButton('Book Me', context),
          ],
        ),
      ),
    );
  }
}
