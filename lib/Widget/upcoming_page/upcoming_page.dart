import 'package:flutter/material.dart';

import '../../Screens/TabPages/BookingPage/bookings_details_page2.dart';
import '../colors.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BookingDetailPage2()));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.70,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: upcomingItemsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.33,
                        ),
                      ),
                      Positioned(
                        top: 90,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 9),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.24,
                            width: 343,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height:
                                  MediaQuery.of(context).size.height * 0.1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 40, right: 20),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 102,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: kRed,
                                          borderRadius:
                                          BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Poppins-Regular',
                                                color: kWhite),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const SizedBox(height: 93.6),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${upcomingItemsList[index].carCompanyName} | ",
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins-Bold',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "${upcomingItemsList[index].textModel} ",
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "${upcomingItemsList[index].carModelYear} ",
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins-Medium',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                upcomingItemsList[index].range,
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "RM",
                                                style: TextStyle(
                                                  color: kRed,
                                                  fontSize: 5,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                upcomingItemsList[index]
                                                    .oldPrice,
                                                style: TextStyle(
                                                  color: kRed,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: kRed,
                                                  decorationThickness: 3,
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins-Light',
                                                  height: 2,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                "RM",
                                                style: TextStyle(
                                                  color: borderColor,
                                                  fontSize: 7,
                                                  fontFamily:
                                                  'Poppins-SemiBold',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                upcomingItemsList[index]
                                                    .newPrice,
                                                style: TextStyle(
                                                  color: borderColor,
                                                  fontSize: 20,
                                                  fontFamily:
                                                  'Poppins-SemiBold',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "/ Month",
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 8,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01,
                                              ),
                                              Image.asset(
                                                  "assets/car_bookings_images/rating_stars.png"),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.01,
                                              ),
                                              Text(
                                                "4.0",
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.01),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  "assets/car_bookings_images/promoted.png"),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Verified Dealer",
                                                style: TextStyle(
                                                  color: textLabelColor,
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins-Regular',
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              const SizedBox(
                                                width: 05,
                                              ),
                                              Container(
                                                height: 20,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                    color: kBlack,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                                child: Center(
                                                  child: Text(
                                                    "New",
                                                    style: TextStyle(
                                                      color: kWhite,
                                                      fontSize: 8,
                                                      fontFamily:
                                                      'Poppins-Regular',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                            "assets/car_bookings_images/more_button.png"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          left: 15,
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.07,
                            width: MediaQuery.of(context).size.width * 0.16,
                            decoration: BoxDecoration(
                              color: kRed.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  upcomingItemsList[index].discountText,
                                  style: TextStyle(
                                    color: kWhite,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                Text(" OFF ",
                                    style: TextStyle(
                                      color: kWhite,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w300,
                                      fontFamily: 'Poppins',
                                    )),
                              ],
                            ),
                          )),
                      Positioned(
                        child: Image.asset(
                          upcomingItemsList[index].carImage,
                          width: 332,
                          height: 180,
                        ),
                      ),
                      Positioned(
                          top: 10,
                          right: 15,
                          child: Image.asset(
                            "assets/car_bookings_images/heart.png",
                          )),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

List upcomingItemsList = [
  UpcomingItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  UpcomingItemsClass("assets/car_bookings_images/bmw_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  UpcomingItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  UpcomingItemsClass("assets/car_bookings_images/bmw_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
];

class UpcomingItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  UpcomingItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
