import 'package:flutter/material.dart';

import '../../../../../Widget/colors.dart';
import '../../../../../Widget/description_page/description_page_top_card.dart';
import '../../../../../Widget/tabbar_description_page.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 361,
              decoration: const BoxDecoration(
                color: Color(0xff0f172a),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Tesla S series, ',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins-Bold',
                              color: kWhite),
                          children: const [
                            TextSpan(
                                text: '2022',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Poppins-Regular',
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset(
                            'assets/car_description_images/chat.png',
                            width: 25,
                            height: 25),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/car_description_images/rating.png',
                          width: 75, height: 12),
                      const SizedBox(width: 6),
                      Text(
                        '4.0',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-SemiBold',
                            color: kWhite),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
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
          ],
        ),
      ),
    );
  }
}
