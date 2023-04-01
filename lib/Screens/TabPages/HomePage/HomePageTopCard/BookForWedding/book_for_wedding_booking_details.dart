import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'PhotoAddress/photo_delivery_address.dart';

class BookForWeddingBookingDetails extends StatefulWidget {
  // final DatumPhotography? datumPhotography;
  final String? selectedDate, selectedHours, selectedDay, selectedStartTime, selectedEndTime;
  final int? hoursInNumber;
  final String? carName, carImage, carYear, carPrice, favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, carOwnerName, discountPercentage, carDiscountPrice;
  final int? carId, carOwnerId;

  const BookForWeddingBookingDetails({Key? key,
   /* this.datumPhotography,*/ this.selectedStartTime,
    this.selectedEndTime, this.selectedDay, this.hoursInNumber,
    this.selectedHours, this.selectedDate,
    this.carName, this.carColorName, this.carModelName, this.discountPercentage,
    this.carDiscountPrice, this.carImage, this.carYear, this.carMakesImage,
    this.favouriteStatus, this.carMakesName, this.carId, this.carPrice, this.carRating,
    this.carOwnerId, this.carOwnerImage, this.carOwnerName
  }) : super(key: key);

  @override
  State<BookForWeddingBookingDetails> createState() =>
      _BookForWeddingBookingDetailsState();
}

class _BookForWeddingBookingDetailsState extends State<BookForWeddingBookingDetails> {
  String? valueTimeStart, valueTimeEnd;
  TimeOfDay? startTime;
  final GlobalKey<FormState> formKeyPhotography = GlobalKey<FormState>();
  bool loadingP = true;
  String? valueDay;

  mySelectedData() {
    valueDate = "${widget.selectedDate}";
    print("mySelectedDate: $valueDate");
    print("mySelectedDay: $valueDay");
    print("mySelectedTime: $dropdownValueTime");
    print("mySelectedHours: $myHours");
    print("mySelected Time: ${widget.selectedStartTime} ${widget.selectedEndTime}");
    calculatePricePerHour();
    myTotal();
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != pickDate) {
      valueDate = DateFormat('MMMM yyyy').format(picked);
      valueDay = DateFormat('EE, d').format(picked);
      setState(() {
        print("Selected Date in Booking : $valueDate");
        print("Selected Day in Booking : $valueDay");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    myHours = widget.hoursInNumber;
    valueDay = widget.selectedDay;
    dropdownValueTime = "${widget.selectedHours}";
    mySelectedData();
    valueTimeStart = widget.selectedStartTime;
    valueTimeEnd = widget.selectedEndTime;
  }

  double pricePerHrs = 0.0;
  double totalPricePerHrs = 0.0;

  int? myHours;

  calculatePricePerHour() {
    pricePerHrs = double.parse("${widget.carDiscountPrice}") * int.parse(myHours.toString());
    setState(() {});
    print("perHourPrice: $pricePerHrs");
  }

  myTotal() {
    totalPricePerHrs = pricePerHrs + serviceFee;
    print("totalPerHour: $totalPricePerHrs");
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  bookForWeddingBookingCard(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        // const BFWChooseSubscriptionPlan(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text('$valueDay - $dropdownValueTime',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: poppinRegular,
                                            color: kWhite)),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width*0.01),
                              GestureDetector(
                                  onTap: () {
                                    openBottomSheetPhotoCars(context);
                                  },
                                  child: SvgPicture.asset('assets/icon/edit_booking_icoon.svg')),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$dropdownValueTime Plan",
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
                            Text("Service Fee (6%)",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: poppinRegular,
                                    fontSize: 14,
                                    color: detailsTextColor)),
                            Text("RM $serviceFee",
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
                                      builder: (context) => PhotoDeliveryAddress(
                                        // myDatumPhotography: widget.datumPhotography,
                                        selectedHoursInString: dropdownValueTime,
                                        totalHoursInNumber: myHours,
                                        hoursAmount: pricePerHrs,
                                        totalAmount: totalPricePerHrs,
                                        myDate: valueDate,
                                        myDay: valueDay,
                                        selectedStartTime: valueTimeStart,
                                        selectedEndTime: valueTimeEnd,

                                        carName: widget.carName,
                                        carYear: widget.carYear,
                                        carId: widget.carId,
                                        carRating: widget.carRating,
                                        carColorName: widget.carColorName,
                                        carMakesName: widget.carMakesName,
                                        carModelName: widget.carModelName,
                                        carImage: widget.carImage,
                                        carMakesImage: widget.carMakesImage,
                                        favouriteStatus: widget.favouriteStatus,
                                        discountPercentage: widget.discountPercentage,
                                        carDiscountPrice: widget.carDiscountPrice,
                                        carPrice: widget.carPrice,
                                        carOwnerImage: widget.carOwnerImage,
                                        carOwnerName: widget.carOwnerName,
                                        carOwnerId: widget.carOwnerId,

                                          )));
                              print("startAndEndTime $valueTimeStart $valueTimeEnd");
                              print("valueDate $valueDate");
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
          child: Text(myText, textAlign: TextAlign.left, maxLines: 2, style: TextStyle(
                  fontSize: 10, fontFamily: poppinRegular, color: detailsTextColor)),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: screenHeight * 0.1),
                  Row(
                    children: [
                      Text("${widget.carName} ",
                          textAlign: TextAlign.left, style: TextStyle(
                              color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                            Text("${widget.carYear}",
                                textAlign: TextAlign.left, style: TextStyle(
                                    color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${widget.carMakesName} ",
                                textAlign: TextAlign.left, style: TextStyle(
                                    color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                            Text("${widget.carModelName} ",
                                textAlign: TextAlign.left, style: TextStyle(
                                    color: kBlack, fontSize: 14, fontFamily: poppinRegular)),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 04),
                              child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                      color: kRed, fontSize: 5, fontFamily: poppinLight)),
                            ),
                            Text("${widget.carPrice}",
                                textAlign: TextAlign.left, style: TextStyle(color: kRed,
                                    fontFamily: poppinLight, fontSize: 10, decoration: TextDecoration.lineThrough)),
                            SizedBox(width: screenWidth * 0.01),
                            Padding(
                              padding: const EdgeInsets.only(top: 06),
                              child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                      color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                            ),
                            Text("${widget.carDiscountPrice}",
                                textAlign: TextAlign.left, style: TextStyle(
                                    color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
                            Text("/Hour", textAlign: TextAlign.left, style: TextStyle(
                                    color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                // Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                showRatingStars(double.parse("${widget.carRating}")),
                                SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                widget.carRating == null ?
                                Text("0.0", textAlign: TextAlign.left, style: TextStyle(
                                    color: kBlack, fontSize: 14, fontFamily: poppinRegular)) :
                                Text("${widget.carRating}", textAlign: TextAlign.left,
                                    style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinRegular)),
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
                                child: Text("Pre book", textAlign: TextAlign.left, style: TextStyle(
                                        color: kWhite, fontSize: 12, fontFamily: poppinMedium)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text("PRE-BOOK LISTING ", textAlign: TextAlign.left, style: TextStyle(
                                color: kBlack, fontSize: 14, fontFamily: poppinSemiBold)),
                        SizedBox(height: screenHeight * 0.01),
                        Text("This vehicle may take more than 7 days to deliver, based on vehicle’s availability",
                            textAlign: TextAlign.left, style: TextStyle(
                                color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 45,
                right: 20,
                top: 10,
                child: widget.carImage == null ?
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/icon/fade_in_image.jpeg')) :
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
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
                  Text("${widget.discountPercentage}% ",
                      textAlign: TextAlign.left, style: TextStyle(
                          color: kWhite, fontSize: 13, fontFamily: poppinSemiBold)),
                  Text("OFF", textAlign: TextAlign.left, style: TextStyle(
                          color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                      ],
                    ),
                  )),

              Positioned(
                top: 28,
                right: 27,
                child: widget.favouriteStatus == "like" ?
                Image.asset("assets/home_page/heart.png") :
                Image.asset("assets/home_page/heart_transparent.png", color: kBlack),
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
    selectedMinutes = (totalHours* 60)+ minutes;
    print("myMinutesBottomSheet $myMinutes $selectedMinutes");
    print("valueHours $myHours $totalHours");

    if(myMinutes == selectedMinutes){
      // toastSuccessMessage("time matched successfully", colorGreen);
      print("success");
    }
    else{
      toastFailedMessage("time didn't matched", kRed);
      print("no success");
    }
  }

  void openBottomSheetPhotoCars(BuildContext context) {
    showFlexibleBottomSheet<void>(
      isExpand: false,
      initHeight: 0.8,
      maxHeight: 0.8,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context, controller, offset) {
        var size = MediaQuery.of(context).size;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetterObject) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: homeBgColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text('Change Available Time Slot',
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
                        GestureDetector(
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              // firstDate: DateTime(1980),
                              firstDate: DateTime.now().subtract(const Duration(days: 0)),
                              lastDate: DateTime(2050),
                            );
                            if (picked != null && picked != pickDate) {
                              // valueDate = DateFormat('yyyy-MM-dd').format(picked);
                              // valueDay = DateFormat('EE, d').format(picked);
                              valueDate = DateFormat('yyyy-MM-dd').format(picked);
                              valueDay = DateFormat('EEEE, dd MMMM').format(picked);

                              stateSetterObject(() {
                                print("Selected date in bottomSheet : $valueDate");
                                print("Selected Day in bottomSheet : $valueDay");
                              });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.keyboard_arrow_left, color: borderColor),
                              Text(
                                "$valueDate",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: poppinSemiBold,
                                    color: borderColor),
                              ),
                              Icon(Icons.keyboard_arrow_right,
                                  color: borderColor),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        valueDay == null ?
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text("$valueDay", style: TextStyle(
                                fontSize: 14, fontFamily: poppinMedium, color: kBlack)),
                          ),
                        )
                            : Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text("$valueDay", style: TextStyle(
                                fontSize: 14, fontFamily: poppinMedium, color: kWhite)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Container(
                            height: size.height * 0.055,
                            width: MediaQuery.of(context).size.width * 01.3,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: const Color(0xff7E7E7E))),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text('Select Hours', style: GoogleFonts.poppins(textStyle: TextStyle(
                                      fontSize: 12, color: kBlack, fontWeight: FontWeight.w400))),
                                  icon: Icon(Icons.keyboard_arrow_down_rounded, size: 30, color: kBlack),
                                  items: timeHoursList.map(
                                        (item) => DropdownMenuItem<String>(value: item,
                                      child: Text(item, style: GoogleFonts.poppins(textStyle: TextStyle(
                                          fontSize: 14, color: kBlack, fontWeight: FontWeight.w400))),
                                    ),
                                  ).toList(),
                                  value: dropdownValueTime,
                                  onChanged: (String? newValue) {
                                    stateSetterObject(() {
                                      dropdownValueTime = newValue!.split(" hour").first;
                                      myHours = int.parse(dropdownValueTime);
                                      dropdownValueTime = newValue;
                                      print("selectedTime in bottomSheet: $dropdownValueTime");
                                      print("selectedHour in bottomSheet: $myHours");
                                    });
                                  },
                                  buttonWidth: MediaQuery.of(context).size.width * 0.2,
                                  dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  dropdownMaxHeight: MediaQuery.of(context).size.height * 0.25,
                                  scrollbarThickness: 0,
                                  itemHeight: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    TimeOfDay? picked;
                                    picked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (picked == null) {
                                      picked = startTime;
                                    } else {
                                      valueTimeStart = picked.format(context).toString();
                                      // setState(() {
                                      //   print("Selected startTime is : $valueTimeStart");
                                      // });
                                      valueTimeStart = '${picked.hour}:${picked.minute}:00';
                                      stateSetterObject(() {
                                        print("Selected startTime is : $valueTimeStart");
                                        print("myTime $valueTimeStart");
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: valueTimeStart == "Start Time" ? kWhite : borderColor,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text("$valueTimeStart", style: TextStyle(fontSize: 16,
                                          color: valueTimeStart == "Start Time" ? kBlack : kWhite)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                    onTap: () async {
                                      TimeOfDay? picked;
                                      picked = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (picked == null) {
                                        picked = startTime;
                                      } else {
                                        valueTimeEnd = picked.format(context).toString();
                                        // setState(() {
                                        //   print("Selected endTime is: $valueTimeEnd");
                                        // });
                                        valueTimeEnd = '${picked.hour}:${picked.minute}:00';
                                        stateSetterObject(() {
                                          print("Selected endTime is : $valueTimeEnd");
                                          calculateTimeInterval();
                                          // compareTime();
                                        });
                                        print("myEndTime $valueTimeEnd");
                                      }
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: valueTimeEnd == "End Time" ? kWhite : borderColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text("$valueTimeEnd", style: TextStyle(fontSize: 16,
                                            color: valueTimeEnd == "End Time" ? kBlack : kWhite)),
                                      ),
                                    )),
                              ]),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    GestureDetector(
                        onTap: () {
                          mySelectedData();
                          Navigator.pop(context);
                        },
                        child: loginButton('Update', context)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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
  //               borderRadius: const BorderRadius.only(
  //                   topRight: Radius.circular(20),
  //                   topLeft: Radius.circular(20)),
  //             ),
  //             child: Column(
  //               children: [
  //                 SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //                 Align(
  //                   alignment: Alignment.topLeft,
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(left: 16),
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
  //                           firstDate: DateTime.now().subtract(const Duration(days: 0)),
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
  //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                       child: Container(
  //                         height: size.height * 0.055,
  //                         width: MediaQuery.of(context).size.width * 01.3,
  //                         decoration: BoxDecoration(
  //                             color: kWhite,
  //                             borderRadius: BorderRadius.circular(15),
  //                             border: Border.all(color: const Color(0xff7E7E7E))),
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(left: 10, right: 10),
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
  //                                   dropdownValueTime = newValue!.split(" hour").first;
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
  //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
  //                     padding: const EdgeInsets.symmetric(
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
