import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';

class BookingsDetailsUpcoming extends StatefulWidget {
  const BookingsDetailsUpcoming({super.key});

  @override
  State<BookingsDetailsUpcoming> createState() =>
      _BookingsDetailsUpcomingState();
}

class _BookingsDetailsUpcomingState extends State<BookingsDetailsUpcoming> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
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
                  top: 70,
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
                          Row(
                            children: [
                              const SizedBox(height: 93.6),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.12),
                                    Row(
                                      children: [
                                        Text(
                                          "${previousItemsList[index].carCompanyName} | ",
                                          style: TextStyle(
                                            color: kBlack,
                                            fontSize: 14,
                                            fontFamily: 'Poppins-Bold',
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "${previousItemsList[index].textModel} ",
                                          style: TextStyle(
                                            color: kBlack,
                                            fontSize: 12,
                                            fontFamily: 'Poppins_Regular',
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "${previousItemsList[index].carModelYear} ",
                                          style: TextStyle(
                                            color: kBlack,
                                            fontSize: 14,
                                            fontFamily: 'Poppins-Medium',
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          previousItemsList[index].range,
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 04),
                                          child: Text(
                                            "RM",
                                            style: TextStyle(
                                              color: kRed,
                                              fontSize: 5,
                                              fontFamily: 'Poppins-Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Text(
                                          previousItemsList[index].oldPrice,
                                          style: TextStyle(
                                              color: kRed,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: kRed,
                                              decorationThickness: 3,
                                              fontSize: 10,
                                              fontFamily: 'Poppins-Light',
                                              height: 2),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(width: 5),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 06),
                                          child: Text(
                                            "RM",
                                            style: TextStyle(
                                              color: borderColor,
                                              fontSize: 7,
                                              fontFamily: 'Poppins-SemiBold',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Text(
                                          previousItemsList[index].newPrice,
                                          style: TextStyle(
                                            color: borderColor,
                                            fontSize: 20,
                                            fontFamily: 'Poppins-SemiBold',
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
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "New",
                                              style: TextStyle(
                                                color: kWhite,
                                                fontSize: 8,
                                                fontFamily: 'Poppins-Regular',
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
                Positioned(
                  top: 90,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            canceldialogbox(context);
                          },
                          child: Container(
                            width: 102,
                            height: 25,
                            decoration: BoxDecoration(
                              color: kRed,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins-Regular',
                                  color: kWhite,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  void canceldialogbox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: const Color(0xffb0b0b0),
            child: Container(
              color: const Color(0xff0f172a).withOpacity(0.5),
              child: AlertDialog(
                scrollable: true,
                backgroundColor: homeBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child:
                            Image.asset('assets/car_bookings_images/close.png'),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(
                      "Cancel?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: borderColor),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Text(
                      "Are you sure you want \n to cancel your booking?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: kBlack,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Text(
                      "* Cancelling booking will result in \n 10% cut of your payment.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffff6666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Text(
                      "* Booking can not be cancelled if \n 24 hours are remaining in starting.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffff6666),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 186,
                          height: 44,
                          decoration: BoxDecoration(
                              color: borderColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                            child: Text('Okay',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 186,
                          height: 44,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: const Color(0xffff6666), width: 1)),
                          child: const Center(
                            child: Text('No',
                                style: TextStyle(
                                    color: Color(0xffff6666),
                                    fontFamily: 'Poppins',
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

List previousItemsList = [
  PreviousItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
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
