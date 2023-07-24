import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'book_for_wedding_car_description.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Model/get_car_makes_model.dart';
import 'package:auto_haus_rental_app/Model/Notification/notifications_unread_model.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/FavoritesModel/like_unlike_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Drawer/Settings/settings_screen.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/HomeTopWidgetModels/photography_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Notifications/notification_screen.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/EvSubscriptions/ev_subscription_page.dart';

class BookForWeddingPage extends StatefulWidget {
  BookForWeddingPage({Key? key}) : super(key: key);

  @override
  State<BookForWeddingPage> createState() => _BookForWeddingPageState();
}

class _BookForWeddingPageState extends State<BookForWeddingPage>
    with TickerProviderStateMixin {
  PhotoGraphyModel carsPhotoGraphyModelObject = PhotoGraphyModel();
  LikeUnlikeCarModel carLikeUnlikeModelObject = LikeUnlikeCarModel();
  SearchModel searchModelObject = SearchModel();
  var searchController = TextEditingController();
  String? myCurrentCarIndex;
  int? selectedCarMakesId, photoCarMakesId;
  String? selectedCarMakesName;
  bool loadingP = true;

  @override
  void initState() {
    super.initState();
    sharedPrefs();
    selectedIndex = 0;
  }

  sharedPrefs() async {
    loadingP = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print("userId in favoriteCar Prefs is = $userId");
    notificationStatus = (prefs!.getString('notification_status'));
    print("notificationStatus in sharedPrefs $notificationStatus");
    setState(() {
      getCarMakesListWidget();
    });
  }

  getCarsPhotoGraphyWidget() async {
    // loadingP = true;
    // setState(() {});
    // try {
    selectedCarMakesId ?? (selectedCarMakesId = 1);
    String apiUrl = carsPhotoGraphyApiUrl;
    print("carsPhotographyApi: $apiUrl");
    print("userId: $userId");
    print("carsMakesId: $selectedCarMakesId");
    final response = await http.post(Uri.parse(apiUrl), body: {
      "users_customers_id": userId,
      "cars_makes_id": "$selectedCarMakesId"
    }, headers: {
      'Accept': 'application/json'
    });
    print('statusCode ${response.statusCode}');
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("carsPhotoGraphyResponse: ${responseString.toString()}");
      loadingP = false;
      setState(() {});
      carsPhotoGraphyModelObject = photoGraphyModelFromJson(responseString);
      print(
          "carsPhotoGraphyObjectLength: ${carsPhotoGraphyModelObject.data?.length}");
    }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    // loadingP = false;
    // setState(() {});
  }

  getLikeUnlikeCarWidget() async {
    loadingP = true;
    setState(() {});
    try {
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
    } catch (e) {
      print('Error in carLikeUnlike: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  GetCarMakesModel getCarMakesModelObject = GetCarMakesModel();
  NotificationsUnReadModel notificationsUnReadModelObject =
      NotificationsUnReadModel();

  getUnreadNotificationWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in HomePagePrefs is= $userId");
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = unReadNotificationsApiUrl;
      print("gunReadNotificationsApi: $apiUrl");
      print("getUserId: $userId");
      final response = await http.post(Uri.parse(apiUrl), body: {
        "users_customers_id": userId,
      }, headers: {
        'Accept': 'application/json'
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getUserProfileResponseHomePage: ${responseString.toString()}");
        notificationsUnReadModelObject =
            notificationsUnReadModelFromJson(responseString);
        print(
            "unReadNotificationsLength: ${notificationsUnReadModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in gunReadNotification: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  getCarMakesListWidget() async {
    loadingP = true;
    setState(() {});
    print('in getCarMakesAPI');
    try {
      String apiUrl = getCarMakesApiUrl;
      print("getCarMakesApi: $apiUrl");
      final response = await http.get(Uri.parse(apiUrl));
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getCarMakesResponse: ${responseString.toString()}");
        getCarMakesModelObject = getCarMakesModelFromJson(responseString);
        print("getCarMakesName: ${getCarMakesModelObject.data![0].name}");
        print("getCarMakesId: ${getCarMakesModelObject.data![0].carsMakesId}");
        print("getCarMakesLength: ${getCarMakesModelObject.data!.length}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {
      getCarsPhotoGraphyWidget();
      getUnreadNotificationWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness:
              Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.dark, //<-- For iOS SEE HERE (dark icons)
        ),
        actions: [
          notificationStatus == "Yes"
              ? GestureDetector(
                  onTap: () {
                    print("clicked");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsScreen()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, right: 20),
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                            "assets/home_page/notification_bell.svg"),
                        Positioned(
                          right: 02,
                          left: 05,
                          bottom: 13,
                          child: notificationsUnReadModelObject.data?.length ==
                                  0
                              ? Container()
                              : Container(
                                  height: 12,
                                  width: 12,
                                  decoration: BoxDecoration(
                                      color: kRed,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      "${notificationsUnReadModelObject.data?.length}",
                                      style: TextStyle(
                                          color: kWhite, fontSize: 08),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Image.asset("assets/home_page/back_arrow.png",
                height: 25, width: 25),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text("Book for Wedding",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontFamily: poppinBold, color: kBlack)),
        ),
        backgroundColor: homeBgColor,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: loadingP
          ? Center(child: CircularProgressIndicator(color: borderColor))
          : SingleChildScrollView(
              child: Column(
                children: [
                  carMakersListWidget(),
                  photographyCarsListWidget(searchController.text),
                ],
              ),
            ),
    );
  }

  carMakersListWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 08),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        color: Colors.transparent,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: getCarMakesModelObject.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;

                      selectedCarMakesId = getCarMakesModelObject
                          .data![selectedIndex].carsMakesId;
                      selectedCarMakesName =
                          getCarMakesModelObject.data![selectedIndex].name;
                      print("myIndex $index");
                      print("selectedIndex $selectedIndex");
                      print("selectedCarMakesName $selectedCarMakesName");
                      print("selectedCarMakesId $selectedCarMakesId");
                      getCarsPhotoGraphyWidget();
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                        color: selectedIndex == index ? borderColor : kWhite,
                        border: Border.all(
                            width: 2,
                            color:
                                selectedIndex == index ? borderColor : kWhite),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.network(
                        "$baseUrlImage${getCarMakesModelObject.data![index].image}",
                        height: 25,
                        width: 25,
                        fit: BoxFit.fill),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget photographyCarsListWidget(String search) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.70,
        child: loadingP
            ? Center(child: CircularProgressIndicator(color: borderColor))
            : carsPhotoGraphyModelObject.status != "success"
                ? Center(
                    child: Text('No cars Available',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: carsPhotoGraphyModelObject.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.33),
                          ),
                          Positioned(
                            top: 90,
                            child: Padding(
                              padding: EdgeInsets.only(left: 9),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.26,
                                width: 343,
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 5,
                                      offset: Offset(3, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1),
                                    Row(
                                      children: [
                                        SizedBox(height: 93.6),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "${carsPhotoGraphyModelObject.data?[index].vehicalName} ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kBlack,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              poppinBold)),
                                                  Text(
                                                      "${carsPhotoGraphyModelObject.data?[index].carsColors!.name} ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kBlack,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              poppinRegular)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "${carsPhotoGraphyModelObject.data![index].carsMakes!.name}, ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kBlack,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              poppinRegular)),
                                                  Text(
                                                      "${carsPhotoGraphyModelObject.data![index].carsModels!.name}, ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kBlack,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              poppinSemiBold)),
                                                  Text(
                                                      "${carsPhotoGraphyModelObject.data![index].year} ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kBlack,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              poppinRegular)),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.005),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 04),
                                                    child: Text("RM",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: kRed,
                                                            fontSize: 5,
                                                            fontFamily:
                                                                poppinRegular)),
                                                  ),
                                                  Text(
                                                      "${carsPhotoGraphyModelObject.data![index].carsPlans![0].pricePerHour}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kRed,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationColor: kRed,
                                                          decorationThickness:
                                                              3,
                                                          fontSize: 10,
                                                          fontFamily:
                                                              poppinLight,
                                                          height: 2)),
                                                  SizedBox(width: 5),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 06),
                                                    child: Text("RM",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: borderColor,
                                                            fontSize: 7,
                                                            fontFamily:
                                                                poppinSemiBold)),
                                                  ),
                                                  Text(
                                                      "${carsPhotoGraphyModelObject.data![index].carsPlans![0].discountedPricePerHour}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: borderColor,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              poppinSemiBold)),
                                                  Text("/Hour",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kBlack,
                                                          fontSize: 8,
                                                          fontFamily:
                                                              poppinRegular)),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                  showRatingStars(double.parse(
                                                      "${carsPhotoGraphyModelObject.data![index].rating}")),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                  carsPhotoGraphyModelObject
                                                              .data![index]
                                                              .rating ==
                                                          null
                                                      ? Text("0.0",
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  poppinMedium))
                                                      : Text(
                                                          "${carsPhotoGraphyModelObject.data![index].rating}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  poppinRegular)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 30,
                            bottom: 35,
                            child: GestureDetector(
                              onTap: () {
                                carID = carsPhotoGraphyModelObject
                                    .data![index].carsId;
                                print("myCarId $carID");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BookForWeddingCarDescription(
                                              carName:
                                                  carsPhotoGraphyModelObject
                                                      .data![index].vehicalName,
                                              carYear:
                                                  "${carsPhotoGraphyModelObject.data![index].year}",
                                              carId: carsPhotoGraphyModelObject
                                                  .data![index].carsId,
                                              carRating:
                                                  carsPhotoGraphyModelObject
                                                      .data![index].rating,
                                              carColorName:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .carsColors!
                                                      .name,
                                              carMakesName:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .carsMakes!
                                                      .name,
                                              carModelName:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .carsModels!
                                                      .name,
                                              carImage:
                                                  "$baseUrlImage${carsPhotoGraphyModelObject.data![index].image1}",
                                              carMakesImage:
                                                  "$baseUrlImage${carsPhotoGraphyModelObject.data![index].carsMakes!.image}",
                                              favouriteStatus:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .favouriteStatus,
                                              discountPercentage:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .discountPercentage,
                                              carDiscountPrice:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .carsPlans![0]
                                                      .discountedPricePerHour,
                                              carPrice:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .carsPlans![0]
                                                      .pricePerHour,
                                              carOwnerImage:
                                                  "$baseUrlImage${carsPhotoGraphyModelObject.data![index].usersCompanies!.companyLogo}",
                                              carOwnerName:
                                                  "${carsPhotoGraphyModelObject.data![index].usersCompanies!.companyName}",
                                              carOwnerId:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .usersCompanies!
                                                      .usersCompaniesId,
                                              myCarDescription:
                                                  carsPhotoGraphyModelObject
                                                      .data![index].description,
                                              featureSuv:
                                                  carsPhotoGraphyModelObject
                                                      .data![index].featuresSuv,
                                              featuresDoors:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresDoors,
                                              featuresSeats:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresSeats,
                                              featuresAutomatic:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresAutomatic,
                                              featuresSpeed:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresSpeed,
                                              featuresElectric:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresElectric,
                                              featuresEngine_capacity:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresEngineCapacity,
                                              featuresFuelCapacity:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresFuelCapacity,
                                              featuresMeterReading:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresMeterReading,
                                              featuresNewCars:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .featuresNewCars,
                                              packageType:
                                                  carsPhotoGraphyModelObject
                                                      .data![index]
                                                      .carsPlans![0]
                                                      .packageType,
                                            )));
                                print(
                                    "evCarName ${carsPhotoGraphyModelObject.data![index].vehicalName}");
                                print(
                                    "evCarYear ${carsPhotoGraphyModelObject.data![index].year}");
                                print(
                                    "evCarPerHours ${carsPhotoGraphyModelObject.data![index].carsPlans![0].pricePerHour}");
                                print(
                                    "evCarImage $baseUrlImage${carsPhotoGraphyModelObject.data![index].image1}");
                                print(
                                    "evCarId ${carsPhotoGraphyModelObject.data![index].carsId}");
                              },
                              child: Image.asset(
                                  "assets/car_bookings_images/more_button.png"),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            right: 10,
                            child: carsPhotoGraphyModelObject
                                        .data![index].image1 ==
                                    null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                        'assets/icon/fade_in_image.jpeg'))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          "assets/icon/fade_in_image.jpeg"),
                                      // width: 300,
                                      height: 135,
                                      image: NetworkImage(
                                          "$baseUrlImage${carsPhotoGraphyModelObject.data![index].image1}"),
                                    ),
                                  ),
                          ),
                          Positioned(
                              top: 10,
                              left: 15,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.07,
                                width: MediaQuery.of(context).size.width * 0.16,
                                decoration: BoxDecoration(
                                  color: kRed.withOpacity(0.8),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "${carsPhotoGraphyModelObject.data![index].discountPercentage}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: kWhite,
                                            fontSize: 13,
                                            fontFamily: poppinSemiBold)),
                                    Text(" OFF ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: kWhite,
                                            fontSize: 8,
                                            fontFamily: poppinRegular)),
                                  ],
                                ),
                              )),
                          Positioned(
                            top: 10,
                            right: 15,
                            child: carsPhotoGraphyModelObject
                                        .data![index].favouriteStatus ==
                                    "like"
                                ? Image.asset("assets/home_page/heart.png")
                                : GestureDetector(
                                    onTap: () async {
                                      myCurrentCarIndex =
                                          "${carsPhotoGraphyModelObject.data![index].carsId}";
                                      print(
                                          "carsPhotoGraphyIds $myCurrentCarIndex");
                                      await getLikeUnlikeCarWidget();
                                      await getCarsPhotoGraphyWidget();
                                    },
                                    child: Image.asset(
                                        "assets/car_bookings_images/heart.png"),
                                  ),
                          ),
                        ],
                      );
                    }),
      ),
    );
  }
}
