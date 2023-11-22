import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../../../Model/GetMileagePlansModel.dart';
import '../../../../../Model/GetMonthPlansModel.dart';
import 'ev_description_details_page.dart';
import 'EvTaBBar/tabbar_description_page.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_haus_rental_app/Model/custom_subscription_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MessagePage/message_details_screen.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/FavoritesModel/like_unlike_model.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';

class EVCarDescription extends StatefulWidget {
  final String? carName,
      carImage,
      carYear,
      carPrice,
      carStatus,
      carColorName,
      favouriteStatus,
      carModelName,
      carMakesName,
      carMakesImage,
      myCarDescription,
      myCarRating,
      myCarComment,
      carRating,
      carOwnerImage,
      carOwnerName,
      discountPercentage;
  final String? featureSuv,
      featuresSeats,
      featuresSpeed,
      featuresAutomatic,
      featuresDoors,
      featuresElectric,
      featuresEngine_capacity,
      featuresFuelCapacity,
      featuresMeterReading,
      featuresNewCars;
  final int? carId, carOwnerId;
  final String? carDiscountPrice;
  EVCarDescription(
      {super.key,
      this.carName,
      this.myCarDescription,
      this.favouriteStatus,
      this.myCarRating,
      this.myCarComment,
      this.carColorName,
      this.carModelName,
      this.discountPercentage,
      this.carDiscountPrice,
      this.carImage,
      this.carYear,
      this.carMakesImage,
      this.carStatus,
      this.carMakesName,
      this.carId,
      this.carPrice,
      this.carRating,
      this.carOwnerId,
      this.carOwnerImage,
      this.carOwnerName,
      this.featureSuv,
      this.featuresSeats,
      this.featuresSpeed,
      this.featuresAutomatic,
      this.featuresDoors,
      this.featuresElectric,
      this.featuresEngine_capacity,
      this.featuresFuelCapacity,
      this.featuresMeterReading,
      this.featuresNewCars});

  @override
  State<EVCarDescription> createState() => _EVCarDescriptionState();
}

class _EVCarDescriptionState extends State<EVCarDescription>
    with TickerProviderStateMixin {
  mySelectedData() {
    carOwnerId = widget.carOwnerId;
    carOwnerName = widget.carOwnerName;
    carOwnerImage = "${widget.carOwnerImage}";
    print("myCarRating ${widget.carRating}");

    print("carOwnerId $carOwnerId");
    print("carOwnerName $carOwnerName");
    print("carOwnerImage $carOwnerImage");
  }

  // EvCarsModel evCarsModelObject = EvCarsModel();
  bool loadingP = true;
  // int selectedIndex = 0;
  String? tabSelectMonth, tabSelectedPrice, carLikeStatus, selectedMileagePlan;
  String? carOwnerName, carOwnerImage;
  int? carOwnerId, mileagePlanID;

  // getEvSubscriptionCarsWidget() async {
  //   loadingP = true;
  //   setState(() {});
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   print('in LoginPage shared prefs');
  //   prefs = await SharedPreferences.getInstance();
  //   userId = prefs.getString('userid');
  //   print("userId in Prefs is = $userId");
  //   try {
  //     String apiUrl = carsEvSubscriptionApiUrl;
  //     print("evSubscriptionApi: $apiUrl");
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: {
  //         "users_customers_id" : userId
  //       },
  //       headers: {'Accept': 'application/json'},
  //     );
  //     print('${response.statusCode}');
  //     print(response);
  //     if (response.statusCode == 200) {
  //       final responseString = response.body;
  //       print("evSubscriptionResponse: ${responseString.toString()}");
  //       evCarsModelObject = evCarsModelFromJson(responseString);
  //       print("evSubscriptionObjectLength: ${evCarsModelObject.data!.length}");
  //       monthList();
  //     }
  //   } catch (e) {
  //     print('Error in evSubscription: ${e.toString()}');
  //   }
  //   loadingP = false;
  //   setState(() {});
  // }

  // List<CustomSubscriptionModel> monthNumber = [];
  // double? myCarPrice;
  // monthList(){
  //   for (int i = 0; i< evCarsModelObject.data!.length; i++) {
  //     print("OuterLoop:$i");
  //     for (int j = 0; j < evCarsModelObject.data![i].carsPlans!.length; j++) {
  //       if(evCarsModelObject.data![i].carsPlans![j].carsId == carID) {
  //         print("fref");
  //         monthNumber.add(CustomSubscriptionModel(
  //             months: evCarsModelObject.data![i].carsPlans![j].months!.toString(),
  //             price_per_months: evCarsModelObject.data![i].carsPlans![j].pricePerMonth!,
  //             dis_price_per_months: evCarsModelObject.data![i].carsPlans![j].discountedPricePerMonth!.toString()));
  //         // myCarPrice = evCarsModelObject.data![i].carsPlans![j].months!.toString() * int.parse(evCarsModelObject.data![i].carsPlans![j].discountedPricePerMonth!.toString());
  //         myCarPrice = double.parse(evCarsModelObject.data![i].carsPlans![j].months!.toString()) *
  //             double.parse(evCarsModelObject.data![i].carsPlans![j].discountedPricePerMonth!.toString());
  //         print('myCarPrice $myCarPrice');
  //         tabSelectMonth = monthNumber[0].months;
  //        tabSelectedPrice = monthNumber[0].dis_price_per_months;
  //         print("monthNumber123 $tabSelectMonth $tabSelectedPrice");
  //         print("InnerLoop:$j");
  //       }
  //     }
  //   }
  // }

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
        body: body, headers: {"Accept": "application/json"});
    Map jsonData = jsonDecode(response.body);
    print("startChatApiUrl: $startChatApiUrl");
    print('startChatApiResponse $jsonData');

    if (jsonData['message'] == 'chat already started') {
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
    // getEvSubscriptionCarsWidget();
    mileagePlansListWidget();
    carLikeStatus = widget.favouriteStatus;
    print('carLikeStatus ${carLikeStatus}');
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
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
              padding: EdgeInsets.only(top: 30, right: 20),
              child: Image.asset(
                "assets/car_description_images/chat.png",
                height: 25,
                width: 25,
              ),
            ),
          ),
        ],
        backgroundColor: appBgColor,
        elevation: 0.0,
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(top: 30, right: 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "${widget.carName}, ",
              style: TextStyle(
                  fontSize: 16, fontFamily: poppinBold, color: kWhite),
            ),
            Text(
              "${widget.carYear}",
              style: TextStyle(
                  fontSize: 16, fontFamily: poppinRegular, color: kWhite),
            ),
          ]),
        ),
        leading: GestureDetector(
          onTap: () {
            print("clicked");
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Image.asset(
              "assets/live_chat_images/back_arrow.png",
              color: kWhite,
              height: 25,
              width: 25,
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
                      // showRatingStars("${widget.carRating}"),
                      showRatingStars(double.parse("${widget.carRating}")),
                      // Image.asset('assets/home_page/9004787_star_favorite_award_like_icon.png',),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),

                      widget.carRating == null
                          ? Text('0.0',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: kWhite,
                                  fontFamily: poppinSemiBold))
                          : Text('${widget.carRating}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: kWhite,
                                  fontFamily: poppinSemiBold)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: CachedNetworkImage(
                          imageUrl: "${widget.carMakesImage}",
                          height: 60,
                          width: 50,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                            strokeWidth: 2,
                            value: downloadProgress.progress,
                            color: borderColor,
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/icon/fade_in_image.jpeg"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: carLikeStatus == "like"
                            ? Image.asset("assets/home_page/heart.png")
                            : GestureDetector(
                                onTap: () async {
                                  myCurrentCarIndex = "${widget.carId}";
                                  print("evCarIds $myCurrentCarIndex");
                                  await getLikeUnlikeCarWidget();
                                  // carLikeStatus = carLikeUnlikeModelObject.message;
                                  print('carLikeStatus123 $carLikeStatus');
                                  if (carLikeUnlikeModelObject.message ==
                                      "Liked") {
                                    carLikeStatus = 'like';
                                  } else {
                                    carLikeStatus = 'dislike';
                                  }
                                },
                                child: carLikeStatus == "like"
                                    ? Image.asset("assets/home_page/heart.png")
                                    : Image.asset(
                                        "assets/car_bookings_images/heart.png"),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/car_description_images/circle.png',
                          fit: BoxFit.fill,
                          height: 200,
                          width: 300,
                        ),
                        Positioned(
                          left: 10,
                          right: 10,
                          bottom: 0,
                          child: widget.carImage!.endsWith('.jpg') ||
                                  widget.carImage!.endsWith('.png') ||
                                  widget.carImage!.endsWith('.jpeg')
                              ? Image.network("${widget.carImage}",
                                  fit: BoxFit.fill, height: 150, width: 180)
                              : Container(
                                  height: 235,
                                  child: ModelViewer(
                                    backgroundColor: Colors.transparent,
                                    src: '${widget.carImage}',
                                    alt: "A 3D model of car",
                                    animationName: 'walk',
                                    withCredentials: false,
                                    xrEnvironment: false,
                                    autoPlay: false,
                                    autoRotate: false,
                                    cameraControls: true,
                                    disableTap: false,
                                    ar: false,
                                    arModes: ["quicklook", "scene-viewer"],
                                    iosSrc: "${widget.carImage}",
                                    disableZoom: true,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
              child: SizedBox(
                width:  MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: getMileagePlansModel.data != null
                    ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getMileagePlansModel.data!.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedMileagePlan == getMileagePlansModel.data![index].plansMileageDescription;
                      var mileagePlan = getMileagePlansModel.data![index];
                      return GestureDetector(
                          onTap: () {
                            selectedMileagePlan = getMileagePlansModel.data?[index].plansMileageDescription;
                            mileagePlanID = getMileagePlansModel.data?[index].plansMileageId;
                            selectMileageIndex = getMileagePlansModel.data![index].plansMileageId!.toInt();
                            monthSelect();
                          },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              color: isSelected  ? borderColor : homeBgColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(mileagePlan.plansMileageDescription.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kBlack,
                                      fontSize: 14,
                                      fontFamily: poppinMedium
                                  )),
                            ),
                          ),
                        ),
                      );
                    }
                )
                    : SizedBox(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                child: tabsList(),
              ),
            ),
            TabbarCarDescription(
              myDescription: widget.myCarDescription,
              myRating: widget.myCarRating,
              myComment: widget.myCarComment,
              featureSuv: widget.featureSuv,
              featuresDoors: widget.featuresDoors,
              featuresSeats: widget.featuresSeats,
              featuresAutomatic: widget.featuresAutomatic,
              featuresSpeed: widget.featuresSpeed,
              featuresElectric: widget.featuresElectric,
              featuresEngine_capacity: widget.featuresEngine_capacity,
              featuresMeterReading: widget.featuresMeterReading,
              featuresNewCars: widget.featuresNewCars,
              featuresFuelCapacity: widget.featuresFuelCapacity,
            ),
            GestureDetector(
                onTap: () {
                  print('selectedIndex123: $selectMileageIndex');
                  print('selectedTabMonth123: $tabSelectMonth');
                  print('selectedTabMonthPrice123: $tabSelectedPrice');

                  print('carLikeStatus ${carLikeStatus}');
                  if (formKeyEvTabbar.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EvDescriptionDetailsPage(
                          getMileagePlansModel: getMileagePlansModel.data,
                          setupCost: getMonthPlansModel.data?[0].setupCost,
                          mileagePlanID: mileagePlanID == null
                              ? getMileagePlansModel
                              .data![0].plansMileageId
                              : mileagePlanID,
                          selectedMileagePlan: selectedMileagePlan == null
                              ? getMileagePlansModel
                                  .data![0].plansMileageDescription
                              : selectedMileagePlan,
                          mySelectedTabMonth: tabSelectMonth == null
                              ? getMonthPlansModel.data![0].months.toString()
                              : tabSelectMonth,
                          mySelectedTabPrice: tabSelectedPrice == null
                              ? getMonthPlansModel.data![0].pricePerMonth
                                  .toString()
                              : tabSelectedPrice,
                          favouriteStatus: carLikeStatus,
                          carName: widget.carName,
                          carImage: widget.carImage,
                          carYear: widget.carYear,
                          carPrice: widget.carPrice,
                          carDiscountPrice: widget.carDiscountPrice,
                          carRating: widget.carRating,
                          carColorName: widget.carColorName,
                          discountPercentage: widget.discountPercentage,
                          carStatus: widget.carStatus,
                          carId: widget.carId,
                          carOwnerId: widget.carOwnerId,
                          carMakesName: widget.carMakesName,
                          carModelName: widget.carModelName,
                        ),
                      ),
                    );
                  }
                },
                child: loginButton('Book Now', context)),
          ],
        ),
      ),
    );
  }

  final GlobalKey<FormState> formKeyEvTabbar = GlobalKey<FormState>();
  tabsList() {
    TabController? tabController = getMonthPlansModel.data != null
        ? TabController(length: getMonthPlansModel.data!.length, vsync: this)
        : null;
    return getMonthPlansModel.data != null
        ? loader2
            ? Center(child: CircularProgressIndicator(color: borderColor))
            : Form(
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                        child: TabBar(
                          controller: tabController,
                          indicator: BoxDecoration(
                            // color: selectedIndex == ? borderColor: kWhite,
                            color: borderColor,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          onTap: (index) {
                            selectMileageIndex = index;
                            tabSelectMonth = getMonthPlansModel
                                .data?[selectMileageIndex].months
                                .toString();
                            tabSelectedPrice = getMonthPlansModel
                                .data?[selectMileageIndex].pricePerMonth;
                            print('selectedIndex: $selectMileageIndex');
                            print('selectedTabMonth123: $tabSelectMonth');
                            print('selectedTabMonthPrice: $tabSelectedPrice');
                          },
                          tabs: List<Widget>.generate(
                              getMonthPlansModel.data!.length, (int index) {
                            var pricePerMonthString = getMonthPlansModel.data?[index].pricePerMonth;
                            double pricePerMonth;
                            if (pricePerMonthString != null) {
                              pricePerMonth = double.parse(pricePerMonthString);
                              if (pricePerMonth != null) {
                                final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                formattedPrice = numberFormat.format(pricePerMonth);
                                print("RM $formattedPrice");
                              } else {
                                print("Invalid price format");
                              }
                            } else {
                              print("Price not available");
                            }
                            print(
                                "monthsTabBarLength111 ${getMonthPlansModel.data?.length}");
                            // print("monthNumber111 ${getMonthPlansModel.data?[selectMileageIndex].months.toString()}");
                            return Container(
                              // color: Colors.transparent,
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: Tab(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getMonthPlansModel.data?[index].months
                                                  .toString() ==
                                              "1"
                                          ? Text(
                                              "${getMonthPlansModel.data?[index].months.toString()} month",
                                              style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 17,
                                                  fontFamily: poppinMedium))
                                          : Text(
                                              "${getMonthPlansModel.data?[index].months.toString()} months",
                                              style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 17,
                                                  fontFamily: poppinMedium)),
                                      Text(
                                          "RM ${formattedPrice}",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: poppinRegular,
                                            color: kBlack,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                          indicatorColor: kWhite,
                          isScrollable: true,
                          labelColor: kWhite,
                          labelStyle: TextStyle(
                              fontSize: 12, fontFamily: poppinRegular),
                          unselectedLabelColor: kBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              )
        : SizedBox();
  }

  //
  // final GlobalKey<FormState> formKeyEvTabbar = GlobalKey<FormState>();
  // tabsList(){
  //   TabController? tabController;
  //   if (getMonthPlansModel.data != null) {
  //     tabController = TabController(length: getMonthPlansModel.data!.length, vsync: this);
  //   }
  //   return Form(
  //     key: formKeyEvTabbar,
  //     child: Column(
  //       children: [
  //         Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: MediaQuery.of(context).size.height * 0.1,
  //             decoration: BoxDecoration(
  //                 color: homeBgColor,
  //                 borderRadius: BorderRadius.circular(15)),
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
  //               child: TabBar(
  //                 controller: tabController,
  //                 indicator: BoxDecoration(
  //                   // color: selectedIndex == ? borderColor: kWhite,
  //                   color: borderColor,
  //                   borderRadius: BorderRadius.circular(15.0),
  //                 ),
  //                 // onTap: (index){
  //                 //   selectedIndex = index;
  //                 //   tabSelectMonth = monthNumber[selectedIndex].months;
  //                 //   tabSelectedPrice = monthNumber[selectedIndex].dis_price_per_months;
  //                 //   print('selectedIndex: $selectedIndex');
  //                 //   print('selectedTabMonth123: $tabSelectMonth');
  //                 //   print('selectedTabMonthPrice: $tabSelectedPrice');
  //                 // },
  //                 tabs: List<Widget>.generate(
  //                     getMonthPlansModel.data!.length, (int index) {
  //
  //                   // String price123 = ('${monthNumber[index].months}') * int.parse('${monthNumber[index].dis_price_per_months}');
  //                   // print("price123 ${price123}");
  //                   // print("monthsTabBarLength111 ${monthNumber.length}");
  //                   // print("monthNumber111 ${monthNumber[index].months}");
  //                   // selectedIndex = index;
  //                   // tabSelectMonth = monthNumber[index].months;
  //                   // tabSelectedPrice = monthNumber[index].dis_price_per_months;
  //                   // print("tabSelectMonthAndPrice $tabSelectMonth $tabSelectedPrice");
  //                   return Container(
  //                     color: Colors.transparent,
  //                     height: MediaQuery.of(context).size.height * 0.1,
  //                     child: Tab(
  //                       child: SizedBox(
  //                         width: MediaQuery.of(context).size.width * 0.3,
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text("${getMonthPlansModel.data?[index].months} month", style: TextStyle(
  //                                 color: kBlack, fontSize: 17, fontFamily: poppinMedium)),
  //                             // Text("${monthNumber[index].months} months", style: TextStyle(
  //                             //     color: kBlack, fontSize: 17, fontFamily: poppinMedium)),
  //
  //                             Text("RM ${getMonthPlansModel.data?[index].pricePerMonth}",
  //                                 textAlign: TextAlign.right, style: TextStyle(
  //                                   fontSize: 14, fontFamily: poppinRegular, color: kBlack,)),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //                 indicatorColor: kWhite,
  //                 isScrollable: true,
  //                 labelColor: kWhite,
  //                 labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
  //                 unselectedLabelColor: kBlack,
  //               ),
  //             )),
  //
  //       ],
  //     ),
  //   );
  // }

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

  final GlobalKey<FormState> formKeyEvMileagePlans = GlobalKey<FormState>();
  GetMileagePlansModel getMileagePlansModel = GetMileagePlansModel();

  mileagePlansListWidget() async {
    loadingP = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    try {
      String apiUrl = getMileagePlansApiUrl;
      print("getMileagePlansApiUrl: $apiUrl");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {"users_customers_id": userId},
        headers: {'Accept': 'application/json'},
      );
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getMileagePlansResponse: ${responseString.toString()}");
        getMileagePlansModel = getMileagePlansModelFromJson(responseString);
        selectedMileagePlan = getMileagePlansModel.data![0].plansMileageDescription;
        print("getMileagePlansLength: ${getMileagePlansModel.data!.length}");
        monthSelect();
      }
    } catch (e) {
      print('Error in getMileagePlans: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  int selectMileageIndex = 1;
  bool selectedPlan = false;
  GetMonthPlansModel getMonthPlansModel = GetMonthPlansModel();

  bool loader2 = false;
  String formattedPrice = "";
  monthSelect() async {
    try {
      String apiUrl = getCarPlansEvApiUrl;
      print("carID ${widget.carId}");
      print("selectMileageIndex $selectMileageIndex");
      print("getCarPlansEvApiUrl: $apiUrl");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "cars_id": widget.carId.toString(),
          "plans_mileage_id": selectMileageIndex.toString(),
        },
        headers: {'Accept': 'application/json'},
      );
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getMonthPlansEvResponse: ${responseString.toString()}");
        getMonthPlansModel = getMonthPlansModelFromJson(responseString);
        print("Length: ${getMonthPlansModel.data!.length}");
        setState(() {});
      }
    } catch (e) {
      print('Error in getMonthPlans: ${e.toString()}');
    }
  }

  mileagePlansList() {
    TabController? tabController = getMileagePlansModel.data != null
        ? TabController(length: getMileagePlansModel.data!.length, vsync: this)
        : null;
    return loadingP
        ? Center(child: CircularProgressIndicator(color: borderColor))
        : Form(
            key: formKeyEvMileagePlans,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: homeBgColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onTap: (index) {
                    selectedMileagePlan = getMileagePlansModel.data?[index].plansMileageDescription;
                    selectMileageIndex = getMileagePlansModel.data![index].plansMileageId!.toInt();
                    monthSelect();
                  },
                  tabs: List<Widget>.generate(getMileagePlansModel.data!.length,
                      (int index) {
                    return Tab(
                      child: Text(
                          "${getMileagePlansModel.data?[index].plansMileageDescription}",
                          maxLines: 2,
                          style: TextStyle(
                              color: kBlack,
                              fontSize: 17,
                              fontFamily: poppinRegular)),
                    );
                  }),
                  isScrollable: true,
                ),
              ),
            ),
          );
  }
}
