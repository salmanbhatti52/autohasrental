import 'dart:convert';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/constants.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Utils/colors.dart';
import '../../../MessagePage/message_details_screen.dart';
import 'BookForWeddingTabbar/tabbar_book_for_wedding.dart';
import 'book_for_wedding_booking_details.dart';
import 'package:http/http.dart'as http;

class BookForWeddingCarDescription extends StatefulWidget {
  final String? carName, carImage, carRating, carDescription, ownerImage, ownerName, ownerId, pricePerHours;
  final int? carYear;
  const BookForWeddingCarDescription({super.key,
    this.carName, this.ownerImage, this.pricePerHours, this.ownerId,
    this.ownerName, this.carYear, this.carImage, this.carRating, this.carDescription});

  @override
  State<BookForWeddingCarDescription> createState() => _BookForWeddingCarDescriptionState();
}

class _BookForWeddingCarDescriptionState extends State<BookForWeddingCarDescription> {
  final GlobalKey<FormState> formKeyPhotography = GlobalKey<FormState>();

  String valueDate = "Select Date";
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

  getToday() {
    currentDay = DateFormat('EEEE, d').format(DateTime.now());
    print('currentDay = $currentDay');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToday();
    print("ownerName: ${widget.ownerName}");
    print("ownerImage: ${widget.ownerImage}");
    print("ownerId: ${widget.ownerId}");
    print("carId: ${widget.carImage}");
    print("pricePerHours: ${widget.pricePerHours}");
  }

  bool loadingP = true;
  startChatApiWidget() async {
    setState(() {
      loadingP = true;
    });
    Map body = {
      "requestType": "startChat",
      "users_customers_id": userId,
      "other_users_customers_id": "${widget.ownerId}",
    };
    http.Response response = await http.post(Uri.parse(startChatApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("startChatApiUrl: $sendMessageApiUrl");
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
            statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          ),
          actions: [
            GestureDetector(
              onTap: () {
                print("clicked");
                startChatApiWidget();

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MessageDetailsScreen(
                      senderName: widget.ownerName,
                      senderImage: widget.ownerImage)));
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
                        Text("${widget.carName}, ", style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                        Text("${widget.carYear}", style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
                      ]),
                ]),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.37,
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
                      Image.asset('assets/home_page/9004787_star_favorite_award_like_icon.png',),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      // widget.carRating == null?
                          Text("0.0", style: TextStyle(fontSize: 16,
                              color: kWhite, fontFamily: poppinSemiBold))
                          // : Text('${widget.carRating}', style: TextStyle(fontSize: 16,
                          // color: kWhite, fontFamily: poppinSemiBold)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.asset('assets/car_description_images/tesla.png', width: 41, height: 41),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Image.asset('assets/car_description_images/heart.png', width: 24, height: 20),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: Image.network("${widget.carImage}", height: 190, width: 310),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price', textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17,
                        fontFamily: 'Poppins-Medium',
                        color: borderColor)),
                  RichText(
                    text: TextSpan(
                      text: 'RM',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: poppinBold,
                          color: borderColor),
                      children: [
                        TextSpan(
                          text: '${widget.pricePerHours}',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: poppinBold,
                              color: borderColor),
                        ),
                        TextSpan(
                          text: '/hrs',
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: poppinMedium,
                              color: borderColor),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Select Booking Day and Time',
                style: TextStyle(fontSize: 14, fontFamily: 'Poppins-Bold'),
                textAlign: TextAlign.left,
              ),
            ),

            Column(
              children: [
                Form(
                  key: formKeyPhotography,
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: () {
                          selectDate(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
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
                      ),

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

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: timeWidget(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    selectTimeStart(context);
                                    // _selectTime(context);
                                  },

                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: valueTimeStart == "Start Time" ? kWhite : borderColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text(
                                        valueTimeStart,
                                        style: TextStyle(
                                            color: valueTimeStart == "Start Time" ? kBlack : kWhite, fontSize: 16),
                                      ),
                                    ),
                                  )),

                              InkWell(
                                  onTap: () {
                                    selectTimeEnd(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: valueTimeEnd == "End Time" ? kWhite : borderColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(valueTimeEnd,
                                        style: TextStyle(
                                            color: valueTimeEnd == "End Time" ? kBlack : kWhite, fontSize: 16),
                                      ),
                                    ),
                                  )),

                            ]),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            const TabbarBookForWedding(),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => BookForWeddingBookingDetails(
                        carName: widget.carName,
                        carYear: widget.carYear,
                        selectedDate: valueDate,
                        selectedDay: valueDay,
                        selectedHours: dropdownValueTime,
                        selectedStartTime: valueTimeStart,
                        selectedEndTime: valueTimeEnd,
                        hours: myHours,)));
                  print("time1 $dropdownValueTime");
                  print("time12 $myHours");

              // compareTime();

                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }
  var hours;
  var minutes;
  calculateTimeInterval(){
    var format = DateFormat("HH:mm");
    var start = format.parse(valueTimeStart);
    var end = format.parse(valueTimeEnd);
    // print("timeDifference ${end.difference(start)}");
    print("startTime $start");
    print("endTime $end");

    Duration diff = start.difference(end).abs();
    print("duration is $diff");
    hours = diff.inHours;
    minutes = diff.inMinutes / 60;
    // minutes = diff.inMinutes % 60;
    print('selectedTime interval $hours');
    print('$hours hours $minutes minutes');
  }

  String valueTimeStart = "Start Time";
  String valueTimeEnd = "End Time";
  TimeOfDay? startTime;

  selectTimeStart(BuildContext context) async {
    TimeOfDay? picked;
    picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) {
      picked = startTime;
    } else {
      valueTimeStart = picked.format(context).toString();
      setState(() {
        print("Selected startTime is : $valueTimeStart");
      });
      valueTimeStart = '${picked.hour}:${picked.minute}:00';
      setState(() {
        print("Selected startTime is : $valueTimeStart");
        print("myTime $valueTimeStart");
      });

    }
  }

  selectTimeEnd(BuildContext context) async {
    TimeOfDay? picked;
    picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) {
      picked = startTime;
    } else {

      valueTimeEnd = picked.format(context).toString();
      setState(() {
        print("Selected endTime is : $valueTimeEnd");
      });
      valueTimeEnd = '${picked.hour}:${picked.minute}:00';
      setState(() {
        print("Selected endTime is : $valueTimeEnd");
        calculateTimeInterval();
        compareTime();
      });
      print("myEndTime $valueTimeEnd");

      // valueTimeEnd = picked.format(context).toString();
      // setState(() {
      //   print("Selected endTime is : $valueTimeEnd");
      //   calculateTimeInterval();
      //   compareTime();
      // });
    }
  }

  compareTime(){
    if(formKeyPhotography.currentState!.validate()){
      print("value $myHours $hours");
      if(myHours == hours){
        toastSuccessMessage("time compare success", colorGreen);
        print("success");
      }
      else{
        toastFailedMessage("time compare failed", kRed);
        print("no success");
      }
    }
  }

  int? myHours;
  Widget timeWidget(){
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.055,
      width: MediaQuery.of(context).size.width * 01.3,
      decoration: BoxDecoration(
        color: kWhite,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: kBlack)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            hint: Text('Select Hours',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 12,
                  color: kBlack, fontWeight: FontWeight.w400))),
            icon: Icon(Icons.keyboard_arrow_down_rounded, size: 30, color: kBlack),
            items: timeHoursList.map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 14,
                      color: kBlack, fontWeight: FontWeight.w400))),
            ),
            ).toList(),
            value: dropdownValueTime,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValueTime = newValue!.split(" hour").first;
                myHours = int.parse(dropdownValueTime);
                dropdownValueTime = newValue;
                print("selectedTime: $dropdownValueTime");
                print("selectedTime: $myHours");

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
    );
  }
}
