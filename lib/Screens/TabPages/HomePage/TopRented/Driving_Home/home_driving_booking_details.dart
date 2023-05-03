
import 'package:intl/intl.dart';
import 'home_driving_booking.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'DeliveryAddress/home_driving_delivery_address.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';

class HomeDrivingBookingDetails extends StatefulWidget {
  final String? selectedDay, startTime, endTime, selectedDate;
  final DatumTopRented? myDatum;
  final double? slotPrice;

  HomeDrivingBookingDetails({Key? key, this.myDatum,
    this.selectedDay, this.selectedDate, this.slotPrice,
    this.startTime, this.endTime}) : super(key: key);

  @override
  State<HomeDrivingBookingDetails> createState() => _HomeDrivingBookingDetailsState();
}

class _HomeDrivingBookingDetailsState extends State<HomeDrivingBookingDetails> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();


  int selectedIndex = 0;
  String? mySelectedStartTime, mySelectedEndTime;
  String? myStartTime, myEndTime, apiDate;

  String? apiStartTime, apiEndTime;
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime? pickDate;
  String? valueDate, valueDay, newSelectedDay, newStartTime, newEndTime;

  double myTotalPrice = 0.0;
  double mySlotPrice = 0.0;

  @override
  void initState() {
    super.initState();
    newSelectedDay = widget.selectedDay;
    mySlotPrice = double.parse(widget.slotPrice.toString());
    newStartTime = widget.startTime;
    newEndTime = widget.endTime;
    print("mySlotPrice1 $mySlotPrice");
    print("newSelectedDay $newSelectedDay");
    print("newStartTime $newStartTime $newEndTime");
    mySelectedData();
  }
  mySelectedData(){
    valueDate = "${widget.selectedDate}";
    print("mySelectedDate: $valueDate");
    print("mySelectedDay: ${widget.selectedDay}");
    myTotal();
  }
  myTotal(){
    print("mySlotPrice2 $mySlotPrice");
    myTotalPrice = double.parse(mySlotPrice.toString()) + serviceFee;
    print("myTotalPrice $myTotalPrice");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarSingleImageWithText(
        title: "${widget.myDatum!.vehicalName}, ", subtitle: "${widget.myDatum!.year}",
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
                  drivingExperienceBookingCard(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Choose Subscription plan", textAlign: TextAlign.left,
                            style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinSemiBold)),
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
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text('$newSelectedDay', textAlign: TextAlign.left, style: TextStyle(
                                            fontSize: 12.0, fontFamily: poppinRegular, color: kWhite)),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                              GestureDetector(
                                  onTap: () {
                                    // showBottomSheetWidget(context);
                                    openBottomSheetDrivingCars(context);
                                    compareSlotDates();
                                  },
                                  child: SvgPicture.asset('assets/icon/edit_booking_icoon.svg')),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$newStartTime -- $newEndTime Plan", textAlign: TextAlign.left, style: TextStyle(
                                    fontFamily: poppinRegular, fontSize: 14, color: detailsTextColor)),
                            Text("RM $mySlotPrice", textAlign: TextAlign.right, style: TextStyle(
                                    fontFamily: poppinRegular, fontSize: 14, color: detailsTextColor)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Service Fee (6%)", textAlign: TextAlign.left, style: TextStyle(
                                  fontFamily: poppinRegular, fontSize: 14, color: detailsTextColor)),
                            Text("RM $serviceFee", textAlign: TextAlign.right, style: TextStyle(
                                  fontFamily: poppinRegular, fontSize: 14, color: detailsTextColor)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Monthly Total Fee", textAlign: TextAlign.left, style: TextStyle(
                                  fontFamily: poppinSemiBold, fontSize: 16, color: kBlack)),
                            Text("RM $myTotalPrice", textAlign: TextAlign.left, style: TextStyle(
                                  fontFamily: poppinSemiBold, fontSize: 16, color: kBlack)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text("*A security deposit may be applicable, depending on your eligibility assessment.",
                          maxLines: 2, textAlign: TextAlign.left, style: TextStyle(
                              fontFamily: poppinRegular, fontSize: 14, color: borderColor)),
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
                                Image.asset("assets/home_page/business-investment.png"),
                                SizedBox(width: screenWidth * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Save RM 37,538", textAlign: TextAlign.left, style: TextStyle(
                                              fontFamily: poppinSemiBold, fontSize: 16, color: kWhite)),
                                        SizedBox(width: screenWidth * 0.03),
                                        Container(
                                          height: 25,
                                          width: screenWidth * 0.24,
                                          decoration: BoxDecoration(
                                              color: borderColor,
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text("Learn more", textAlign: TextAlign.left, style: TextStyle(
                                                  fontFamily: poppinRegular, fontSize: 12, color: kWhite)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      children: [
                                        Text("in your first year with ", textAlign: TextAlign.left, style: TextStyle(
                                                color: kWhite, fontSize: 10, fontFamily: poppinRegular)),
                                        Text("AutoHaus Rental", textAlign: TextAlign.left, style: TextStyle(
                                                color: borderColor, fontSize: 10, fontFamily: poppinSemiBold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text("What's Included", textAlign: TextAlign.left,
                          style: TextStyle(fontFamily: poppinSemiBold, fontSize: 14, color: kBlack)),
                        SizedBox(height: screenHeight * 0.02),
                        myList("assets/home_page/Path 2582.png", "Periodic maintenance package (including pick up and delivery)"),
                        myList("assets/home_page/Path 2582.png", "Wear & tear (including tyres, wipers, and brake pads replacement)"),
                        myList("assets/home_page/Path 2582.png", "Comprehensive insurance coverage"),
                        myList("assets/home_page/Path 2582.png", "Personal accident coverage for driver and passengers"),
                        myList("assets/home_page/Path 2582.png", "24-hour roadside assistance (with unlimited towing and minor roadside repairs)"),
                        myList("assets/home_page/Path 2582.png", "Road tax"),
                        myList("assets/home_page/Path 2582.png", "Flux Concierge Service"),
                        myList("assets/home_page/Path 2582.png", "Theft recovery services"),
                        myList("assets/home_page/Path 2582.png", "Emergency dispatch services"),
                        SizedBox(height: screenHeight * 0.02),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => HomeDrivingDeliveryAddress(
                                        selectedSlotPrice: mySlotPrice,
                                        totalPrice: myTotalPrice,
                                        myDatum: widget.myDatum,
                                        startTime: newStartTime,
                                        endTime: newEndTime,
                                        selectedDate: valueDate,
                                      )));
                              print("slotPrice $mySlotPrice");
                              print("slotTotalPrice $myTotalPrice");
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
          child: Text(myText, textAlign: TextAlign.left,
            maxLines: 2, style: TextStyle(fontSize: 10,
                fontFamily: poppinRegular, color: detailsTextColor)),
        ),
      ],
    );
  }

  Widget drivingExperienceBookingCard() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: screenHeight * 0.1),
                  Row(
                    children: [
                      Text("${widget.myDatum!.vehicalName} ", textAlign: TextAlign.left,
                          style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                      Text("${widget.myDatum!.carsMakes!.name} ", textAlign: TextAlign.left,
                        style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                      Text("${widget.myDatum!.carsModels!.name} ", textAlign: TextAlign.left,
                          style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
                      Text("${widget.myDatum!.year}", textAlign: TextAlign.left,
                          style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 04),
                        child: Text("RM ", textAlign: TextAlign.left,
                          style: TextStyle(color: kRed, fontSize: 5, fontFamily: poppinLight)),
                      ),
                      Text("${widget.myDatum!.carsPlans![0].pricePerSlot}", textAlign: TextAlign.left,
                          style: TextStyle(color: kRed, fontFamily: poppinLight,
                            fontSize: 10, decoration: TextDecoration.lineThrough)),
                      SizedBox(width: screenWidth * 0.01),
                      Padding(
                        padding: EdgeInsets.only(top: 06),
                        child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                              color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                      ),
                      Text("${widget.myDatum!.carsPlans![0].discountedPricePerSlot}", textAlign: TextAlign.left,
                          style: TextStyle(color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
                      Text("/slot", textAlign: TextAlign.left, style: TextStyle(
                            color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          showRatingStars(double.parse("${widget.myDatum!.rating}")),
                          SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                          widget.myDatum!.rating == null?
                          Text("0.0", textAlign: TextAlign.left, style: TextStyle(
                              color: kBlack, fontSize: 14, fontFamily: poppinRegular)):
                          Text("${widget.myDatum!.rating}", textAlign: TextAlign.left,
                              style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinRegular)),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.25),
                      Container(
                        height: 25, width: 70,
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
                        color: kBlack, fontSize: 10, fontFamily: poppinRegular,)),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 50, right: 40,
          child: Image.network("$baseUrlImage${widget.myDatum!.image1}", height: 140, ),
        ),
        Positioned(
            top: 28, left: 27,
            child: Container(
              height: screenHeight * 0.04,
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
                  Text("${widget.myDatum!.discountPercentage}% ",
                      textAlign: TextAlign.left, style: TextStyle(
                          color: kWhite, fontSize: 13, fontFamily: poppinSemiBold)),
                  Text("OFF", textAlign: TextAlign.left,
                      style: TextStyle(color: kWhite,
                          fontSize: 8, fontFamily: poppinRegular)),
                ],
              ),
            )),
        Positioned(
            top: 28, right: 27,
            child: Image.asset("assets/home_page/heart_transparent.png",
              color: kBlack)),
      ],
    );
  }
  void openBottomSheetDrivingCars(BuildContext context) {
    showFlexibleBottomSheet<void>(
      isExpand: false,
      initHeight: 0.8,
      maxHeight: 0.8,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context, controller, offset) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetterObject){
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: homeBgColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text('Change Available Time Slot', textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 14, fontFamily: poppinBold, color: appBgColor)),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Form(
                      key: myFormKey,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              print("clicked...");
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                // firstDate: DateTime(1980),
                                firstDate: DateTime.now().subtract(Duration(days: 0)),
                                lastDate: DateTime(2050),
                              );
                              if (picked != null && picked != pickDate) {
                                valueDate = DateFormat('yyyy-MM-dd').format(picked);
                                newSelectedDay = DateFormat('EEEE, dd MMMM').format(picked);

                                stateSetterObject(() {
                                  print("Selected date in bottomSheet: $valueDate");
                                  print("Selected Day in bottomSheet: $newSelectedDay");

                                  compareSlotDates();

                                });
                              }
                            },
                            child: Container(
                              width: 220,
                              height: 40,
                              decoration: BoxDecoration(
                                color: borderColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("$newSelectedDay", textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 14, fontFamily: poppinSemiBold, color: kWhite)),
                                  Icon(Icons.keyboard_arrow_right, color: kWhite),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            color: Colors.transparent,
                            height: 100,
                            child: myCarPlan.isEmpty ? Center(child: Text("No Slots Available", textAlign: TextAlign.left,
                                style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinBold))):
                            GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 0.2,
                                  mainAxisSpacing: 05,
                                  crossAxisSpacing: 0,
                                ),
                                itemCount: myCarPlan.length,

                                itemBuilder: (context, index){
                                  mySelectedStartTime = myCarPlan[index].startTime;
                                  mySelectedEndTime = myCarPlan[index].endTime;
                                  myStartTime = mySelectedStartTime!.substring(0, 5);
                                  myEndTime = mySelectedEndTime!.substring(0, 5);
                                  print("newTime $myStartTime $myEndTime");

                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 05),
                                    child: GestureDetector(
                                      onTap: (){

                                        stateSetterObject(() {
                                          selectedIndex = index;
                                          mySlotPrice = double.parse(myCarPlan[selectedIndex].discountedPrice);
                                          apiDate = myCarPlan[selectedIndex].date;
                                          newStartTime = myCarPlan[selectedIndex].startTime;
                                          newEndTime = myCarPlan[selectedIndex].endTime;
                                          myStartTime = mySelectedStartTime!.substring(0, 5);
                                          myEndTime = mySelectedEndTime!.substring(0, 5);
                                          DateTime date = DateTime.parse(apiDate.toString());
                                          DateFormat formatter = DateFormat("yyyy-MM-dd");
                                          String formattedDate = formatter.format(date);
                                          print("mySlotPrice $mySlotPrice");
                                          print("formattedDate $formattedDate");

                                        });
                                        print("mySelectedIndex $index");
                                        print("mySelectedTime $myStartTime to $myEndTime");
                                        print("myNewSelectedTime $newStartTime to $newEndTime");
                                        print("mySelectedPlanDate ${widget.myDatum!.carsPlans![index].planDate}");

                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: selectedIndex == index? borderColor: kWhite,
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: selectedIndex == index ? borderColor : Color(0xffd4dce1),
                                              width: 2),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.check_circle, size: 22,
                                                color: selectedIndex == index ? kBlack : Color(0xffd4dce1)),
                                            Text("$myStartTime to $myEndTime", style: TextStyle(
                                                color: selectedIndex == index? kWhite: kBlack)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                        onTap: () {
                          if(myFormKey.currentState!.validate()){
                            if(valueDate == null){
                              toastFailedMessage("error", kRed);
                            }else if(myStartTime == null || myEndTime == null){
                              toastFailedMessage("error", kRed);
                            }else{
                              mySelectedData();
                              print("mySlotPrice $mySlotPrice");
                              Navigator.pop(context);
                            }
                          }
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
                              child: Text('Cancel', textAlign: TextAlign.center,
                                  style: TextStyle(color: borderColor,
                                      fontFamily: poppinRegular, fontSize: 18)),
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

  // showBottomSheetWidget(context){
  //   return showMaterialModalBottomSheet(
  //       backgroundColor: Colors.transparent,
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter stateSetterObject){
  //               return Container(
  //                 height: MediaQuery.of(context).size.height * 0.5,
  //                 width: MediaQuery.of(context).size.width,
  //                 decoration: BoxDecoration(
  //                   color: homeBgColor,
  //                   borderRadius: BorderRadius.only(
  //                       topRight: Radius.circular(20),
  //                       topLeft: Radius.circular(20)
  //                   ),
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //                     Align(
  //                       alignment: Alignment.topLeft,
  //                       child: Padding(
  //                         padding: EdgeInsets.only(left: 16),
  //                         child: Text('Change Available Time Slot', textAlign: TextAlign.left,
  //                             style: TextStyle(fontSize: 14, fontFamily: poppinBold, color: appBgColor)),
  //                       ),
  //                     ),
  //                     SizedBox(height: MediaQuery.of(context).size.height * 0.01),
  //                     Form(
  //                       key: myFormKey,
  //                       child: Column(
  //                         children: [
  //                           GestureDetector(
  //                             onTap: () async {
  //                               print("clicked...");
  //                               DateTime? picked = await showDatePicker(
  //                                 context: context,
  //                                 initialDate: DateTime.now(),
  //                                 // firstDate: DateTime(1980),
  //                                 firstDate: DateTime.now().subtract(Duration(days: 0)),
  //                                 lastDate: DateTime(2050),
  //                               );
  //                               if (picked != null && picked != pickDate) {
  //                                 valueDate = DateFormat('yyyy-MM-dd').format(picked);
  //                                 newSelectedDay = DateFormat('EEEE, dd MMMM').format(picked);
  //
  //                                 stateSetterObject(() {
  //                                   print("Selected date in bottomSheet: $valueDate");
  //                                   print("Selected Day in bottomSheet: $newSelectedDay");
  //
  //                                   compareSlotDates();
  //
  //                                 });
  //                               }
  //                             },
  //                             child: Container(
  //                               width: 220,
  //                               height: 40,
  //                               decoration: BoxDecoration(
  //                                 color: borderColor,
  //                                 borderRadius: BorderRadius.circular(15),
  //                               ),
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   Text("$newSelectedDay", textAlign: TextAlign.left,
  //                                       style: TextStyle(fontSize: 14, fontFamily: poppinSemiBold, color: kWhite)),
  //                                   Icon(Icons.keyboard_arrow_right, color: kWhite),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //
  //                           Container(
  //                             color: Colors.transparent,
  //                             height: 100,
  //                             child: myCarPlan.isEmpty ? Center(child: Text("No Slots Available", textAlign: TextAlign.left,
  //                                 style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinBold))):
  //                             GridView.builder(
  //                                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                                   crossAxisCount: 2,
  //                                   childAspectRatio: 1 / 0.2,
  //                                   mainAxisSpacing: 05,
  //                                   crossAxisSpacing: 0,
  //                                 ),
  //                                 itemCount: myCarPlan.length,
  //
  //                                 itemBuilder: (context, index){
  //                                   mySelectedStartTime = myCarPlan[index].startTime;
  //                                   mySelectedEndTime = myCarPlan[index].endTime;
  //                                   myStartTime = mySelectedStartTime!.substring(0, 5);
  //                                   myEndTime = mySelectedEndTime!.substring(0, 5);
  //                                   print("newTime $myStartTime $myEndTime");
  //
  //                                   return Padding(
  //                                     padding: EdgeInsets.symmetric(horizontal: 05),
  //                                     child: GestureDetector(
  //                                       onTap: (){
  //
  //                                         stateSetterObject(() {
  //                                           selectedIndex = index;
  //                                           mySlotPrice = double.parse(myCarPlan[selectedIndex].discountedPrice);
  //                                           apiDate = myCarPlan[selectedIndex].date;
  //                                           newStartTime = myCarPlan[selectedIndex].startTime;
  //                                           newEndTime = myCarPlan[selectedIndex].endTime;
  //                                           myStartTime = mySelectedStartTime!.substring(0, 5);
  //                                           myEndTime = mySelectedEndTime!.substring(0, 5);
  //                                           DateTime date = DateTime.parse(apiDate.toString());
  //                                           DateFormat formatter = DateFormat("yyyy-MM-dd");
  //                                           String formattedDate = formatter.format(date);
  //                                           print("mySlotPrice $mySlotPrice");
  //                                           print("formattedDate $formattedDate");
  //
  //                                         });
  //                                         print("mySelectedIndex $index");
  //                                         print("mySelectedTime $myStartTime to $myEndTime");
  //                                         print("myNewSelectedTime $newStartTime to $newEndTime");
  //                                         print("mySelectedPlanDate ${widget.myDatum!.carsPlans![index].planDate}");
  //
  //                                       },
  //                                       child: Container(
  //                                         height: 40,
  //                                         decoration: BoxDecoration(
  //                                           color: selectedIndex == index? borderColor: kWhite,
  //                                           borderRadius: BorderRadius.circular(15),
  //                                           border: Border.all(color: selectedIndex == index ? borderColor : Color(0xffd4dce1),
  //                                               width: 2),
  //                                         ),
  //                                         child: Row(
  //                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                                           children: [
  //                                             Icon(Icons.check_circle, size: 22,
  //                                                 color: selectedIndex == index ? kBlack : Color(0xffd4dce1)),
  //                                             Text("$myStartTime to $myEndTime", style: TextStyle(
  //                                                   color: selectedIndex == index? kWhite: kBlack)),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   );
  //                                 }),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //
  //                     GestureDetector(
  //                         onTap: () {
  //                           if(myFormKey.currentState!.validate()){
  //                             if(valueDate == null){
  //                               toastFailedMessage("error", kRed);
  //                             }else if(myStartTime == null || myEndTime == null){
  //                               toastFailedMessage("error", kRed);
  //                             }else{
  //                               mySelectedData();
  //                               print("mySlotPrice $mySlotPrice");
  //                               Navigator.pop(context);
  //                             }
  //                           }
  //                         },
  //                         child: loginButton('Update', context)),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.pop(context);
  //                       },
  //                       child: Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //                         child: Center(
  //                           child: Container(
  //                             height: MediaQuery.of(context).size.height * 0.06,
  //                             width: MediaQuery.of(context).size.width * 0.7,
  //                             decoration: BoxDecoration(
  //                               color: Colors.transparent,
  //                               borderRadius: BorderRadius.circular(30),
  //                               border: Border.all(width: 1, color: borderColor),
  //                             ),
  //                             child: Center(
  //                               child: Text('Cancel', textAlign: TextAlign.center,
  //                                   style: TextStyle(color: borderColor,
  //                                       fontFamily: poppinRegular, fontSize: 18)),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             });
  //       });
  // }

  String? formattedDate, matchDate;
  List dateList = [];
  List<CustomSlotModel> myCarPlan = [];

  compareSlotDates(){
    dateList.clear();
    print("valueDate123Bottom $valueDate");
    for(int i = 0; i<widget.myDatum!.carsPlans!.length; i++){
      DateTime date = DateTime.parse("${widget.myDatum!.carsPlans![i].planDate}");
      formattedDate = DateFormat("yyyy-MM-dd").format(date);
      print("formattedDateBottom $formattedDate");
      dateList.add(formattedDate);
      print("dateListBottom $dateList");
    }
    matchDate = null;
    print("valueDate12345 $matchDate");
    for(int j = 0; j<dateList.length; j++) {
      if (valueDate == dateList[j]) {
        matchDate = dateList[j];
        print("matched ${dateList[j]}");
        print("matched123 $matchDate");
        print("valueDate12 $valueDate");
        print("equal");

      } else {
        print("not equal");
      }
    }
    print("myCarPlanLength111 ${myCarPlan.length}");
    myCarPlan.clear();

    if(matchDate != null){
      for(int k = 0; k<widget.myDatum!.carsPlans!.length; k++) {
        DateTime date = DateTime.parse("${widget.myDatum!.carsPlans![k].planDate}");
        formattedDate = DateFormat("yyyy-MM-dd").format(date);
        if(formattedDate == matchDate ){
          myCarPlan.add(CustomSlotModel(
            date: widget.myDatum!.carsPlans![k].planDate.toString(),
            startTime: "${widget.myDatum!.carsPlans![k].startTime}",
            endTime: "${widget.myDatum!.carsPlans![k].endTime}",
            discountedPrice: widget.myDatum!.carsPlans![k].discountedPricePerSlot.toString(),
          ));
          print("myCarPlanDate ${myCarPlan[0].date}");
          print("myCarPlanTime ${myCarPlan[0].startTime}");
          print("myCarPlanTime ${myCarPlan[0].endTime}");
        }
      }
    } else{
      print("myCarPlanLength1 ${myCarPlan.length}");
      myCarPlan.clear();
      print("myCarPlanLength11 ${myCarPlan.length}");
    }
  }
}
