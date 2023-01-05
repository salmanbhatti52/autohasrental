import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/DrivingExperience/d_e_choose_subscription_paln.dart';
import 'package:flutter/material.dart';
import '../../../../../Model/HomePageModels/HomePageTopWidgetModels/driving_experience_cars_model.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/constants.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import '../../Home/Address/delivery_address.dart';
import '../../Home/choose_mileage_plan.dart';
import 'package:http/http.dart'as http;

class DrivingExperinceBooking extends StatefulWidget {
  final String? vehicalName;
  final int? modelYear;
  const DrivingExperinceBooking(
      {Key? key,
      this.vehicalName,
      this.modelYear})
      : super(key: key);

  @override
  State<DrivingExperinceBooking> createState() =>
      _DrivingExperinceBookingState();
}

class _DrivingExperinceBookingState extends State<DrivingExperinceBooking> {

  DrivingExperienceCarsModel drivingExperienceCarsModelObject = DrivingExperienceCarsModel();
  @override
  void initState() {
    super.initState();
    getDrivingExperienceCarsWidget();
  }
  bool loadingP = true;

  getDrivingExperienceCarsWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = carDrivingExperienceApiUrl;
      print("drivingExperienceCarsApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId
          },
          headers: {'Accept': 'application/json'});
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("drivingExperienceCarsResponse: ${responseString.toString()}");
        drivingExperienceCarsModelObject =
            drivingExperienceCarsModelFromJson(responseString);
        print(
            "drivingExperienceCarsLength: ${drivingExperienceCarsModelObject.data!.length}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImageWithText(
        title: "BMW 2 series, ", subtitle: "2022",
        // title: "${widget.vehicalName}", subtitle: "${widget.modelYear}",
        backImage: "assets/messages_images/Back.png",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  drivingExperinceBookingCard(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Choose Subscription plan", textAlign: TextAlign.left,
                          style: TextStyle(color: kBlack,
                            fontSize: 14, fontFamily: poppinSemiBold)),
                        const DEChooseSubscriptionPlan(),
                        // Text("Choose Mileage Package", textAlign: TextAlign.left,
                        //   style: TextStyle(color: kBlack, fontSize: 14,
                        //     fontFamily: poppinSemiBold)),
                        // const ChooseMileagePlan(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Start Fee",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinMedium,
                                  color: kBlack),
                            ),
                            Text(
                              "RM 8,471.94",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinMedium,
                                  color: kBlack),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "12 Months Plan",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinRegular,
                                  color: detailsTextColor),
                            ),
                            Text(
                              "RM 8,120.00",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinRegular,
                                  color: detailsTextColor),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lite Package - 1,250KM",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinRegular,
                                  color: detailsTextColor),
                            ),
                            Text(
                              "RM 0.00",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinRegular,
                                  color: detailsTextColor),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Service Fee (6%)",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinRegular,
                                  color: detailsTextColor),
                            ),
                            Text(
                              "RM 487.20",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: poppinRegular,
                                  color: detailsTextColor),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Monthly Total Fee",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: poppinSemiBold,
                                  color: kBlack),
                            ),
                            Text(
                              "RM 8,607.20",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: poppinSemiBold,
                                  color: kBlack),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "*A security deposit may be applicable, depending on your eligibility assessment.",
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: poppinRegular,
                              color: borderColor),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          height: screenHeight * 0.1,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              color: kBlack,
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                    "assets/home_page/business-investment.png"),
                                SizedBox(width: screenWidth * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Save RM 37,538",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: poppinSemiBold,
                                              color: kWhite),
                                        ),
                                        SizedBox(width: screenWidth * 0.03),
                                        Container(
                                          height: 25,
                                          width: screenWidth * 0.24,
                                          decoration: BoxDecoration(
                                              color: borderColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              "Learn more",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: poppinRegular,
                                                  color: kWhite),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      children: [
                                        Text("in your first year with ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: kWhite,
                                                fontSize: 10,
                                                fontFamily: poppinRegular)),
                                        Text("AutoHaus Rental",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: borderColor,
                                                fontSize: 10,
                                                fontFamily: poppinSemiBold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "What's Included",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: poppinSemiBold,
                              color: kBlack),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        myList("assets/home_page/Path 2582.png",
                            "Periodic maintenance package (including pick up and delivery)"),
                        myList("assets/home_page/Path 2582.png",
                            "Wear & tear (including tyres, wipers, and brake pads replacement)"),
                        myList("assets/home_page/Path 2582.png",
                            "Comprehensive insurance coverage"),
                        myList("assets/home_page/Path 2582.png",
                            "Personal accident coverage for driver and passengers"),
                        myList("assets/home_page/Path 2582.png",
                            "24-hour roadside assistance (with unlimited towing and minor roadside repairs)"),
                        myList("assets/home_page/Path 2582.png", "Road tax"),
                        myList("assets/home_page/Path 2582.png",
                            "Flux Concierge Service"),
                        myList("assets/home_page/Path 2582.png",
                            "Theft recovery services"),
                        myList("assets/home_page/Path 2582.png",
                            "Emergency dispatch services"),
                        SizedBox(height: screenHeight * 0.02),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DeliveryAddress()));
                            },
                            child: loginButton("Next", context)),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  myList(myImage, myText) {
    return Row(
      children: [
        Image.asset(myImage),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 07),
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.transparent,
          child: Text(
            myText,
            textAlign: TextAlign.left,
            maxLines: 2,
            style: TextStyle(
                fontSize: 10,
                fontFamily: poppinRegular,
                color: detailsTextColor),
          ),
        )
      ],
    );
  }

  Widget drivingExperinceBookingCard() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return
      loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
      Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            height: screenHeight * 0.43,
            decoration: BoxDecoration(
                color: kWhite, borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Positioned(
          top: 90,
          left: 10,
          child: Container(
            color: Colors.transparent,
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.1,
                  ),
                  Row(
                    children: [
                      Text(
                        "${drivingExperienceCarsModelObject.data![0].vehicalName} | ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 14,
                          fontFamily: poppinBold,
                        ),
                      ),
                      Text("MODEL ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 12,
                          fontFamily: poppinRegular,
                        ),
                      ),
                      Text("${drivingExperienceCarsModelObject.data![0].carsModels!.name} ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 14,
                            fontFamily: poppinMedium,
                          )),
                      Text("${drivingExperienceCarsModelObject.data![0].year}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: kBlack,
                            fontSize: 10,
                            fontFamily: poppinRegular,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 04),
                        child: Text(
                          "RM ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: kRed,
                            fontSize: 5,
                            fontFamily: poppinLight,
                          ),
                        ),
                      ),
                      Text(
                        "${drivingExperienceCarsModelObject.data![0].carsPlans![0].pricePerSlot}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: kRed,
                            fontFamily: poppinLight,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(top: 06),
                        child: Text(
                          "RM ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: borderColor,
                            fontSize: 7,
                            fontFamily: poppinSemiBold,
                          ),
                        ),
                      ),
                      Text(
                        "${drivingExperienceCarsModelObject.data![0].carsPlans![0].discountedPricePerSlot}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: borderColor,
                          fontSize: 20,
                          fontFamily: poppinSemiBold,
                        ),
                      ),
                      Text(
                        "/ Month",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 8,
                          fontFamily: poppinRegular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      Image.asset("assets/home_page/Promoted.png"),
                      const SizedBox(
                        width: 05,
                      ),
                      Text(
                        "Verified Dealer",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: textLabelColor,
                          fontSize: 10,
                          fontFamily: poppinRegular,
                        ),
                      ),
                      const SizedBox(
                        width: 05,
                      ),
                      Container(
                        height: 15,
                        width: 35,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "New",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 8,
                              fontFamily: poppinRegular,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                              "assets/home_page/9004787_star_favorite_award_like_icon.png"),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "${drivingExperienceCarsModelObject.data![0].rating}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 14,
                              fontFamily: poppinRegular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.45),
                      Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Pre book",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 12,
                              fontFamily: poppinMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "PRE-BOOK LISTING ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kBlack,
                      fontSize: 14,
                      fontFamily: poppinSemiBold,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                      "This vehicle may take more than 7 days to deliver, based on vehicle’s availability",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 10,
                        fontFamily: poppinRegular,
                      )),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 28,
            left: 27,
            child: Container(
              height: screenHeight * 0.04,
              width: screenWidth * 0.18,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${drivingExperienceCarsModelObject.data![0].discountPercentage}% ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 13,
                      fontFamily: poppinSemiBold,
                    ),
                  ),
                  Text("OFF",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 8,
                        fontFamily: poppinRegular,
                      )),
                ],
              ),
            )),
        Positioned(
          left: 20, right: 20,
          child: Image.network("$baseUrlImage${drivingExperienceCarsModelObject.data![0].image1}",
          height: 170,),
        ),
        Positioned(
            top: 28, right: 27,
            child: Image.asset("assets/home_page/heart_transparent.png",
              color: kBlack,
            )),
      ],
    );
  }
}
