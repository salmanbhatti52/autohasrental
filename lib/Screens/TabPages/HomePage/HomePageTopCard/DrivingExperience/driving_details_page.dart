import 'dart:convert';

import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../Model/HomePageModels/HomePageTopWidgetModels/driving_experience_cars_model.dart';
import '../../../MessagePage/message_details_screen.dart';
import '../EvSubscriptions/EvTaBBar/tabbar_description_page.dart';
import 'driving_experience_booking.dart';
import 'package:http/http.dart'as http;

class DrivingDetailsPage extends StatefulWidget {
  final ExperienceDatumList? datum;
  const DrivingDetailsPage({Key? key, this.datum}) : super(key: key);

  @override
  State<DrivingDetailsPage> createState() => _DrivingDetailsPageState();
}

class _DrivingDetailsPageState extends State<DrivingDetailsPage> with SingleTickerProviderStateMixin {
  DrivingExperienceCarsModel drivingExperienceCarsModelObject = DrivingExperienceCarsModel();

  TabController? tabController;
  int selectedIndex = 0;
  String? mySelectedStartTime, mySelectedEndTime;
  String? myStartTime, myEndTime;
  int? comparison;
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String? dateString;

  DateTime? pickDate;
  String valueDate = "Select Date";
  String? valueDay;
  bool loadingP = true;
  String? companyName, companyImage, companyId;

  DateTime? apiDate;
  String? apiStartTime, apiEndTime;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != pickDate) {
      valueDate = DateFormat('yyyy-MM-dd').format(picked);
      valueDay = DateFormat('EEEE, dd MMMM').format(picked);
      setState(() {
        print("Selected Date is: $valueDate");
        print("Selected Day is: $valueDay");
      });
    }
  }

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
        drivingExperienceCarsModelObject = drivingExperienceCarsModelFromJson(responseString);
        print("drivingExperienceCarsLength: ${drivingExperienceCarsModelObject.data!.length}");
        print("drivingExperienceCarsPlansLength: ${drivingExperienceCarsModelObject.data![0].carsPlans!.length}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  getToday() {
    currentDay = DateFormat('EEEE d').format(DateTime.now());
    print('currentDay = $currentDay');
    companyImage = "$baseUrlImage${widget.datum!.usersCompanies!.companyLogo}";
    companyName = "${widget.datum!.usersCompanies!.companyName}";
    companyId = "${widget.datum!.usersCompaniesId}";
    print("companyName $companyName");
    print("companyImage $companyImage");
    print("companyImage $companyId");
  }

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    getToday();
    getDrivingExperienceCarsWidget();
    super.initState();
  }

  startChatApiWidget() async {
    setState(() {
      loadingP = true;
    });
    Map body = {
      "requestType": "startChat",
      "users_customers_id": userId,
      "other_users_customers_id": "${widget.datum!.usersCompanies!.companyName}",
    };
    http.Response response = await http.post(Uri.parse(startChatApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("startChatApiUrl: $startChatApiUrl");
    print('startChatApiResponse $jsonData');

    if (jsonData['message'] == 'chat already started') {
      // toastSuccessMessage("chat already started", colorGreen);
      print('chat already started');
      setState(() {
        loadingP = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          actions: [
            GestureDetector(
              onTap: () {
                print("clicked");
                startChatApiWidget();

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MessageDetailsScreen(
                      senderName: widget.datum!.usersCompanies!.companyName,
                      senderImage: companyImage,
                    )));
                print("datumData ${widget.datum!.usersCompanies!.companyName}");
                print("datumData $companyImage");
                },
              child: Padding(
                padding: const EdgeInsets.only(top: 30, right: 20),
                child: Image.asset("assets/car_description_images/chat.png",
                  height: 25, width: 25,
                ),
              ),
            ),
          ],
          backgroundColor: appBgColor, elevation: 0.0,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              print("clicked");
              Navigator.pop(context);
              },
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset("assets/live_chat_images/back_arrow.png",
                color: kWhite, height: 25, width: 25,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 30, right: 0),
            child: Column(
                children: [
                  Row(
                      children: [
                        Text("${widget.datum!.vehicalName}, ", style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                        Text("${widget.datum!.year}", style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
                      ]),
                ]),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color(0xff3d4a68),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  color: Color(0xff0f172a),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/home_page/9004787_star_favorite_award_like_icon.png',
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Text('4.0',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: poppinSemiBold,
                                color: kWhite)),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.asset(
                              'assets/car_description_images/tesla.png',
                              width: 41,
                              height: 41),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset(
                              'assets/car_description_images/heart.png',
                              width: 24,
                              height: 20),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: Image.network("$baseUrlImage${widget.datum!.image1}",
                              width: 307, height: 192),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Image.asset(
                            'assets/car_description_images/circle.png',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Color(0xff3d4a68),
                image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Driving Experiences",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: poppinMedium,
                              color: kWhite),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "\$ ${widget.datum!.carsPlans![0].discountedPricePerSlot}",
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: poppinBold,
                              color: kWhite),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/crown_image.png"),
                  RichText(
                    text: TextSpan(
                      text: 'Track Day Session \n',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: poppinMedium,
                          color: kWhite),
                      children: [
                        TextSpan(
                            text: 'Get driven around by \n',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: poppinRegular,
                                color: kWhite)),
                        TextSpan(
                          text: "\" Alex Yoong \"",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: poppinBold,
                              color: kWhite),
                        ),
                        TextSpan(
                          text: ' at \n',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: poppinRegular,
                              color: kWhite),
                        ),
                        TextSpan(
                          text: 'Sepang Circuit for \n RMx,xxx',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: poppinRegular,
                              color: kWhite),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset("assets/images/crown_images_two.png")
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Available Time Slot',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: poppinBold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 00),
            //   child: SizedBox(
            //       width: MediaQuery.of(context).size.width,
            //       height: MediaQuery.of(context).size.height * 0.13,
            //       child: const DaySlotContainer()),
            // ),

            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectDate(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.keyboard_arrow_left, color: borderColor),
                      Text(valueDate,  textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14,
                            fontFamily: poppinSemiBold, color: borderColor),
                      ),
                      Icon(Icons.keyboard_arrow_right, color: borderColor),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height* 0.01),

                valueDay == null?
                Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text("$currentDay",
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
                    child: Text("$valueDay",
                      style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: kWhite ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height* 0.02),

            // valueDate == widget.datum!.carsPlans![0].planDate

         // comparison = valueDate.compareTo(widget.datum.carsPlans[0].planDate);

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
                itemCount: widget.datum!.carsPlans!.length,

                  itemBuilder: (context, index){
                    mySelectedStartTime = widget.datum!.carsPlans![index].startTime;
                    mySelectedEndTime = widget.datum!.carsPlans![index].endTime;
                    // myStartTime = mySelectedStartTime!.substring(0, 5);
                    // myEndTime = mySelectedEndTime!.substring(0, 5);
                    // print("newTime $myStartTime $myEndTime");
                    // print("newTime $mySelectedStartTime $mySelectedEndTime");

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 05),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex = index;
                            apiDate = widget.datum!.carsPlans![selectedIndex].planDate;
                            myStartTime = "${widget.datum!.carsPlans![selectedIndex].startTime}";
                            myEndTime = "${widget.datum!.carsPlans![selectedIndex].endTime}";
                            // myStartTime = mySelectedStartTime!.substring(0, 5);
                            // myEndTime = mySelectedEndTime!.substring(0, 5);
                            DateTime date = DateTime.parse(apiDate.toString());
                            DateFormat formatter = DateFormat("yyyy-MM-dd");
                            String formattedDate = formatter.format(date);
                            print("formattedDate $formattedDate");

                          });

                          print("mySelectedIndex $index");
                          print("mySelectedTime $myStartTime to $myEndTime");
                          print("mySelectedPlanDate ${widget.datum!.carsPlans![index].planDate}");

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
                              Text("$mySelectedStartTime to $mySelectedEndTime",
                                style: TextStyle(color: selectedIndex == index? kWhite: kBlack),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const TabbarCarDescription(),
            GestureDetector(
                onTap: () {
                  print("mySelectedTime123 $myStartTime to $myEndTime");
                  print("123456 $selectedIndex");
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DrivingExperienceBooking(
                          // startTime: myStartTime,
                          startTime: myStartTime,
                          endTime: myEndTime,
                          selectedDate: valueDate,
                          myDatum: widget.datum,
                          selectedDay: valueDay
                      )));

                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }
  compareDate(){
    dateString = '${widget.datum!.carsPlans![0].planDate}';
    final dateTimeFromString = formatter.parse("$dateString");
    // create a DateTime object
    // var now = DateTime.now();
    var now = widget.datum!.carsPlans![0].planDate;
    // compare the two DateTime objects
    if (dateTimeFromString.isAfter(now!)) {
      print('dateTimeFromString is after now');
    } else if (dateTimeFromString.isBefore(now)) {
      print('dateTimeFromString is before now');
    } else {
      print('dateTimeFromString is equal to now');
    }
  }
}
