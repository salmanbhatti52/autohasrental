import 'package:flutter/material.dart';
import '../../../../../Utils/fontFamily.dart';
import '../BrowseCardForRent/browse_car_logo_container.dart';
import '../../../../../Utils/colors.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import '../../Filter/filter_screen.dart';
import 'driving_details_page.dart';
import 'top_widget.dart';

class DrivingExperiencePage extends StatefulWidget {
  const DrivingExperiencePage({Key? key}) : super(key: key);

  @override
  State<DrivingExperiencePage> createState() => _DrivingExperiencePageState();
}

class _DrivingExperiencePageState extends State<DrivingExperiencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarDoubleImage(
          frontImage: "assets/home_page/back_arrow.png",
          title: "Driving Experiences",
          backImage: "assets/home_page/notification_image.png"),
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 12, 10, 0),
                          hintText: 'Search for Cars',
                          hintStyle: TextStyle(
                              color: const Color(0xffD4DCE1),
                              fontSize: 14,
                              fontFamily: poppinLight),
                          focusColor: borderColor,
                          suffixIcon: const Icon(
                            Icons.search_outlined,
                            color: Color(0xffD4DCE1),
                          ),
                        ),
                        style: TextStyle(color: borderColor, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FilterScreen()));
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(30)),
                        child: Image.asset("assets/home_page/filter.png")),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: const BrowseCarLogoContainer()),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Top Experiences",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: poppinBold,
                      color: kBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                topExperienceWidget(context),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Other Best Experiences",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: poppinBold,
                        color: kBlack),
                    textAlign: TextAlign.left,
                  ),
                ),
                allFavItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget allFavItem() {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * 0.77,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: browseCarItemsList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DrivingDetailsPage()));
              },
              child: Stack(
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
                              height: MediaQuery.of(context).size.height * 0.1,
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
                                            "${browseCarItemsList[index].carCompanyName} | ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: poppinBold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${browseCarItemsList[index].textModel} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: poppinRegular,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${browseCarItemsList[index].carModelYear} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: poppinMedium,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            browseCarItemsList[index].range,
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
                                                fontFamily: poppinRegular,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            browseCarItemsList[index].oldPrice,
                                            style: TextStyle(
                                              color: kRed,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: kRed,
                                              decorationThickness: 3,
                                              fontSize: 10,
                                              fontFamily: poppinLight,
                                              height: 2,
                                            ),
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
                                                fontFamily: poppinSemiBold,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            browseCarItemsList[index].newPrice,
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
                                              fontFamily: poppinRegular,
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
                                              fontFamily: poppinRegular,
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
                              browseCarItemsList[index].discountText,
                              style: TextStyle(
                                color: kWhite,
                                fontSize: 13,
                                fontFamily: poppinSemiBold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              " OFF ",
                              style: TextStyle(
                                color: kWhite,
                                fontSize: 8,
                                fontFamily: poppinRegular,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                    child: Image.asset(
                      browseCarItemsList[index].carImage,
                      // width: 332,
                      // height: 180,
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 15,
                      child: Image.asset(
                        "assets/car_bookings_images/heart.png",
                      )),
                ],
              ),
            );
          }),
    );
  }
}

List browseCarItemsList = [
  BrowseRentCarItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  BrowseRentCarItemsClass("assets/home_page/bmw_car_image.png", "5%", 'TESLA',
      "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
];

class BrowseRentCarItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  BrowseRentCarItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
