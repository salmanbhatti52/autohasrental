import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'book_for_wedding_booking_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MessagePage/message_details_screen.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/FavoritesModel/like_unlike_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/EvSubscriptions/EvTaBBar/tabbar_description_page.dart';

class BookForWeddingCarDescription extends StatefulWidget {
  final String? carName, carImage, carYear, carPrice, favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      myCarDescription, myCarRating, myCarComment,
      carRating, carOwnerImage, carOwnerName, discountPercentage, carDiscountPrice;

  final String? featureSuv, featuresSeats, featuresSpeed, featuresAutomatic, featuresDoors,
      featuresElectric, featuresEngine_capacity, featuresFuelCapacity, featuresMeterReading, featuresNewCars;
  final int? carId, carOwnerId;

  BookForWeddingCarDescription({super.key,
    this.carName, this.carColorName, this.carModelName, this.discountPercentage,
    this.carDiscountPrice, this.carImage, this.carYear, this.carMakesImage,
    this.myCarDescription, this.myCarRating, this.myCarComment,
    this.favouriteStatus, this.carMakesName, this.carId, this.carPrice, this.carRating,
    this.carOwnerId, this.carOwnerImage, this.carOwnerName,

    this.featureSuv, this.featuresSeats, this.featuresSpeed, this.featuresAutomatic,
    this.featuresDoors, this.featuresElectric, this.featuresEngine_capacity,
    this.featuresFuelCapacity, this.featuresMeterReading, this.featuresNewCars});

  @override
  State<BookForWeddingCarDescription> createState() => _BookForWeddingCarDescriptionState();
}

class _BookForWeddingCarDescriptionState extends State<BookForWeddingCarDescription> {
  final GlobalKey<FormState> formKeyPhotography = GlobalKey<FormState>();

  String? valueDate;
  String? valueDay;
  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // firstDate: DateTime(1980),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
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

  String? photoGraphyCarOwnerName, photoGraphyCarOwnerImage, photoGraphyCarOwnerId, carImage, pricePerHour;

  int? myHours;
  getToday() {
    currentDay = DateFormat('EEEE, d').format(DateTime.now());
    print('currentDay = $currentDay');

    photoGraphyCarOwnerId = "${widget.carOwnerId}";
    photoGraphyCarOwnerName = widget.carOwnerName;
    photoGraphyCarOwnerImage = "${widget.carOwnerImage}";
    carImage = "$baseUrlImage${widget.carImage}";
    pricePerHour = widget.carDiscountPrice;

    print("ownerName: $photoGraphyCarOwnerName");
    print("ownerImage: $photoGraphyCarOwnerImage");
    print("ownerId: $photoGraphyCarOwnerId");
    print("carImage: $carImage");
    print("pricePerHours: $pricePerHour");

    myHours == null;
    print("myHours $myHours");
    // dropdownValueTime?.isEmpty;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToday();
    print("myCarComment ${widget.myCarComment}");
  }

  bool loadingP = true;
  startChatApiWidget() async {
    setState(() {
      loadingP = true;
    });
    Map body = {
      "requestType": "startChat",
      "users_customers_id": userId,
      "other_users_customers_id": "$photoGraphyCarOwnerId",
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
          systemOverlayStyle: SystemUiOverlayStyle(
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
                        carOwnerName: photoGraphyCarOwnerName,
                        carOwnerImage: photoGraphyCarOwnerImage,
                    carOwnerId: photoGraphyCarOwnerId
                    )));
                print("photoGraphyCarOwnerId: $photoGraphyCarOwnerId");
                print("photoGraphyCarOwnerName: $photoGraphyCarOwnerName");
                print("photoGraphyCarOwnerImage: $photoGraphyCarOwnerImage");
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30, right: 20),
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
              padding: EdgeInsets.only(top: 30),
              child: Image.asset("assets/live_chat_images/back_arrow.png",
                color: kWhite, height: 25, width: 25,
              ),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(top: 30, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.carName}, ", style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                  Text("${widget.carYear}", style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
                ]),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.37,
              decoration: BoxDecoration(
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
                      showRatingStars(double.parse("${widget.carRating}")),
                      // Image.asset('assets/home_page/9004787_star_favorite_award_like_icon.png',),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      widget.carRating == null?
                          Text("0.0", style: TextStyle(fontSize: 16,
                              color: kWhite, fontFamily: poppinSemiBold)):
                          Text('${widget.carRating}', style: TextStyle(fontSize: 16,
                          color: kWhite, fontFamily: poppinSemiBold)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child:
                        // Image.network("${widget.carMakesImage}",
                        //   height: 60, width: 50, fit: BoxFit.fill,
                        // ),

                        CachedNetworkImage(
                          imageUrl: "${widget.carMakesImage}",
                          height: 50, width: 50,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(strokeWidth: 2, value: downloadProgress.progress, color: borderColor,),
                          errorWidget: (context, url, error) => Image.asset("assets/icon/fade_in_image.jpeg"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: widget.favouriteStatus == "like"?
                        Image.asset("assets/home_page/heart.png"):
                        GestureDetector(
                          onTap: () async {
                            print("clicked...");
                            myCurrentCarIndex = "${widget.carId}";
                            print("carsPhotoGraphyIds $myCurrentCarIndex");
                            await getLikeUnlikeCarWidget();
                            if (carLikeUnlikeModelObject.message == "Liked") {
                              print("isLiked");
                              toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                            }
                            if (carLikeUnlikeModelObject.message == "Unliked") {
                              print("isUnLiked");
                              toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                            }
                          },
                          child: carLikeUnlikeModelObject.message == "Liked"
                              ? Image.asset("assets/home_page/heart.png")
                              : Image.asset("assets/car_bookings_images/heart.png"),
                        ),

                        // Image.asset('assets/car_description_images/heart.png', width: 24, height: 20),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: Image.network("${widget.carImage}", width: 307, height: 150),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Image.asset(
                          'assets/car_description_images/circle.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price', textAlign: TextAlign.left, style: TextStyle(
                        fontSize: 17, fontFamily: poppinMedium, color: borderColor)),
                  RichText(
                    text: TextSpan(text: 'RM', style: TextStyle(
                        fontSize: 14, fontFamily: poppinBold, color: borderColor),
                      children: [
                        TextSpan(
                          text: '$pricePerHour', style: TextStyle(
                            fontSize: 24, fontFamily: poppinBold, color: borderColor)),
                        TextSpan(
                          text: '/hrs', style: TextStyle(
                            fontSize: 14, fontFamily: poppinMedium, color: borderColor)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Select Booking Day and Time',  textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, fontFamily: poppinBold)),
            ),

            Column(
              children: [
                Form(
                  key: formKeyPhotography,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      GestureDetector(
                        onTap: () {
                          print("clicked...");
                          selectDate(context);
                        },
                        child: Container(
                          width: 220,
                          height: 40,
                          decoration: BoxDecoration(
                            color: valueDay == null? kWhite: borderColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(valueDay == null? "Select Date" : "$valueDay", textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 14, fontFamily: poppinSemiBold, color: valueDay == null? borderColor: kWhite)),
                              Icon(Icons.keyboard_arrow_right, color: valueDay == null? borderColor: kWhite),
                            ],
                          ),
                        ),
                      ),

                      // GestureDetector(
                      //   onTap: () {
                      //     selectDate(context);
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 10),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(Icons.keyboard_arrow_left, color: borderColor),
                      //         valueDate == null? Text("Select Date", textAlign: TextAlign.left,
                      //           style: TextStyle(fontSize: 14, fontFamily: poppinSemiBold, color: borderColor)):
                      //         Text(valueDate!,  textAlign: TextAlign.left,
                      //           style: TextStyle(fontSize: 14,
                      //               fontFamily: poppinSemiBold, color: borderColor),
                      //         ),
                      //         Icon(Icons.keyboard_arrow_right, color: borderColor),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      //
                      // valueDay == null? Container():
                      // Container(
                      //   width: 200,
                      //   height: 40,
                      //   decoration: BoxDecoration(
                      //     color:  borderColor,
                      //     borderRadius: BorderRadius.circular(15),
                      //   ),
                      //   child: Center(
                      //     child: Text("$valueDay",
                      //       style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: kWhite ),
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: dropDownHourWidget(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {
                                    selectTimeStart(context);
                                  },
                                  child:
                                  formattedStartTime == null?
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("Start Time", style: TextStyle(color:  kBlack , fontSize: 16),
                                      ),
                                    ),
                                  ):

                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color:  borderColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text("${formattedStartTime}", style: TextStyle(color: kWhite, fontSize: 16),
                                      ),
                                    ),
                                  ),
                              ),

                              InkWell(
                                  onTap: () {
                                    // selectTimeEnd(context);
                                  },
                                  child: formattedEndTime == null?
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text("End Time",
                                        style: TextStyle(color: kBlack, fontSize: 16)),
                                    ),
                                  ):
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: borderColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(formattedEndTime!,
                                        style: TextStyle(
                                            color: kWhite, fontSize: 16),
                                      ),
                                    ),
                                  )
                              ),

                            ]),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            // TabbarBookForWedding(),
            TabbarCarDescription(
              myDescription: widget.myCarDescription,
              myRating: widget.myCarRating,
              myComment: widget.myCarComment,
            ),
            GestureDetector(
                onTap: () {
                  if(formKeyPhotography.currentState!.validate()){
                    if(valueDate == null){
                      toastFailedMessage("Select date", kRed);
                    } else if(myHours == null){
                      toastFailedMessage("Select Hours", kRed);
                    } else if(formattedStartTime == null || formattedEndTime == null){
                      toastFailedMessage("Select Time", kRed);
                    } else{
                      print("all okay");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BookForWeddingBookingDetails(
                            // datumPhotography: widget.datumPhotography,
                            selectedDate: valueDate,
                            selectedDay: valueDay,
                            selectedHours: dropdownValueTime,
                            selectedStartTime: formattedStartTime,
                            selectedEndTime: formattedEndTime,
                            hoursInNumber: myHours,

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
                            carOwnerId: widget.carOwnerId)));
                    }
                  }

                  print("time1 $dropdownValueTime");
                  print("time12 $myHours");
                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }

  DateTime startDateTime = DateTime.now();
  DateTime? _endTime;
  DateTime valueTimeStart = DateTime.now();
  String? formattedStartTime, formattedEndTime;
  String? valueTimeEnd ;
  TimeOfDay? startTime;

  selectTimeStart(BuildContext context) async {
    formattedStartTime = DateFormat('HH:mm:ss').format(valueTimeStart);
    TimeOfDay? picked;
    picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked == null) {
      picked = startTime;
    } else {
      startDateTime = DateTime(picked.hour, picked.minute);
      // valueTimeStart = picked.format(context).toString();
      setState(() {
        print("Selected startTime is : $formattedStartTime");
      });
      // valueTimeStart = '${picked.hour}:${picked.minute}:00';
       _endTime = valueTimeStart.add(Duration(hours: int.parse("$myHours")));
      formattedEndTime = DateFormat('HH:mm:ss').format(_endTime!);
       print("_endTime $_endTime");
       print("formattedEndTime $formattedEndTime");

      setState(() {
        print("Selected startTime is : $valueTimeStart");
        print("myTime $valueTimeStart");
      });
    }
  }

  // Future<void> _selectStartTime(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: _startTime,
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime.now().add(Duration(days: 30)));
  //   if (picked != null) {
  //     final TimeOfDay? time = await showTimePicker(
  //         context: context, initialTime: TimeOfDay.now());
  //     if (time != null) {
  //       setState(() {
  //         _startTime = DateTime(picked.year, picked.month, picked.day,
  //             time.hour, time.minute);
  //         _endTime = _startTime.add(Duration(hours: int.parse("$myHours")));
  //       });
  //     }
  //   }
  // }

  // selectTimeEnd(BuildContext context) async {
  //   TimeOfDay? picked;
  //   picked = await showTimePicker(
  //
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (picked == null) {
  //     picked = startTime;
  //   } else {
  //
  //     valueTimeEnd = picked.format(context).toString();
  //     setState(() {
  //       print("Selected endTime is : $valueTimeEnd");
  //     });
  //     valueTimeEnd = '${picked.hour}:${picked.minute}:00';
  //     setState(() {
  //       print("Selected endTime is : $valueTimeEnd");
  //       // calculateTimeInterval();
  //       compareTime();
  //     });
  //     print("myEndTime $valueTimeEnd");
  //   }
  // }

  dynamic hours, minutes;
  // calculateTimeInterval(){
  //   var format = DateFormat("HH:mm");
  //   var start = format.parse(valueTimeStart!);
  //   var end = format.parse(valueTimeEnd!);
  //   // print("timeDifference ${end.difference(start)}");
  //   print("startTime $start");
  //   print("endTime $end");
  //
  //   Duration diff = start.difference(end).abs();
  //   print("duration is $diff");
  //   hours = diff.inHours;
  //   // minutes = diff.inMinutes / 60;
  //   minutes = diff.inMinutes % 60;
  //   print('selectedTime interval $hours');
  //   print('$hours hours $minutes minutes');
  // }
  int? myMinutes, selectedMinutes;

  compareTime(){
    if(formKeyPhotography.currentState!.validate()){
      myMinutes = int.parse(myHours.toString()) * 60;
      selectedMinutes = (hours* 60)+ minutes;
      print("myMinutes $myMinutes $selectedMinutes");
      print("value $myHours $hours");

      if(myMinutes == selectedMinutes){
        // toastSuccessMessage("time matched successfully", colorGreen);
        print("success");
      }
      else{
        toastFailedMessage("time didn't matched", kRed);
        print("no success");
      }

      // if(myHours == hours){
      //   toastSuccessMessage("time compare success", colorGreen);
      //   print("success");
      // }
      // else{
      //   toastFailedMessage("time compare failed", kRed);
      //   print("no success");
      // }
    }
  }



  // DateTime _endTime = DateTime.now().add(Duration(hours: 1));
  Widget dropDownHourWidget(){
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
        padding: EdgeInsets.only(left: 10, right: 10),
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

  LikeUnlikeCarModel carLikeUnlikeModelObject = LikeUnlikeCarModel();
  String? myCurrentCarIndex;
  getLikeUnlikeCarWidget() async {
    loadingP = true;
    setState(() {});
    // try {
    String apiUrl = likeUnlikeFavoriteCarsApiUrl;
    print("carLikeUnlikeModelApi: $apiUrl");
    print("carLikeUnlikeUserId: $userId");
    print("carId: $myCurrentCarIndex");
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "users_customers_id": userId,
        "cars_id": myCurrentCarIndex,
      },
      headers: {'Accept': 'application/json'},
    );
    print('statusCodeLikeUnlike ${response.statusCode}');

    if (response.statusCode == 200) {
      final responseString = response.body;
      print("carLikeUnlikeModelResponse: ${responseString.toString()}");
      carLikeUnlikeModelObject = likeUnlikeCarModelFromJson(responseString);
      print("carLikeUnlikeModelMessage: ${carLikeUnlikeModelObject.message}");
    }
    // } catch (e) {
    //   print('Error in carLikeUnlike: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }
}
