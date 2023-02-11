import 'dart:convert';

import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/HomePageModels/FavoritesModel/car_favorite_like_unlike_model.dart';
import '../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
import '../../../../../Model/custom_subscription_model.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Widget/toast_message.dart';
import '../../../MessagePage/message_details_screen.dart';
import 'ev_description_details_page.dart';
import 'EvTaBBar/tabbar_description_page.dart';
import 'package:http/http.dart'as http;

class EVCarDescription extends StatefulWidget {
  final Datum? evDatum;

  const EVCarDescription({super.key, this.evDatum});

  @override
  State<EVCarDescription> createState() => _EVCarDescriptionState();
}

class _EVCarDescriptionState extends State<EVCarDescription> with TickerProviderStateMixin {

  mySelectedData(){
    carOwnerId = widget.evDatum!.usersCompaniesId;
    carOwnerName = widget.evDatum!.usersCompanies!.companyName;
    carOwnerImage = "$baseUrlImage${widget.evDatum!.usersCompanies!.companyLogo}";
    print("myCarRating ${widget.evDatum!.carsRatings}");

    print("carOwnerId $carOwnerId");
    print("carOwnerName $carOwnerName");
    print("carOwnerImage $carOwnerImage");

  }


  EvCarsModel evSubscriptionCarsModelObject = EvCarsModel();
  bool loadingP = true;
  int selectedIndex = 0;
  String? tabSelectMonth, tabSelectedPrice;
  String? carOwnerName, carOwnerImage;
  int? carOwnerId;

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
        body: {
          "users_customers_id" : userId
        },
        headers: {'Accept': 'application/json'},
      );
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("evSubscriptionResponse: ${responseString.toString()}");
        evSubscriptionCarsModelObject = evSubscriptionCarsModelFromJson(responseString);
        print("evSubscriptionObjectLength: ${evSubscriptionCarsModelObject.data!.length}");
        monthList();
      }
    } catch (e) {
      print('Error in evSubscription: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }
  List<CustomSubscriptionModel> monthNumber = [];
  monthList(){
    for (int i = 0; i< evSubscriptionCarsModelObject.data!.length; i++) {
      print("OuterLoop:$i");
      for (int j = 0; j < evSubscriptionCarsModelObject.data![i].carsPlans!.length; j++) {
        if(evSubscriptionCarsModelObject.data![i].carsPlans![j].carsId == carID) {
          monthNumber.add(CustomSubscriptionModel(
              months: evSubscriptionCarsModelObject.data![i].carsPlans![j].months!.toString(),
              price_per_months: evSubscriptionCarsModelObject.data![i].carsPlans![j].pricePerMonth!,
              dis_price_per_months: evSubscriptionCarsModelObject.data![i].carsPlans![j].discountedPricePerMonth!.toString()));
          print("monthNumber123 ${monthNumber[0].months}");
          print("InnerLoop:$j");
        }
      }
    }
  }

  startChatApiWidget() async {
    setState(() {
      loadingP = true;
    });
    Map body = {
      "requestType": "startChat",
      "users_customers_id": userId,
      "other_users_customers_id": "$carOwnerId",
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
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
    getEvSubscriptionCarsWidget();
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
                    carOwnerName: carOwnerName,
                    carOwnerImage: carOwnerImage,
                    carOwnerId: "$carOwnerId",
                  )));
              print("evCarOwnerName $carOwnerName");
              print("evCarOwnerLogo $carOwnerImage}");
              print("evCarOwnerId $carOwnerId");
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

          title: Padding(
            padding: const EdgeInsets.only(top: 30, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${widget.evDatum!.vehicalName}, ", style: TextStyle(fontSize: 16, fontFamily: poppinBold, color: kWhite),),
                Text("${widget.evDatum!.year}", style: TextStyle(fontSize: 16, fontFamily: poppinRegular, color: kWhite),),
              ]),
          ),
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
      ),
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

                      widget.evDatum!.rating == null?
                      Text('0.0', style: TextStyle(fontSize: 16,
                          color: kWhite, fontFamily: poppinSemiBold))
                          : Text('${widget.evDatum!.rating}', style: TextStyle(fontSize: 16,
                          color: kWhite, fontFamily: poppinSemiBold)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image.network("$baseUrlImage${widget.evDatum!.carsMakes!.image}",
                          height: 60, width: 50, fit: BoxFit.fill,
                        )

                        // Image.asset('assets/car_description_images/tesla.png', width: 41, height: 41),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child:  widget.evDatum!.favouriteStatus == "like"?
                        Image.asset("assets/home_page/heart.png"):
                        GestureDetector(
                          onTap: () async {
                            myCurrentCarIndex = "${evSubscriptionCarsModelObject.data![0].carsId}";
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
                        // Image.asset('assets/car_description_images/heart.png', width: 24, height: 20),
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Image.asset('assets/car_description_images/circle.png', fit: BoxFit.fill,
                          height: 200, width: 300,
                        ),
                        Positioned(
                          left: 30, right: 20,
                          bottom: 30,
                          child: Image.network("$baseUrlImage${widget.evDatum!.image1}",
                              fit: BoxFit.fill,
                              height: 150, width: 180),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                // child: const MonthSlotContainer(),
                child: tabsList(),
              ),
            ),
            const TabbarCarDescription(),
            GestureDetector(
                onTap: () {
                  print('selectedIndex1: $selectedIndex');
                  print('selectedTabMonth1: $tabSelectMonth');
                  print('selectedTabMonthPrice1: $tabSelectedPrice');
                  if(formKeyEvTabbar.currentState!.validate()){
                    if(tabSelectMonth == null){
                      toastFailedMessage("select Month", kRed);
                    } else{
                      print('selectedIndex123: $selectedIndex');
                      print('selectedTabMonth123: $tabSelectMonth');
                      print('selectedTabMonthPrice: $tabSelectedPrice');
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EvDescriptionDetailsPage(
                            evDatum: widget.evDatum,
                            mySelectedTabMonth: tabSelectMonth,
                            mySelectedTabPrice: tabSelectedPrice,
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

  final GlobalKey<FormState> formKeyEvTabbar = GlobalKey<FormState>();
  tabsList(){
    TabController tabController = TabController(length: monthNumber.length, vsync: this);
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
    Form(
      key: formKeyEvTabbar,
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  color: homeBgColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    // color: selectedIndex == ? borderColor: kWhite,
                    color: borderColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onTap: (index){
                    selectedIndex = index;
                    tabSelectMonth = monthNumber[selectedIndex].months;
                    tabSelectedPrice = monthNumber[selectedIndex].dis_price_per_months;
                    print('selectedIndex: $selectedIndex');
                    print('selectedTabMonth123: $tabSelectMonth');
                    print('selectedTabMonthPrice: $tabSelectedPrice');

                  },
                  tabs: List<Widget>.generate(
                      monthNumber.length, (int index) {
                    print("monthsTabBarLength ${monthNumber.length}");
                    print("monthsTabBarClicked ");
                    return Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Tab(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              monthNumber[index].months == "1" ? Text("${monthNumber[index].months} month", style: TextStyle(
                                color: kBlack, fontSize: 17, fontFamily: poppinMedium,)):
                              Text("${monthNumber[index].months} months", style: TextStyle(
                                  color: kBlack, fontSize: 17, fontFamily: poppinMedium)),

                              Text("RM ${monthNumber[index].dis_price_per_months}",
                                  textAlign: TextAlign.right, style: TextStyle(
                                    fontSize: 14, fontFamily: poppinRegular, color: kBlack,)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  indicatorColor: kWhite,
                  isScrollable: true,
                  labelColor: kWhite,
                  labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
                  unselectedLabelColor: kBlack,
                ),
              )),

        ],
      ),
    );
  }
  CarLikeUnlikeModel carLikeUnlikeModelObject = CarLikeUnlikeModel();
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
      carLikeUnlikeModelObject = carLikeUnlikeModelFromJson(responseString);
      print("carLikeUnlikeModelMessage: ${carLikeUnlikeModelObject.message}");
    }
    // } catch (e) {
    //   print('Error in carLikeUnlike: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }
}
