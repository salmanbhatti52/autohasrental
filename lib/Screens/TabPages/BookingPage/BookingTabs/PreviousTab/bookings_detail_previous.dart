import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/EvSubscriptions/ev_description_details_page.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/fontFamily.dart';

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
                          child: const Padding(
                            padding: EdgeInsets.only(top: 40, right: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),
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
                                          fontFamily: poppinBold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "${previousItemsList[index].textModel} ",
                                        style: TextStyle(
                                          color: kBlack,
                                          fontSize: 12,
                                          fontFamily: poppinRegular,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "${previousItemsList[index].carModelYear} ",
                                        style: TextStyle(
                                          color: kBlack,
                                          fontSize: 14,
                                          fontFamily: poppinMedium,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        previousItemsList[index].range,
                                        style: TextStyle(
                                          color: kBlack,
                                          fontSize: 10,
                                          fontFamily: poppinRegular,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 04),
                                        child: Text(
                                          "RM",
                                          style: TextStyle(
                                            color: kRed,
                                            fontSize: 5,
                                            fontFamily: poppinRegular,
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
                                            fontFamily: poppinLight,
                                            height: 2),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(width: 5),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 06),
                                        child: Text(
                                          "RM",
                                          style: TextStyle(
                                            color: borderColor,
                                            fontSize: 7,
                                            fontFamily: poppinSemiBold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Text(
                                        previousItemsList[index].newPrice,
                                        style: TextStyle(
                                          color: borderColor,
                                          fontSize: 20,
                                          fontFamily: poppinSemiBold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "/ Month",
                                        style: TextStyle(
                                          color: kBlack,
                                          fontSize: 8,
                                          fontFamily: poppinRegular,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Image.asset(
                                          "assets/car_bookings_images/rating_stars.png"),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Text(
                                        "4.0",
                                        style: TextStyle(
                                          color: kBlack,
                                          fontSize: 12,
                                          fontFamily: poppinRegular,
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
                                          fontFamily: poppinRegular,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        width: 05,
                                      ),
                                      Container(
                                        height: 15,
                                        width: 35,
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
                                              fontFamily: poppinRegular,
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
                ),
              ),
              Positioned(
                top: 135,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EvDescriptionDetailsPage()));
                  },
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
                          fontSize: 12,
                          fontFamily: poppinRegular,
                          color: kWhite,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
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
