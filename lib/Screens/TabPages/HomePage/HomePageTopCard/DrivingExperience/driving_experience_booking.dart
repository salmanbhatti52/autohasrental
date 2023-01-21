import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/DrivingExperience/AddressDrivingExperience/delivery_address_experience.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../Model/HomePageModels/HomePageTopWidgetModels/driving_experience_cars_model.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/constants.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';

class DrivingExperienceBooking extends StatefulWidget {
  final String? selectedDay, startTime, endTime, selectedDate;
  final ExperienceDatumList? myDatum;

  const DrivingExperienceBooking({Key? key, this.myDatum,  this.selectedDay, this.selectedDate,
    this.startTime, this.endTime}) : super(key: key);

  @override
  State<DrivingExperienceBooking> createState() => _DrivingExperienceBookingState();
}

class _DrivingExperienceBookingState extends State<DrivingExperienceBooking> {

  mySelectedData(){
    valueDate = "${widget.selectedDate}";
    print("mySelectedDate: $valueDate");
    print("mySelectedDay: ${widget.selectedDay}");
    myTotal();
    // print("mySelectedTime: ${widget.selectedTime}");
  }
  int selectedIndex = 0;
  String? mySelectedStartTime, mySelectedEndTime;
  String? myStartTime, myEndTime;
  int? comparison;
  DateTime? apiDate;
  String? apiStartTime, apiEndTime;
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime? pickDate;
  String? valueDate;
  String? valueDay;
  String? newSelectedDay;
  String? newStartTime, newEndTime;

  double myTotalPrice = 0.0;
  myTotal(){
    myTotalPrice = double.parse(widget.myDatum!.carsPlans![0].discountedPricePerSlot.toString()) + serviceFee;
    print("myTotalPrice $myTotalPrice");
    setState(() {});

  }

  @override
  void initState() {
    super.initState();
    mySelectedData();
    newSelectedDay = widget.selectedDay;
    newStartTime = widget.startTime;
    newEndTime = widget.endTime;
    print("newSelectedDay $newSelectedDay");
    print("newStartTime $newStartTime $newEndTime");
  }
  bool loadingP = true;

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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  drivingExperienceBookingCard(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Choose Subscription plan", textAlign: TextAlign.left,
                          style: TextStyle(color: kBlack,
                            fontSize: 14, fontFamily: poppinSemiBold)),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child:
                                    // valueDay == null?
                                    // Text('$valueDay', textAlign: TextAlign.left, style: TextStyle(
                                    //         fontSize: 12.0, fontFamily: poppinRegular, color: kWhite)):
                                    Text('$newSelectedDay', textAlign: TextAlign.left, style: TextStyle(
                                            fontSize: 12.0, fontFamily: poppinRegular, color: kWhite)),
                                  ),
                                ),
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                              GestureDetector(
                                  onTap: () {
                                    showBottomSheetWidget(context);
                                  },
                                  child: SvgPicture.asset('assets/icon/edit_booking_icoon.svg')),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("$newStartTime -- $newEndTime Plan",
                                textAlign: TextAlign.left, style: TextStyle(
                                    fontFamily: poppinRegular, fontSize: 14, color: detailsTextColor)),
                            Text("RM ${widget.myDatum!.carsPlans![0].discountedPricePerSlot}",
                                textAlign: TextAlign.right, style: TextStyle(
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
                            Text("Monthly Total Fee", textAlign: TextAlign.left,
                              style: TextStyle(fontFamily: poppinSemiBold,
                                  fontSize: 16, color: kBlack)),
                            Text("RM $myTotalPrice", textAlign: TextAlign.left,
                              style: TextStyle(fontFamily: poppinSemiBold,
                                  fontSize: 16, color: kBlack)),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "*A security deposit may be applicable, depending on your eligibility assessment.",
                          maxLines: 2, textAlign: TextAlign.left,
                          style: TextStyle(fontFamily: poppinRegular,
                              fontSize: 14, color: borderColor)),
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
                                Image.asset("assets/home_page/business-investment.png"),
                                SizedBox(width: screenWidth * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Save RM 37,538", textAlign: TextAlign.left,
                                          style: TextStyle(fontFamily: poppinSemiBold,
                                              fontSize: 16, color: kWhite)),
                                        SizedBox(width: screenWidth * 0.03),
                                        Container(
                                          height: 25,
                                          width: screenWidth * 0.24,
                                          decoration: BoxDecoration(
                                              color: borderColor,
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text("Learn more", textAlign: TextAlign.left,
                                              style: TextStyle(fontFamily: poppinRegular,
                                                  fontSize: 12, color: kWhite)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      children: [
                                        Text("in your first year with ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: kWhite,
                                                fontSize: 10, fontFamily: poppinRegular)),
                                        Text("AutoHaus Rental",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(color: borderColor,
                                                fontSize: 10, fontFamily: poppinSemiBold)),
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
                          style: TextStyle(fontFamily: poppinSemiBold,
                              fontSize: 14, color: kBlack)),
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
                              Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => DeliveryAddressExperience(
                                        totalPrice: myTotalPrice,
                                        myDatum: widget.myDatum,
                                        startTime: newStartTime,
                                        endTime: newEndTime,
                                        selectedDate: valueDate,
                                      )));
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
                  Container(height: screenHeight * 0.1),
                  Row(
                    children: [
                      Text("${widget.myDatum!.vehicalName} | ",
                        textAlign: TextAlign.left, style: TextStyle(
                          color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                      Text("${widget.myDatum!.carsMakes!.name} ", textAlign: TextAlign.left,
                        style: TextStyle(color: kBlack,
                          fontSize: 12, fontFamily: poppinRegular)),
                      Text("${widget.myDatum!.carsModels!.name} ",
                          textAlign: TextAlign.left, style: TextStyle(
                            color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
                      Text("${widget.myDatum!.year}",
                          textAlign: TextAlign.left, style: TextStyle(
                            color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 04),
                        child: Text("RM ", textAlign: TextAlign.left,
                          style: TextStyle(color: kRed, fontSize: 5, fontFamily: poppinLight)),
                      ),
                      Text("${widget.myDatum!.carsPlans![0].pricePerSlot}",
                        textAlign: TextAlign.left, style: TextStyle(
                            color: kRed, fontFamily: poppinLight,
                            fontSize: 10, decoration: TextDecoration.lineThrough)),
                      SizedBox(width: screenWidth * 0.01),
                      Padding(
                        padding: const EdgeInsets.only(top: 06),
                        child: Text("RM ", textAlign: TextAlign.left,
                          style: TextStyle(color: borderColor,
                            fontSize: 7, fontFamily: poppinSemiBold)),
                      ),
                      Text("${widget.myDatum!.carsPlans![0].discountedPricePerSlot}",
                        textAlign: TextAlign.left, style: TextStyle(
                          color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
                      Text("/ Month", textAlign: TextAlign.left,
                        style: TextStyle(color: kBlack,
                          fontSize: 8, fontFamily: poppinRegular)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Image.asset("assets/home_page/Promoted.png"),
                      const SizedBox(width: 05),
                      Text("Verified Dealer", textAlign: TextAlign.left,
                        style: TextStyle(color: textLabelColor,
                          fontSize: 10, fontFamily: poppinRegular)),
                      const SizedBox(width: 05),
                      Container(
                        height: 15, width: 35,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text("New", textAlign: TextAlign.left,
                            style: TextStyle(color: kWhite,
                              fontSize: 8, fontFamily: poppinRegular)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                          SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                          widget.myDatum!.rating == null?
                          Text("0.0",
                              textAlign: TextAlign.left, style: TextStyle(
                                  color: kBlack, fontSize: 14, fontFamily: poppinRegular)):
                          Text("${widget.myDatum!.rating}",
                            textAlign: TextAlign.left, style: TextStyle(
                              color: kBlack, fontSize: 14, fontFamily: poppinRegular)),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.45),
                      Container(
                        height: 25, width: 70,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text("Pre book", textAlign: TextAlign.left,
                              style: TextStyle(color: kWhite,
                                fontSize: 12, fontFamily: poppinMedium)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text("PRE-BOOK LISTING ", textAlign: TextAlign.left,
                    style: TextStyle(color: kBlack,
                      fontSize: 14, fontFamily: poppinSemiBold)),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                      "This vehicle may take more than 7 days to deliver, based on vehicle’s availability",
                      textAlign: TextAlign.left, style: TextStyle(
                        color: kBlack, fontSize: 10, fontFamily: poppinRegular,)),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 28, left: 27,
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
          left: 20, right: 20,
          child: Image.network("$baseUrlImage${widget.myDatum!.image1}", height: 170,),
        ),
        Positioned(
            top: 28, right: 27,
            child: Image.asset("assets/home_page/heart_transparent.png",
              color: kBlack)),
      ],
    );
  }

  showBottomSheetWidget(context){
    return showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetterObject){
                return Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: homeBgColor,
                    borderRadius: const BorderRadius.only(
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
                          padding: const EdgeInsets.only(left: 16),
                          child: Text('Change Available Time Slot',
                              textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 14, fontFamily: poppinBold, color: appBgColor)),
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
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050),
                              );
                              if (picked != null && picked != pickDate) {
                                valueDate = DateFormat('yyyy-MM-dd').format(picked);
                                newSelectedDay = DateFormat('EEEE, dd MMMM').format(picked);

                                stateSetterObject(() {
                                  print("Selected date in bottomSheet: $valueDate");
                                  print("Selected Day in bottomSheet: $newSelectedDay");
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.keyboard_arrow_left, color: borderColor),
                                Text("$valueDate", textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 14,
                                      fontFamily: poppinSemiBold, color: borderColor),
                                ),
                                Icon(Icons.keyboard_arrow_right, color: borderColor),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height* 0.02),

                          newSelectedDay == null?
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text("${widget.selectedDay}",
                                style: TextStyle(fontSize: 14,
                                    fontFamily: poppinMedium, color: kBlack),
                              ),
                            ),
                          ):
                          Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color:  borderColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text("$newSelectedDay", style: TextStyle(
                                  fontSize: 14, fontFamily: poppinMedium, color: kWhite)),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      Container(
                        color: Colors.transparent,
                        height: 100,
                        child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 0.2,
                              mainAxisSpacing: 05,
                              crossAxisSpacing: 0,
                            ),
                            itemCount: widget.myDatum!.carsPlans!.length,

                            itemBuilder: (context, index){
                              mySelectedStartTime = widget.myDatum!.carsPlans![index].startTime;
                              mySelectedEndTime = widget.myDatum!.carsPlans![index].endTime;
                              myStartTime = mySelectedStartTime!.substring(0, 5);
                              myEndTime = mySelectedEndTime!.substring(0, 5);
                              print("newTime $myStartTime $myEndTime");

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 05),
                                child: GestureDetector(
                                  onTap: (){

                                    stateSetterObject(() {
                                      selectedIndex = index;
                                      apiDate = widget.myDatum!.carsPlans![selectedIndex].planDate;
                                      newStartTime = "${widget.myDatum!.carsPlans![selectedIndex].startTime}";
                                      newEndTime = "${widget.myDatum!.carsPlans![selectedIndex].endTime}";
                                      myStartTime = mySelectedStartTime!.substring(0, 5);
                                      myEndTime = mySelectedEndTime!.substring(0, 5);
                                      DateTime date = DateTime.parse(apiDate.toString());
                                      DateFormat formatter = DateFormat("yyyy-MM-dd");
                                      String formattedDate = formatter.format(date);
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
                                      border: Border.all(color: selectedIndex == index ? borderColor : const Color(0xffd4dce1),
                                          width: 2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.check_circle, size: 22,
                                            color: selectedIndex == index ? kBlack : const Color(0xffd4dce1)),
                                        Text("$myStartTime to $myEndTime",
                                          style: TextStyle(color: selectedIndex == index? kWhite: kBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                      GestureDetector(
                          onTap: () {
                            // compareTime();
                            // getDrivingExperienceCarsWidget();
                            mySelectedData();

                            Navigator.pop(context);
                          },
                          child: loginButton('Update', context)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        });
  }
}
