import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../../../Model/GetMileagePlansModel.dart';
import 'EvAddress/ev_delivery_address.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:auto_haus_rental_app/Model/custom_subscription_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';

class EvDescriptionDetailsPage extends StatefulWidget {
  List<Datum>? getMileagePlansModel;
  final String? mySelectedTabMonth, mySelectedTabPrice, selectedMileagePlan;
  final String? carName,
      carImage,
      carYear,
      carPrice,
      carStatus,
      favouriteStatus,
      carColorName,
      carModelName,
      carMakesName,
      carMakesImage,
      carRating,
      carOwnerImage,
      carOwnerName,
      discountPercentage;
  final int? carId, mileagePlanID, carOwnerId;
  final String? carDiscountPrice;

  EvDescriptionDetailsPage(
      {Key? key,
      this.carName,
        this.mileagePlanID,
        this.getMileagePlansModel,
      this.carMakesName,
      this.favouriteStatus,
      this.discountPercentage,
      this.carDiscountPrice,
      this.carImage,
      this.carYear,
      this.carMakesImage,
      this.carStatus,
      this.carColorName,
      this.carModelName,
      this.carId,
      this.selectedMileagePlan,
      this.carPrice,
      this.carRating,
      this.carOwnerId,
      this.carOwnerImage,
      this.carOwnerName,
      this.mySelectedTabMonth,
      this.mySelectedTabPrice})
      : super(key: key);

  @override
  State<EvDescriptionDetailsPage> createState() =>
      _EvDescriptionDetailsPageState();
}

class _EvDescriptionDetailsPageState extends State<EvDescriptionDetailsPage>
    with TickerProviderStateMixin {
  EvCarsModel evSubscriptionCarsModelObject = EvCarsModel();
  int selectedIndex = 0;
  bool loadingP = true;
  String? evStartDate, evEndDate;
  DateTime? enddate;
  String? enddate1;

  String perMonth = "";

   perMonthCalculate(){
     double value1 = double.parse(widget.mySelectedTabMonth.toString());
     double value2 = double.parse(widget.mySelectedTabPrice.toString());
     double perMonths = value2 / value1;
     String formattedPerMonth = perMonths.toStringAsFixed(2);
     NumberFormat format = NumberFormat('#,##0.00', 'en_US');
     formattedPerMonth = format.format(perMonths);
     print("1 $value1");
     print("2 $value2");
     print("perMonth $perMonths");
     print("perMonth22: $formattedPerMonth");
     perMonth = formattedPerMonth.toString();
   }

  getEvSubscriptionCarsWidget() async {
    loadingP = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    try {
      String apiUrl = carsEvSubscriptionApiUrl;
      print("evSubscriptionApi: $apiUrl");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {"users_customers_id": userId},
        headers: {'Accept': 'application/json'},
      );
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("evSubscriptionResponse: ${responseString.toString()}");
        evSubscriptionCarsModelObject = evCarsModelFromJson(responseString);
        print(
            "evSubscriptionObjectLength: ${evSubscriptionCarsModelObject.data!.length}");
        monthList();
      }
    } catch (e) {
      print('Error in evSubscription: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  String? tabMonth, tabPrice;

  List<CustomSubscriptionModel> monthNumber = [];

  monthList() {
    for (int i = 0; i < evSubscriptionCarsModelObject.data!.length; i++) {
      print("OuterLoop:$i");
      for (int j = 0;
          j < evSubscriptionCarsModelObject.data![i].carsPlans!.length;
          j++) {
        if (evSubscriptionCarsModelObject.data![i].carsPlans![j].carsId ==
            carID) {
          monthNumber.add(CustomSubscriptionModel(
              months: evSubscriptionCarsModelObject
                  .data![i].carsPlans![j].months!
                  .toString(),
              price_per_months: evSubscriptionCarsModelObject
                  .data![i].carsPlans![j].pricePerMonth!,
              dis_price_per_months: evSubscriptionCarsModelObject
                  .data![i].carsPlans![j].discountedPricePerMonth!
                  .toString()));

          print("monthNumber123 ${monthNumber[0].months}");
          print("InnerLoop:$j");
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvSubscriptionCarsWidget();
    perMonthCalculate();
    print("mileageID ${widget.mileagePlanID}");
    tabMonth = widget.mySelectedTabMonth;
    tabPrice = widget.mySelectedTabPrice;
    print("tabPrice $tabPrice");
    print("evCarID $carID");
    print("tabMonthAndPrice $tabMonth $tabPrice");
    print("carModelName ${widget.carModelName}");
    print("carModelStatus ${widget.favouriteStatus}");
    // mySelectedData();

    myTotalAmount();
  }

  double totalAmount = 0.0;
  // double setupCosts = 0.0;
  String formattedServiceFee = "";
  // String formattedSetupCost = "";
  myTotalAmount() {
    myServiceFee = (percentage! / 100) * double.parse("$tabPrice");
    print("myServiceFee $myServiceFee");
    print("tabMonthAndPrice11 $tabMonth $tabPrice");
    // setupCosts = double.parse(widget.setupCost.toString());
    totalAmount = double.parse("$tabPrice") + myServiceFee!;
    // totalAmount = double.parse("$tabPrice") + myServiceFee! + setupCosts;
    double tabPriceAsDouble = double.parse(tabPrice ?? '0');
    NumberFormat format = NumberFormat('#,##0.00', 'en_US');
    // formattedSetupCost = format.format(setupCosts);
    String formattedTabPrice = format.format(tabPriceAsDouble);
    tabPrice = formattedTabPrice;
    print("Formatted tabPrice: $tabPrice");
    print("selectedMonthTotal: $totalAmount");
    var pricePerMonthString = totalAmount;
    double pricePerMonth;
    if (pricePerMonthString != null) {
      pricePerMonth = double.parse(pricePerMonthString.toString());
      if (pricePerMonth != null) {
        final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
        formattedServiceFee = numberFormat.format(pricePerMonth);
        // print("RM $formattedPrice");
      } else {
        print("Invalid price format");
      }
    } else {
      print("Price not available");
    }

    evStartDate?.isEmpty;
    evEndDate?.isEmpty;
    print("evStartAndEndDate $evStartDate $evEndDate");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarSingleImageWithText(
        title: "${widget.carName}, ",
        subtitle: "${widget.carYear}",
        backImage: "assets/messages_images/Back.png",
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  homePageDetailsCard(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mileage Package",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: kBlack,
                                fontSize: 14,
                                fontFamily: poppinSemiBold)),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                    child: Text("${widget.selectedMileagePlan}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: poppinRegular,
                                            color: kWhite),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //     width:
                              //     MediaQuery.of(context).size.width * 0.01),
                              // GestureDetector(
                              //     onTap: () {
                              //       // showMyBottomSheet(context);
                              //       _openBottomSheetWithInfo(context);
                              //     },
                              //     child: SvgPicture.asset(
                              //         'assets/icon/edit_booking_icoon.svg')),
                            ],
                          ),
                        ),
                        Text("Select Start and End Date Plan",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: kBlack,
                                fontSize: 14,
                                fontFamily: poppinSemiBold)),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 30.0,
                                decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: tabMonth == "1"
                                        ? Text("$tabMonth Month Plan",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: poppinRegular,
                                                color: kWhite))
                                        : Text("$tabMonth Months Plan",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: poppinRegular,
                                                color: kWhite)),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //     width:
                              //         MediaQuery.of(context).size.width * 0.01),
                              // GestureDetector(
                              //     onTap: () {
                              //       // showMyBottomSheet(context);
                              //       _openBottomSheetWithInfo(context);
                              //     },
                              //     child: SvgPicture.asset(
                              //         'assets/icon/edit_booking_icoon.svg')),
                            ],
                          ),
                        ),
                        // evSubscriptionTabbarWidget(),
                        choosedPlan(),
                        // EvSubscriptionTabbarPage(),
                        SizedBox(height: screenHeight * 0.0),

                        Text(
                            "*A security deposit may be applicable, depending on your eligibility assessment.",
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: poppinRegular,
                                color: borderColor)),
                        SizedBox(height: screenHeight * 0.02),
                        Container(
                          height: screenHeight * 0.1,
                          width: screenWidth,
                          decoration: BoxDecoration(
                              color: kBlack,
                              borderRadius: BorderRadius.circular(25)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
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
                                        Text("Save RM 37,538",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: poppinSemiBold,
                                                color: kWhite)),
                                        SizedBox(width: screenWidth * 0.03),
                                        Container(
                                          height: 25,
                                          width: screenWidth * 0.24,
                                          decoration: BoxDecoration(
                                              color: borderColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text("Learn more",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: poppinRegular,
                                                    color: kWhite)),
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
                        Text("What's Included",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: poppinSemiBold,
                                color: kBlack)),
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
                              if (formKeyEvTabbar.currentState!.validate()) {
                                if (evStartDate == null || enddate == null) {
                                  toastFailedMessage(
                                      "Please select Date", kRed);
                                } else if (differenceInDays != totalDays) {
                                  toastFailedMessage(
                                      "date didn't matched", kRed);
                                } else {
                                  print('selectedMonth: $tabMonth');
                                  print(
                                      'evStartEndDate: $evStartDate $evEndDate');
                                  print('selectedMonthPrice $tabPrice');
                                  print('selectedMonthTotalPrice $totalAmount');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EvDeliveryAddress(
                                                startDate: evStartDate,
                                                endDate: evEndDate,
                                                setupCost: "",
                                                evStartDate: evStartDate,
                                                mileagePlanID: widget.mileagePlanID,
                                                evEndDate: enddate1,
                                                // evDatum: widget.evDatum,
                                                mySelectedTabMonth: tabMonth,
                                                mySelectedTabPrice: tabPrice,
                                                totalAmount: formattedServiceFee.toString(),
                                                favouriteStatus:
                                                    widget.favouriteStatus,

                                                serviceFee: myServiceFee,
                                                carName: widget.carName,
                                                carImage: widget.carImage,
                                                carYear: widget.carYear,
                                                carPrice: widget.carPrice,
                                                carDiscountPrice:
                                                    perMonth.toString(),
                                                carRating: widget.carRating,
                                                carColorName:
                                                    widget.carColorName,
                                                discountPercentage:
                                                    widget.discountPercentage,
                                                carStatus: widget.carStatus,
                                                carId: widget.carId,
                                                carOwnerId: widget.carOwnerId,
                                                carMakesName:
                                                    widget.carMakesName,
                                                carModelName:
                                                    widget.carModelName,
                                              ),
                                      ),
                                  );
                                }
                              }
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
          padding: EdgeInsets.symmetric(horizontal: 05),
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.transparent,
          child: Text(myText,
              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: poppinRegular,
                  color: detailsTextColor)),
        )
      ],
    );
  }

  Widget homePageDetailsCard() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            height: screenHeight * 0.4,
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight * 0.1,
                  ),
                  Row(
                    children: [
                      Text("${widget.carName} ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 14,
                              fontFamily: poppinBold)),
                      Text("${widget.carColorName} ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 12,
                              fontFamily: poppinSemiBold)),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text("${widget.carMakesName}, ",
                  //         textAlign: TextAlign.left,
                  //         style: TextStyle(
                  //             color: kBlack,
                  //             fontSize: 12,
                  //             fontFamily: poppinRegular)),
                  //     Text("${widget.carModelName}, ",
                  //         textAlign: TextAlign.left,
                  //         style: TextStyle(
                  //             color: kBlack,
                  //             fontSize: 12,
                  //             fontFamily: poppinSemiBold)),
                  //     Text("${widget.carYear} ",
                  //         textAlign: TextAlign.left,
                  //         style: TextStyle(
                  //             color: kBlack,
                  //             fontSize: 12,
                  //             fontFamily: poppinRegular)),
                  //   ],
                  // ),
                  Row(
                    children: [
                      widget.discountPercentage != "0.00"
                      ? Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 04),
                            child: Text("RM ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: kRed,
                                    fontSize: 5,
                                    fontFamily: poppinLight)),
                          ),
                          Text("${widget.carPrice}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: kRed,
                                  fontFamily: poppinLight,
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough)),
                        ],
                      )
                          : SizedBox(),
                      // SizedBox(width: screenWidth * 0.01),
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row(
                      //   children: [
                      //     showRatingStars(double.parse("${widget.carRating}")),
                      //     SizedBox(
                      //         width: MediaQuery.of(context).size.height * 0.01),
                      //     widget.carRating == null
                      //         ? Text("0.0",
                      //             textAlign: TextAlign.left,
                      //             style: TextStyle(
                      //                 color: kBlack,
                      //                 fontSize: 14,
                      //                 fontFamily: poppinRegular))
                      //         : Text("${widget.carRating}",
                      //             textAlign: TextAlign.left,
                      //             style: TextStyle(
                      //                 color: kBlack,
                      //                 fontSize: 14,
                      //                 fontFamily: poppinRegular)),
                      //   ],
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 06),
                        child: Text("RM ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: borderColor,
                                fontSize: 7,
                                fontFamily: poppinSemiBold)),
                      ),
                      Text("${perMonth}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: borderColor,
                              fontSize: 20,
                              fontFamily: poppinSemiBold)),
                      Text("/Month",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 8,
                              fontFamily: poppinRegular)),
                      SizedBox(width: screenWidth * 0.25),
                      Container(
                        height: 25,
                        width: 70,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text("Pre book",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 12,
                                  fontFamily: poppinMedium)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text("PRE-BOOK LISTING ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kBlack,
                          fontSize: 14,
                          fontFamily: poppinSemiBold)),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                      "This vehicle may take more than 7 days to deliver, based on vehicle’s availability",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kBlack,
                          fontSize: 10,
                          fontFamily: poppinRegular)),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 40,
          right: 40,
          top: -15,
          // top: widget.carImage!.endsWith('.jpg') || widget.carImage!.endsWith('.png') || widget.carImage!.endsWith('.jpeg')
          //     ? 20
          //     : -50,
          child: widget.carImage!.endsWith('.jpg') || widget.carImage!.endsWith('.png') || widget.carImage!.endsWith('.jpeg')
              ?  Image.network("${widget.carImage}",
              // fit: BoxFit.contain,
              // height: 200, width: 200,
          ) :
          Container(
            height: 200,
            child: ModelViewer(
              backgroundColor: Colors.transparent,
              // src: '$baseUrlImage${topRentedCarsModelObject.data?[index].image1}',
              src: '${widget.carImage}',
              alt: "A 3D model of car",
              autoPlay: false,
              autoRotate: false,
              cameraControls: false,
              disableTap: false,
              ar: false,
              disablePan: true,
              arModes: ["quicklook", "scene-viewer"],
              iosSrc: '${widget.carImage}',
              disableZoom: true,
            ),
          ),
        ),
        widget.discountPercentage != "0.00"
        ? Positioned(
            top: 28,
            left: 25,
            child: Container(
              height: screenHeight * 0.035,
              width: screenWidth * 0.18,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.discountPercentage}% ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 13,
                          fontFamily: poppinSemiBold)),
                  Text("OFF",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 8,
                          fontFamily: poppinRegular)),
                ],
              ),
            ))
            : SizedBox(),
        Positioned(
          top: 28,
          right: 27,
          child: widget.favouriteStatus == 'like'
              ? Image.asset("assets/home_page/heart.png")
              : Image.asset("assets/car_bookings_images/heart.png"),
        ),
      ],
    );
  }

  DateTime? startDatePicked, endDatePicked;

  int? totalDaysOfMonth;
  Future<void> selectStartDateWidget(BuildContext context) async {
    totalDaysOfMonth = int.parse("$tabMonth") * 30;
    print("totalDaysOfMonth $totalDaysOfMonth");
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDatePicked ?? DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2100));
    if (picked != null && picked != startDatePicked) {
      setState(() {
        evStartDate = DateFormat('yyyy-MM-dd').format(picked);
        startDatePicked = picked;
        endDatePicked =
            picked.add(Duration(days: int.parse("$totalDaysOfMonth")));
        evStartDate = DateFormat('yyyy-MM-dd').format(startDatePicked!);
        evEndDate = DateFormat('yyyy-MM-dd').format(endDatePicked!);
        var newDate = DateTime(startDatePicked!.year + 1,
            startDatePicked!.month, startDatePicked!.day);
        enddate = newDate;
        enddate1 = DateFormat('yyyy-MM-dd').format(enddate!);
        print('endDate: $enddate');
        setState(() {});
        print("evStartDate $evStartDate");
        print("evEndDate $evEndDate");
      });
    }
  }

  selectEndDateWidget(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // firstDate: DateTime(2000),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != pickDate) {
      evEndDate = DateFormat('yyyy-MM-dd').format(picked);
      startDatePicked = picked;
      setState(() {
        print("SelectedEndDate is $evEndDate");
        print("evMonth $evSelectedMonth");
        print("tabNewValueEnd $tabNewValue");
        calculateDateInterval();
      });
    }
  }

  int? differenceInDays, totalDays;
  calculateDateInterval() {
    var format = DateFormat("yyyy-MM-dd");
    print(evStartDate);
    print(evEndDate);
    var start = format.parse(evStartDate!);
    var end = format.parse(evEndDate!);

    print("startDate $start");
    print("endDate $end");

    Duration difference = end.difference(start).abs();
    differenceInDays = difference.inDays;
    print("dateDifferenceInDays $differenceInDays");
    print("totalMonth $tabMonth");

    totalDays = int.parse(tabMonth.toString()) * 30;
    print("totalDays $totalDays");
    if (differenceInDays! == totalDays!) {
      // toastSuccessMessage("date matched", colorGreen);
    } else {
      toastFailedMessage("date didn't matched", kRed);
    }
  }

  final GlobalKey<FormState> formKeyEvTabbar = GlobalKey<FormState>();

  Widget choosedPlan() {
    return Form(
      key: formKeyEvTabbar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            InkWell(
              onTap: () {
                selectStartDateWidget(context);
              },
              child: evStartDate == null
                  ? Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Start Date",
                          style: TextStyle(color: kBlack, fontSize: 16),
                        ),
                      ),
                    )
                  : Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          evStartDate!,
                          style: TextStyle(color: kWhite, fontSize: 16),
                        ),
                      ),
                    ),
            ),
                Text(
                  "to",
                  style: TextStyle(color: kBlack, fontSize: 16),
                ),
            InkWell(
                onTap: () {
                  selectEndDateWidget(context);
                },
                child: enddate1 == null
                    ? Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("End Date",
                              style: TextStyle(color: kBlack, fontSize: 16)),
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            evEndDate!,
                            style: TextStyle(color: kWhite, fontSize: 16),
                          ),
                        ),
                      )),
          ]
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tabMonth == "1"
                  ? Text("$tabMonth Month Plan",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinRegular,
                          color: detailsTextColor))
                  : Text("$tabMonth Months Plan",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: poppinRegular,
                          color: detailsTextColor)),
              Text("RM $tabPrice",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: poppinRegular,
                      color: detailsTextColor)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Service Fee (6%)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: poppinRegular,
                      color: detailsTextColor)),
              Text("RM ${myServiceFee!.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: poppinRegular,
                      color: detailsTextColor)),
            ],
          ),
          // SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("Setup Cost",
          //         textAlign: TextAlign.left,
          //         style: TextStyle(
          //             fontSize: 14,
          //             fontFamily: poppinRegular,
          //             color: detailsTextColor)),
          //     Text("RM ${formattedSetupCost}",
          //         textAlign: TextAlign.right,
          //         style: TextStyle(
          //             fontSize: 14,
          //             fontFamily: poppinRegular,
          //             color: detailsTextColor)),
          //   ],
          // ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Amount",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
              Text("RM $formattedServiceFee",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
            ],
          ),
        ],
      ),
    );
  }
}
