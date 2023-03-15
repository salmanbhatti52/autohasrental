import 'dart:convert';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../../Model/HomePageModels/FavoritesModel/like_unlike_model.dart';
import '../../../../../Model/HomePageModels/HomeTopWidgetModels/driving_cars_model.dart';
import '../../../../../Widget/toast_message.dart';
import '../../../MessagePage/message_details_screen.dart';
import 'DescriptionTabs/driving_tabbars.dart';
import 'driving_experience_booking.dart';
import 'package:http/http.dart'as http;

class DrivingDetailsPage extends StatefulWidget {
  final DatumDrivingTopCard? datum;
  const DrivingDetailsPage({Key? key, this.datum}) : super(key: key);

  @override
  State<DrivingDetailsPage> createState() => _DrivingDetailsPageState();
}

class _DrivingDetailsPageState extends State<DrivingDetailsPage> with SingleTickerProviderStateMixin {
  DrivingCarsModel drivingCarsModelObject = DrivingCarsModel();

  TabController? tabController;
  int selectedIndex = 0;
  double? selectedSlotPrice;
  String? mySelectedStartTime, mySelectedEndTime;
  var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  DateTime? pickDate;
  String? valueDate, valueDay, dateString;
  bool loadingP = true;
  String? companyName, companyImage, companyId;
  String? apiStartTime, apiEndTime, apiDate;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      // firstDate: DateTime(1980),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      /// we added this line to To disable all previous dates
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != pickDate) {
      valueDate = DateFormat('yyyy-MM-dd').format(picked);
      valueDay = DateFormat('EEEE, dd MMMM').format(picked);
      setState(() {
        print("Selected Date is: $valueDate");
        print("Selected Day is: $valueDay");
        compareDates();
      });
    }
  }

  getToday() {
    // currentDay = DateFormat('EEEE d').format(DateTime.now());
    // print('currentDay = $currentDay');
    companyImage = "$baseUrlImage${widget.datum!.usersCompanies!.companyLogo}";
    companyName = widget.datum!.usersCompanies!.companyName;
    companyId = "${widget.datum!.usersCompaniesId}";
    print("drivingCompanyName $companyName");
    print("DrivingCompanyImage $companyImage");
    print("DrivingCompanyId $companyId");
    // getTodayDate();
  }

  String? formattedDate, matchDate;
  List dateList = [];
  List<CustomSlotModel> myCarPlan = [];

  compareDates(){
    dateList.clear();
    print("valueDate123 $valueDate");
    for(int i = 0; i<widget.datum!.carsPlans!.length; i++){
      DateTime date = DateTime.parse("${widget.datum!.carsPlans![i].planDate}");
      formattedDate = DateFormat("yyyy-MM-dd").format(date);
      print("formattedDate $formattedDate");
      dateList.add(formattedDate);
      print("dateList $dateList");
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
        // toastFailedMessage("not Equal", kRed);
        print("not equal");
      }
    }
    print("myCarPlanLength111 ${myCarPlan.length}");
    myCarPlan.clear();

    if(matchDate != null){
      for(int k = 0; k<widget.datum!.carsPlans!.length; k++) {
        DateTime date = DateTime.parse("${widget.datum!.carsPlans![k].planDate}");
        formattedDate = DateFormat("yyyy-MM-dd").format(date);
        if(formattedDate == matchDate ){
          myCarPlan.add(CustomSlotModel(
            date: widget.datum!.carsPlans![k].planDate.toString(),
            startTime: "${widget.datum!.carsPlans![k].startTime}",
            endTime: "${widget.datum!.carsPlans![k].endTime}",
            discountedPrice: widget.datum!.carsPlans![k].discountedPricePerSlot.toString(),
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

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    myCurrentCarIndex = "${widget.datum!.carsId}";
    getToday();
    super.initState();
  }

  startChatApiWidget() async {
    setState(() {
      loadingP = true;
    });
    Map body = {
      "requestType": "startChat",
      "users_customers_id": userId,
      "other_users_customers_id": "$companyId",
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
                      carOwnerName: companyName,
                      carOwnerImage: companyImage,
                      carOwnerId: companyId,
                    )));
                print("drivingOwnerId $companyId");
                print("drivingOwnerName $companyName");
                print("drivingOwnerImage $companyImage");

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.datum!.vehicalName}, ", style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                  Text("${widget.datum!.year}", style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
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
                        showRatingStars(double.parse("${widget.datum!.rating}")),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                        Text('${widget.datum!.rating}', style: TextStyle(
                            fontSize: 16, fontFamily: poppinSemiBold, color: kWhite)),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Image.network("$baseUrlImage${widget.datum!.carsMakes!.image}",
                              height: 60, width: 50, fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: widget.datum!.favouriteStatus == "like"?
                          Image.asset("assets/home_page/heart.png"):
                          GestureDetector(
                            onTap: () async {
                              myCurrentCarIndex = "${widget.datum!.carsId}";
                              print("evCarIds $myCurrentCarIndex");
                              await getLikeUnlikeCarWidget();
                              if (carLikeUnlikeModelObject.message == "Liked") {
                                print("isLiked");
                                // toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                              }
                              if (carLikeUnlikeModelObject.message == "Unliked") {
                                print("isUnLiked");
                                // toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                              }
                            },
                            child: carLikeUnlikeModelObject.message == "Liked"
                                ? Image.asset("assets/home_page/heart.png")
                                : Image.asset("assets/car_bookings_images/heart.png"),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Positioned(
                          child: Image.network("$baseUrlImage${widget.datum!.image1}",
                              width: 307, height: 150),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Image.asset('assets/car_description_images/circle.png'),
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
                        Text("Driving Experiences", textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17, fontFamily: poppinMedium, color: kWhite)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                  fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
                            ),
                            Text(
                              "${widget.datum!.carsPlans![0].discountedPricePerSlot}",
                                textAlign: TextAlign.left, style: TextStyle(
                                fontSize: 20, fontFamily: poppinBold, color: kWhite)),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text("/slot", textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/crown_image.png"),
                  RichText(
                    text: TextSpan(text: 'Track Day Session \n', style: TextStyle(
                        fontSize: 25, fontFamily: poppinMedium, color: kWhite),
                      children: [
                        TextSpan(text: 'Get driven around by \n', style: TextStyle(
                            fontSize: 25, fontFamily: poppinRegular, color: kWhite)),
                        TextSpan(text: "\" Alex Yoong \"", style: TextStyle(
                              fontSize: 25, fontFamily: poppinBold, color: kWhite)),
                        TextSpan(text: ' at \n', style: TextStyle(
                              fontSize: 25, fontFamily: poppinRegular, color: kWhite)),
                        TextSpan(text: 'Sepang Circuit for \n RMx,xxx', style: TextStyle(
                            fontSize: 25, fontFamily: poppinRegular, color: kWhite)),
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
              child: Text('Available Time Slot',  textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, fontFamily: poppinBold)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            myWidget(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            DrivingTabBars(datumTopCard: widget.datum),
            GestureDetector(
                onTap: () {
                  if(myFormKey.currentState!.validate()){
                    if(valueDate == null || valueDay == null){
                      print("valueDate $valueDate");
                      print("myValueDay $valueDay");
                      toastFailedMessage('select date ', kRed);
                    }
                    else if(myCarPlan.isEmpty){
                      toastFailedMessage('select an other Plan Day', kRed);
                    }
                    else if(mySelectedStartTime == null || mySelectedEndTime == null){
                      print("myValueDay $mySelectedStartTime $mySelectedEndTime");
                      toastFailedMessage('select Time Slot ', kRed);
                    }
                    else{
                      print("mySelectedTime123 $mySelectedStartTime to $mySelectedEndTime");
                      print("selectedSlotPrice $selectedSlotPrice");
                      print("123456 $selectedIndex");
                      print("123456 $valueDate");
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DrivingExperienceBooking(
                            startTime: mySelectedStartTime,
                            endTime: mySelectedEndTime,
                            selectedDate: valueDate,
                            myDatum: widget.datum,
                            selectedDay: valueDay,
                            slotPrice: selectedSlotPrice,
                          )));
                    }
                  }
                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  Widget myWidget(){
    return Form(
      key: myFormKey,
      child: Column(
        children: [
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
          SizedBox(height: MediaQuery.of(context).size.height* 0.02),

          myCarPlan.isEmpty ? Center(child: Text("No Slots Available", textAlign: TextAlign.left,
              style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinBold))):
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200, minHeight: 50.0),
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 0.2,
                  mainAxisSpacing: 05,
                  crossAxisSpacing: 0,
                ),
                itemCount: myCarPlan.length,
                itemBuilder: (context, index){
                  print("myCarPlansLength ${myCarPlan.length}");
                  print("selectedIndex $selectedIndex");
                  mySelectedStartTime = myCarPlan[index].startTime;
                  mySelectedEndTime = myCarPlan[index].endTime;
                  selectedSlotPrice = double.parse(myCarPlan[index].discountedPrice);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 05),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                          apiDate = myCarPlan[selectedIndex].date;
                          mySelectedStartTime = myCarPlan[selectedIndex].startTime;
                          mySelectedEndTime = myCarPlan[selectedIndex].endTime;
                          selectedSlotPrice = double.parse(myCarPlan[selectedIndex].discountedPrice);
                          DateTime date = DateTime.parse(apiDate.toString());
                          DateFormat formatter = DateFormat("yyyy-MM-dd");
                          String formattedDate = formatter.format(date);
                          print("formattedDate $formattedDate");
                          print("selectedSlotPrice $selectedSlotPrice");
                        });
                        print("mySelectedIndex $index");
                        print("mySelectedTime $mySelectedStartTime to $mySelectedEndTime");
                        },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedIndex == index? borderColor: kWhite,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 2,
                            color: selectedIndex == index ? borderColor : const Color(0xffd4dce1)),
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
        ],
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

class CustomSlotModel{
  String date;
  String startTime;
  String endTime;
  String discountedPrice;
  CustomSlotModel({
    required this.date, required this.startTime,
    required this.endTime, required this.discountedPrice});
}
