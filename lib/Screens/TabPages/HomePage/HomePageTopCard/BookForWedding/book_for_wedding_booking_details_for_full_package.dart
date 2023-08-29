import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/home_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'PhotoAddress/photo_delivery_address.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';

class BookForWeddingBookingDetailsForFullPackage extends StatefulWidget {
  String? startDate,
      endDate,
      // selectedDate,
      selectedHours;
  // selectedDay,
  //     selectedStartTime,
  //     selectedEndTime;
  final int? hoursInNumber;
  final String? carName,
      carImage,
      carYear,
      carPrice,
      favouriteStatus,
      carColorName,
      driverCharges,
      carModelName,
      carMakesName,
      carMakesImage,
      carRating,
      carOwnerImage,
      carOwnerName,
      discountPercentage,
      carDeposit,
      carDiscountPrice;
  final int? carId, carOwnerId;

  BookForWeddingBookingDetailsForFullPackage({
    Key? key,
    /* this.datumPhotography,*/
    this.startDate,
    this.endDate,
    // this.selectedStartTime,
    // this.selectedEndTime,
    // this.selectedDay,
    this.hoursInNumber,
    this.selectedHours,
    // this.selectedDate,
    this.carName,
    this.carColorName,
    this.carModelName,
    this.discountPercentage,
    this.carDiscountPrice,
    this.carImage,
    this.carYear,
    this.carMakesImage,
    this.favouriteStatus,
    this.carMakesName,
    this.driverCharges,
    this.carDeposit,
    this.carId,
    this.carPrice,
    this.carRating,
    this.carOwnerId,
    this.carOwnerImage,
    this.carOwnerName,
  }) : super(key: key);

  @override
  State<BookForWeddingBookingDetailsForFullPackage> createState() =>
      _BookForWeddingBookingDetailsForFullPackageState();
}

class _BookForWeddingBookingDetailsForFullPackageState
    extends State<BookForWeddingBookingDetailsForFullPackage> {
  String? valueTimeStart, valueTimeEnd;
  TimeOfDay? startTime;
  final GlobalKey<FormState> formKeyPhotography = GlobalKey<FormState>();
  bool loadingP = true;
  String? valueDay;
  int depositFee = 200;
  int driverFee = 300;

  mySelectedData() {
    print("startDate: ${widget.startDate}");
    print("endDate: ${widget.endDate}");
    // valueDate = "${widget.selectedDate}";
    // print("mySelectedDate: $valueDate");
    // print("mySelectedDay: $valueDay");
    // print("mySelectedTime: $dropdownValueTime");
    // print("mySelectedHours: $myHours");
    // print(
    //     "mySelected Time: ${widget.selectedStartTime} ${widget.selectedEndTime}");
    calculatePricePerHour();
    myTotal();
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != pickDate) {
      valueDating = DateFormat('MMMM yyyy').format(picked);
      valueDay = DateFormat('EE, d').format(picked);
      setState(() {
        print("Selected Date in Booking : $valueDating");
        print("Selected Day in Booking : $valueDay");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // myHours = widget.hoursInNumber;
    // valueDay = widget.selectedDay;
    dropdownValueTime = "${widget.selectedHours}";
    print("myHours: ${widget.hoursInNumber}");
    print("carDeposit,: ${widget.carDeposit}");
    print("startDate,: ${widget.startDate}");
    print("endDate,: ${widget.endDate}");
    mySelectedData();
    // valueTimeStart = widget.selectedStartTime;
    // valueTimeEnd = widget.selectedEndTime;
  }

  double pricePerHrs = 0.0;
  double totalPricePerHrs = 0.0;

  int? myHours;

  calculatePricePerHour() {
    pricePerHrs = double.parse("${widget.carDiscountPrice}") *
        int.parse(widget.hoursInNumber.toString());
    setState(() {});
    print("perHourPrice: $pricePerHrs");
    print("hoursInNumber: ${widget.hoursInNumber}");
    print("carDiscountPrice: ${widget.carDiscountPrice}");
  }


  myTotal() {
    myServiceFee = (percentage! / 100) * double.parse("$pricePerHrs");
    totalPricePerHrs = pricePerHrs + double.parse(widget.carDeposit.toString()) + double.parse(widget.driverCharges.toString()) + myServiceFee!;
    print("totalPerHour: $totalPricePerHrs");
  }

  @override
  Widget build(BuildContext context) {
    // calculatePricePerHour();
    // myTotal();
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
                  bookForWeddingBookingCard(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Choose Subscription plan",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: kBlack,
                                fontSize: 14,
                                fontFamily: poppinSemiBold)),
                        // SizedBox(height: MediaQuery.of(context).size.height* 0.01),
                        // BFWChooseSubscriptionPlan(),
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
                                    child: Text('${widget.selectedHours}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: poppinRegular,
                                            color: kWhite)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.01),
                              GestureDetector(
                                  onTap: () {
                                    openBottomSheetPhotoCars(context);
                                  },
                                  child: SvgPicture.asset(
                                      'assets/icon/edit_booking_icoon.svg')),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${widget.selectedHours} Plan",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: poppinRegular,
                                  fontSize: 14,
                                  color: detailsTextColor),
                            ),
                            Text("RM $pricePerHrs",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: poppinRegular,
                                    fontSize: 14,
                                    color: detailsTextColor)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Driver Fee",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: poppinRegular,
                                    fontSize: 14,
                                    color: detailsTextColor)),
                            Text("RM ${widget.driverCharges}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: poppinRegular,
                                    fontSize: 14,
                                    color: detailsTextColor)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Deposit Fee",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: poppinRegular,
                                    fontSize: 14,
                                    color: detailsTextColor)),
                            Text("RM ${widget.carDeposit}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: poppinRegular,
                                    fontSize: 14,
                                    color: detailsTextColor)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Service Fee (6%)",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: poppinRegular,
                                    fontSize: 14,
                                    color: detailsTextColor)),
                            if (myServiceFee != null)
                              Text("RM ${myServiceFee!.toStringAsFixed(2)}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontFamily: poppinRegular,
                                      fontSize: 14,
                                      color: detailsTextColor)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: poppinSemiBold,
                                  color: kBlack),
                            ),
                            Text("RM $totalPricePerHrs",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: poppinSemiBold,
                                    color: kBlack)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
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
                                          PhotoDeliveryAddress(
                                            // myDatumPhotography: widget.datumPhotography,
                                            selectedHoursInString: widget.selectedHours,
                                            totalHoursInNumber: widget.hoursInNumber,
                                            hoursAmount: pricePerHrs,
                                            totalAmount: totalPricePerHrs.toDouble(),
                                            myDate: valueDating,
                                            myDay: valueDay,
                                            selectedStartTime: widget.startDate == null ? formatDate(startDate) : widget.startDate,
                                            selectedEndTime:   widget.endDate == null ? formatDate(endDate) : widget.endDate,
                                            // carDeposit: depositFee.toString(),
                                            carDeposit: widget.carDeposit,
                                            driverCharges: widget.driverCharges,
                                            // driverCharges: driverFee.toString(),
                                            carName: widget.carName,
                                            carYear: widget.carYear,
                                            carId: widget.carId,
                                            carRating: widget.carRating,
                                            carColorName: widget.carColorName,
                                            carMakesName: widget.carMakesName,
                                            carModelName: widget.carModelName,
                                            carImage: widget.carImage,
                                            carMakesImage:
                                                widget.carMakesImage,
                                            favouriteStatus:
                                                widget.favouriteStatus,
                                            discountPercentage:
                                                widget.discountPercentage,
                                            carDiscountPrice:
                                                widget.carDiscountPrice,
                                            carPrice: widget.carPrice,
                                            carOwnerImage:
                                                widget.carOwnerImage,
                                            carOwnerName: widget.carOwnerName,
                                            carOwnerId: widget.carOwnerId,
                                          )));
                              print(
                                  "startAndEndTime $valueTimeStart $valueTimeEnd");
                              print("valueDate $valueDating");
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
          padding: EdgeInsets.symmetric(horizontal: 07),
          width: MediaQuery.of(context).size.width * 0.8,
          color: Colors.transparent,
          child: Text(myText,
              textAlign: TextAlign.left,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: poppinRegular,
                  color: detailsTextColor)),
        ),
      ],
    );
  }

  Widget bookForWeddingBookingCard() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            height: screenHeight * 0.41,
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
                  Container(height: screenHeight * 0.1),
                  Row(
                    children: [
                      Text("${widget.carName} ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 14,
                              fontFamily: poppinBold)),
                      Text("${widget.carYear}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 10,
                              fontFamily: poppinRegular)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("${widget.carMakesName} ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 12,
                              fontFamily: poppinRegular)),
                      Text("${widget.carModelName} ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 14,
                              fontFamily: poppinRegular)),
                    ],
                  ),
                  Row(
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
                      SizedBox(width: screenWidth * 0.01),
                      Padding(
                        padding: EdgeInsets.only(top: 06),
                        child: Text("RM ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: borderColor,
                                fontSize: 7,
                                fontFamily: poppinSemiBold)),
                      ),
                      Text("${widget.carDiscountPrice}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: borderColor,
                              fontSize: 20,
                              fontFamily: poppinSemiBold)),
                      Text("/Hour",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 8,
                              fontFamily: poppinRegular)),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          // Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                          showRatingStars(double.parse("${widget.carRating}")),
                          SizedBox(
                              width: MediaQuery.of(context).size.height * 0.01),
                          widget.carRating == null
                              ? Text("0.0",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: kBlack,
                                      fontSize: 14,
                                      fontFamily: poppinRegular))
                              : Text("${widget.carRating}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: kBlack,
                                      fontSize: 14,
                                      fontFamily: poppinRegular)),
                        ],
                      ),
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
          left: 45,
          right: 20,
          top: 10,
          child: widget.carImage == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/icon/fade_in_image.jpeg'))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                    height: 130,
                    image: NetworkImage("${widget.carImage}"),
                  ),
                ),
        ),
        Positioned(
            top: 28,
            left: 27,
            child: Container(
              height: screenHeight * 0.04,
              width: screenWidth * 0.2,
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
            )),
        Positioned(
          top: 28,
          right: 27,
          child: widget.favouriteStatus == "like"
              ? Image.asset("assets/home_page/heart.png")
              : Image.asset("assets/home_page/heart_transparent.png",
                  color: kBlack),
        ),
      ],
    );
  }

  dynamic totalHours, minutes;
  int? myMinutes, selectedMinutes;
  calculateTimeInterval() {
    var format = DateFormat("HH:mm");
    var start = format.parse("$valueTimeStart");
    var end = format.parse("$valueTimeEnd");
    // print("timeDifference ${end.difference(start)}");

    Duration diff = end.difference(start).abs();
    totalHours = diff.inHours;
    // minutes = diff.inMinutes / 60;
    minutes = diff.inMinutes % 60;
    print('selectedTime interval $totalHours');
    print('$totalHours hours $minutes minutes');

    myMinutes = int.parse(myHours.toString()) * 60;
    selectedMinutes = (totalHours * 60) + minutes;
    print("myMinutesBottomSheet $myMinutes $selectedMinutes");
    print("valueHours $myHours $totalHours");

    if (myMinutes == selectedMinutes) {
      // toastSuccessMessage("time matched successfully", colorGreen);
      print("success");
    } else {
      toastFailedMessage("time didn't matched", kRed);
      print("no success");
    }
  }

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String formatDate(DateTime? date) {
    return date != null ? dateFormat.format(date) : '';
  }
  DateTime? startDate;
  DateTime? endDate;

  void openBottomSheetPhotoCars(BuildContext context) {
    showFlexibleBottomSheet<void>(
      isExpand: false,
      initHeight: 0.8,
      maxHeight: 0.8,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context, controller, offset) {
        var size = MediaQuery.of(context).size;
        // final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        // String? selectedValue = '1 day';
        // DateTime? startDate;
        // DateTime? endDate;
        String? selectedValue = widget.selectedHours;
        int value1 = 0;

        Future<void> selectDatePicker(
            BuildContext context, bool isStartDate) async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: isStartDate
                ? startDate ?? DateTime.now()
                : endDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (picked != null) {
            setState(() {
              if (isStartDate) {
                startDate = picked;
                if (selectedValue == '1 day') {
                  endDate = startDate?.add(const Duration(days: 1));
                } else if (selectedValue == '3 day') {
                  endDate = startDate?.add(const Duration(days: 3));
                } else if (selectedValue == '7 day') {
                  endDate = startDate?.add(const Duration(days: 7));
                }
              } else {
                endDate = picked;
              }
            });
          }
        }

        // void onDropdownChanged(String? value) {
        //   setState(() {
        //     selectedValue = value;
        //     if (selectedValue == '1 day') {
        //       endDate = startDate?.add(const Duration(days: 1));
        //     } else if (selectedValue == '3 day') {
        //       endDate = startDate?.add(const Duration(days: 3));
        //     } else if (selectedValue == '7 day') {
        //       endDate = startDate?.add(const Duration(days: 7));
        //     }
        //     print('selectedPackage: $selectedValue');
        //   });
        // }


        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetterObject) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: homeBgColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text('Change Available Slot',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: poppinBold,
                            color: appBgColor)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Container(
                        height: size.height * 0.055,
                        width: MediaQuery.of(context).size.width * 01.3,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Color(0xff7E7E7E))),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text('Select Package',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color: kBlack,
                                          fontWeight: FontWeight.w400))),
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  size: 30, color: kBlack),
                              items: daysPackageList
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  color: kBlack,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                    ),
                                  )
                                  .toList(),
                              value: selectedValue,
                              onChanged: (String? value) {
                                stateSetterObject(() {
                                  selectedValue = value;
                                  if (selectedValue == '1 day') {
                                    endDate =
                                        startDate?.add(const Duration(days: 1));
                                  } else if (selectedValue == '3 day') {
                                    endDate =
                                        startDate?.add(const Duration(days: 3));
                                  } else if (selectedValue == '7 day') {
                                    endDate =
                                        startDate?.add(const Duration(days: 7));
                                  }
                                  print('selectedPackage: $selectedValue');
                                  widget.selectedHours = selectedValue;
                                  print('selectedHours: ${widget.selectedHours}');
                                   value1 = int.parse(selectedValue!.split(" day").first);
                                  print("selectedTime: $value1");
                                });
                                // myHours = int.parse(selectedValue!);
                                // print('myHours: $myHours');
                              },
                              buttonWidth:
                                  MediaQuery.of(context).size.width * 0.2,
                              dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              dropdownMaxHeight:
                                  MediaQuery.of(context).size.height * 0.25,
                              scrollbarThickness: 0,
                              itemHeight: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                bool isStartDate = true;
                                // selectDatePicker(context, true);
                                // Future<void> selectDatePicker(
                                    // BuildContext context, bool isStartDate) async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: isStartDate
                                        ? startDate ?? DateTime.now()
                                        : endDate ?? DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );

                                  if (picked != null) {
                                    stateSetterObject(() {
                                      if (isStartDate) {
                                        startDate = picked;
                                        if (selectedValue == '1 day') {
                                          endDate = startDate?.add(const Duration(days: 1));
                                        } else if (selectedValue == '3 day') {
                                          endDate = startDate?.add(const Duration(days: 3));
                                        } else if (selectedValue == '7 day') {
                                          endDate = startDate?.add(const Duration(days: 7));
                                        }
                                      } else {
                                        endDate = picked;
                                      }
                                    });
                                  }
                                // }
                              },
                              child: startDate != null
                                  ? Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: borderColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "${formatDate(startDate)}",
                                          style: TextStyle(
                                              color: kWhite, fontSize: 16),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "Start Date",
                                          style: TextStyle(
                                              color: kBlack, fontSize: 16),
                                        ),
                                      ),
                                    ),
                            ),
                            InkWell(
                                onTap: () {
                                  // selectDatePicker(context, false);
                                },
                                child: endDate != null
                                    ? Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: borderColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text("${formatDate(endDate)}",
                                              style: TextStyle(
                                                  color: kWhite, fontSize: 16)),
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "End Date",
                                            style: TextStyle(
                                                color: kBlack, fontSize: 16),
                                          ),
                                        ),
                                      )),
                          ]),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                GestureDetector(
                    onTap: () {
                      int values = value1 * 24;
                      print("values $values");
                      pricePerHrs = double.parse("${widget.carDiscountPrice}") *
                          int.parse(values.toString());
                      setState(() {});
                      print("perHourPrice: $pricePerHrs");
                      myServiceFee = (percentage! / 100) * double.parse("$pricePerHrs");
                      totalPricePerHrs = pricePerHrs + double.parse(widget.carDeposit.toString()) + double.parse(widget.driverCharges.toString()) + myServiceFee!;
                      print("totalPerHour: $totalPricePerHrs");
                      // myServiceFee = (percentage! / 100) * double.parse("$pricePerHrs");
                      // totalPricePerHrs = pricePerHrs + depositFee + driverFee + myServiceFee!;
                      // print("totalPerHour: $totalPricePerHrs");
                      // mySelectedData();
                      Navigator.pop(context);
                    },
                    child: loginButton('Update', context)),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: borderColor),
                        ),
                        child: Center(
                          child: Text('Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: borderColor,
                                  fontFamily: poppinRegular,
                                  fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  // showMyBottomSheet(context) {
  //   var size = MediaQuery.of(context).size;
  //   return showMaterialModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter stateSetterObject) {
  //           return Container(
  //             height: MediaQuery.of(context).size.height * 0.55,
  //             width: MediaQuery.of(context).size.width,
  //             decoration: BoxDecoration(
  //               color: homeBgColor,
  //               borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(20),
  //                   topLeft: Radius.circular(20)),
  //             ),
  //             child: Column(
  //               children: [
  //                 SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //                 Align(
  //                   alignment: Alignment.topLeft,
  //                   child: Padding(
  //                     padding: EdgeInsets.only(left: 16),
  //                     child: Text('Change Available Time Slot',
  //                         textAlign: TextAlign.left,
  //                         style: TextStyle(
  //                             fontSize: 14,
  //                             fontFamily: poppinBold,
  //                             color: appBgColor)),
  //                   ),
  //                 ),
  //                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
  //                 Column(
  //                   children: [
  //                     GestureDetector(
  //                       onTap: () async {
  //                         DateTime? picked = await showDatePicker(
  //                           context: context,
  //                           initialDate: DateTime.now(),
  //                           // firstDate: DateTime(1980),
  //                           firstDate: DateTime.now().subtract(Duration(days: 0)),
  //                           lastDate: DateTime(2050),
  //                         );
  //                         if (picked != null && picked != pickDate) {
  //                           // valueDate = DateFormat('yyyy-MM-dd').format(picked);
  //                           // valueDay = DateFormat('EE, d').format(picked);
  //                           valueDate = DateFormat('yyyy-MM-dd').format(picked);
  //                           valueDay = DateFormat('EEEE, dd MMMM').format(picked);
  //
  //                           stateSetterObject(() {
  //                             print("Selected date in bottomSheet : $valueDate");
  //                             print("Selected Day in bottomSheet : $valueDay");
  //                           });
  //                         }
  //                       },
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Icon(Icons.keyboard_arrow_left, color: borderColor),
  //                           Text(
  //                             "$valueDate",
  //                             textAlign: TextAlign.left,
  //                             style: TextStyle(
  //                                 fontSize: 14,
  //                                 fontFamily: poppinSemiBold,
  //                                 color: borderColor),
  //                           ),
  //                           Icon(Icons.keyboard_arrow_right,
  //                               color: borderColor),
  //                         ],
  //                       ),
  //                     ),
  //                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //                     valueDay == null ?
  //                     Container(
  //                       width: 200,
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         color: kWhite,
  //                         borderRadius: BorderRadius.circular(15),
  //                       ),
  //                       child: Center(
  //                         child: Text("$valueDay", style: TextStyle(
  //                               fontSize: 14, fontFamily: poppinMedium, color: kBlack)),
  //                             ),
  //                           )
  //                         : Container(
  //                             width: 200,
  //                             height: 40,
  //                             decoration: BoxDecoration(
  //                               color: borderColor,
  //                               borderRadius: BorderRadius.circular(15),
  //                             ),
  //                             child: Center(
  //                               child: Text("$valueDay", style: TextStyle(
  //                                   fontSize: 14, fontFamily: poppinMedium, color: kWhite)),
  //                             ),
  //                           ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                       child: Container(
  //                         height: size.height * 0.055,
  //                         width: MediaQuery.of(context).size.width * 01.3,
  //                         decoration: BoxDecoration(
  //                             color: kWhite,
  //                             borderRadius: BorderRadius.circular(15),
  //                             border: Border.all(color: Color(0xff7E7E7E))),
  //                         child: Padding(
  //                           padding: EdgeInsets.only(left: 10, right: 10),
  //                           child: DropdownButtonHideUnderline(
  //                             child: DropdownButton2(
  //                               hint: Text('Select Hours', style: GoogleFonts.poppins(textStyle: TextStyle(
  //                                           fontSize: 12, color: kBlack, fontWeight: FontWeight.w400))),
  //                               icon: Icon(Icons.keyboard_arrow_down_rounded, size: 30, color: kBlack),
  //                               items: timeHoursList.map(
  //                                     (item) => DropdownMenuItem<String>(value: item,
  //                                       child: Text(item, style: GoogleFonts.poppins(textStyle: TextStyle(
  //                                           fontSize: 14, color: kBlack, fontWeight: FontWeight.w400))),
  //                                     ),
  //                                   ).toList(),
  //                               value: dropdownValueTime,
  //                               onChanged: (String? newValue) {
  //                                 stateSetterObject(() {
  //                                   dropdownValueTime = newValue!.split(" hours").first;
  //                                   myHours = int.parse(dropdownValueTime);
  //                                   dropdownValueTime = newValue;
  //                                   print("selectedTime in bottomSheet: $dropdownValueTime");
  //                                   print("selectedHour in bottomSheet: $myHours");
  //                                 });
  //                               },
  //                               buttonWidth: MediaQuery.of(context).size.width * 0.2,
  //                               dropdownDecoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10)),
  //                               dropdownMaxHeight: MediaQuery.of(context).size.height * 0.25,
  //                               scrollbarThickness: 0,
  //                               itemHeight: 30,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             InkWell(
  //                                 onTap: () async {
  //                                   TimeOfDay? picked;
  //                                   picked = await showTimePicker(
  //                                     context: context,
  //                                     initialTime: TimeOfDay.now(),
  //                                   );
  //                                   if (picked == null) {
  //                                     picked = startTime;
  //                                   } else {
  //                                     valueTimeStart = picked.format(context).toString();
  //                                     // setState(() {
  //                                     //   print("Selected startTime is : $valueTimeStart");
  //                                     // });
  //                                     valueTimeStart = '${picked.hour}:${picked.minute}:00';
  //                                     stateSetterObject(() {
  //                                       print("Selected startTime is : $valueTimeStart");
  //                                       print("myTime $valueTimeStart");
  //                                     });
  //                                   }
  //                                 },
  //                                 child: Container(
  //                                   height: 40,
  //                                   width: 120,
  //                                   decoration: BoxDecoration(
  //                                       color: valueTimeStart == "Start Time" ? kWhite : borderColor,
  //                                       borderRadius: BorderRadius.circular(10)),
  //                                   child: Center(
  //                                     child: Text("$valueTimeStart", style: TextStyle(fontSize: 16,
  //                                         color: valueTimeStart == "Start Time" ? kBlack : kWhite)),
  //                                   ),
  //                                 ),
  //                             ),
  //                             InkWell(
  //                                 onTap: () async {
  //                                   TimeOfDay? picked;
  //                                   picked = await showTimePicker(
  //                                     context: context,
  //                                     initialTime: TimeOfDay.now(),
  //                                   );
  //                                   if (picked == null) {
  //                                     picked = startTime;
  //                                   } else {
  //                                     valueTimeEnd = picked.format(context).toString();
  //                                     // setState(() {
  //                                     //   print("Selected endTime is: $valueTimeEnd");
  //                                     // });
  //                                     valueTimeEnd = '${picked.hour}:${picked.minute}:00';
  //                                     stateSetterObject(() {
  //                                       print("Selected endTime is : $valueTimeEnd");
  //                                       calculateTimeInterval();
  //                                       // compareTime();
  //                                     });
  //                                     print("myEndTime $valueTimeEnd");
  //                                   }
  //                                 },
  //                                 child: Container(
  //                                   height: 40,
  //                                   width: 120,
  //                                   decoration: BoxDecoration(
  //                                     color: valueTimeEnd == "End Time" ? kWhite : borderColor,
  //                                     borderRadius: BorderRadius.circular(10),
  //                                   ),
  //                                   child: Center(
  //                                     child: Text("$valueTimeEnd", style: TextStyle(fontSize: 16,
  //                                           color: valueTimeEnd == "End Time" ? kBlack : kWhite)),
  //                                   ),
  //                                 )),
  //                           ]),
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //                 GestureDetector(
  //                     onTap: () {
  //                       mySelectedData();
  //                       Navigator.pop(context);
  //                     },
  //                     child: loginButton('Update', context)),
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Padding(
  //                     padding: EdgeInsets.symmetric(
  //                         horizontal: 20, vertical: 10),
  //                     child: Center(
  //                       child: Container(
  //                         height: MediaQuery.of(context).size.height * 0.06,
  //                         width: MediaQuery.of(context).size.width * 0.7,
  //                         decoration: BoxDecoration(
  //                           color: Colors.transparent,
  //                           borderRadius: BorderRadius.circular(30),
  //                           border: Border.all(width: 1, color: borderColor),
  //                         ),
  //                         child: Center(
  //                           child: Text('Cancel',
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(
  //                                   color: borderColor,
  //                                   fontFamily: poppinRegular,
  //                                   fontSize: 18)),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         });
  //       });
  // }
}