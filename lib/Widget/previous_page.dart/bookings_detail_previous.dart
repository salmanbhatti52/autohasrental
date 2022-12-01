import 'package:flutter/material.dart';

import '../colors.dart';

class BookingsDetailsPrevious extends StatefulWidget {
  const BookingsDetailsPrevious({super.key});

  @override
  State<BookingsDetailsPrevious> createState() =>
      _BookingsDetailsPreviousState();
}

class _BookingsDetailsPreviousState extends State<BookingsDetailsPrevious> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: previousItemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
                Positioned(
                  top: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.22,
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
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 48,
                                    right: 20,
                                    child: Container(
                                      width: 102,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: borderColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Rebook',
                                          style: TextStyle(
                                              fontSize: 12, color: kWhite),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Row(
                            children: [
                              const SizedBox(height: 93.6),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${previousItemsList[index].carCompanyName} | ",
                                          style: TextStyle(
                                            color: kBlack,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                          "${previousItemsList[index].textModel} ",
                                          style: TextStyle(
                                            color: kBlack,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                            "${previousItemsList[index].carModelYear} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins',
                                            )),
                                        Text(previousItemsList[index].range,
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Poppins',
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          previousItemsList[index].oldPrice,
                                          style: TextStyle(
                                              color: borderColor,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: kRed,
                                              decorationThickness: 3,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              height: 2),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          previousItemsList[index].newPrice,
                                          style: TextStyle(
                                            color: borderColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                        Text(
                                          "/ Month",
                                          style: TextStyle(
                                            color: kBlack,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
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
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "New",
                                              style: TextStyle(
                                                color: kWhite,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                              ),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                            previousItemsList[index].discountText,
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
                  left: 20,
                  child: Image.asset(
                    previousItemsList[index].carImage,
                    width: 325,
                    height: 175,
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
    );
  }
}

List previousItemsList = [
  PreviousItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "RM 9,000", "RM8,500"),
  // PreviousItemsClass("assets/car_bookings_images/bmw_car_image.png", "5%",
  //     'TESLA', "MODEL", "Y LONG RANGE ", "2022", "RM 9,000", "RM8,500"),
  // PreviousItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
  //     'TESLA', "MODEL", "Y LONG RANGE ", "2022", "RM 9,000", "RM8,500"),
  // PreviousItemsClass("assets/car_bookings_images/bmw_car_image.png", "5%",
  //     'TESLA', "MODEL", "Y LONG RANGE ", "2022", "RM 9,000", "RM8,500"),
];

class PreviousItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  PreviousItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
