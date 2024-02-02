import 'package:auto_haus_rental_app/Model/HomePageModels/FavoritesModel/like_unlike_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/EvSubscriptions/ev_car_description.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/HomePageModels/FavoritesModel/favorite_cars_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Model/Notification/notifications_unread_model.dart';
import '../HomePage/Drawer/Settings/settings_screen.dart';
import '../HomePage/Drawer/drawer_screen.dart';
import '../HomePage/Notifications/notification_screen.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  NotificationsUnReadModel notificationsUnReadModelObject = NotificationsUnReadModel();
  LikeUnlikeCarModel carLikeUnlikeModelObject = LikeUnlikeCarModel();
  FavoriteCarModel favoriteCarModelObject = FavoriteCarModel();
  String? myCarsIndexId;
  bool loadingP = true;

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
      getUnreadNotificationWidget();
      getFavoriteCarWidget();

    });
  }

  getFavoriteCarWidget() async {
    loadingP = true;
    setState(() {});
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in favoriteCarModelObjectCarApi');
    // try {
      String apiUrl = favoriteCarsApiUrl;
      print("favoriteCarModelObjectCarModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
          headers: {
        'Accept': 'application/json'
          },
          body: {
        "users_customers_id": userId
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseFavoriteCarModelObject: ${responseString.toString()}");
        favoriteCarModelObject = favoriteCarModelFromJson(responseString);
        loadingP = false;
        setState(() {});
        print("favoriteCarModelObjectLength: ${favoriteCarModelObject.data?.length}");
      }
    // } catch (e) {
    //   print('Error in favoriteCarModelObject: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  getLikeUnlikeCarWidget() async {
    loadingP = true;
    setState(() {});
    // try {
      String apiUrl = likeUnlikeFavoriteCarsApiUrl;
      print("carLikeUnlikeModelApi: $apiUrl");
      print("carUserId: $userId");
      print("carsId: $carID");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "users_customers_id": userId,
          "cars_id": "$carID",
        },
        headers: {
          'Accept': 'application/json'
        },
      );
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("carLikeUnlikeModelResponse: ${responseString.toString()}");
        carLikeUnlikeModelObject = likeUnlikeCarModelFromJson(responseString);
        print("carLikeUnlikeModelMessage: ${carLikeUnlikeModelObject.message}");
        setState(() {});
      }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

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
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId,
          },
          headers: {
            'Accept': 'application/json'
          });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("getUserProfileResponseHomePage: ${responseString.toString()}");
        notificationsUnReadModelObject = notificationsUnReadModelFromJson(responseString);
        print("unReadNotificationsLength: ${notificationsUnReadModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in gunReadNotification: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.04),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    print("clicked");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  DrawerScreen()));
                  },
                  child: Image.asset("assets/home_page/Side_Menu.png",
                    height: 25,
                    width: 25,
                  ),
                ),
                Text(
                  "Favorite",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, fontFamily: poppinBold, color: kBlack),
                ),

                notificationStatus == "Yes"?
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => NotificationsScreen()));
                  },
                  child: Stack(
                    children: [
                      SvgPicture.asset("assets/home_page/notification_bell.svg"),
                      Positioned(
                        right: 02,
                        left: 05,
                        bottom: 10,
                        child:  notificationsUnReadModelObject.data == null ? Container():
                        Container(
                            height: 12, width: 12,
                            decoration: BoxDecoration(
                                color: kRed,
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(
                              child: Text("${notificationsUnReadModelObject.data?.length}",
                                style: TextStyle(color: kWhite, fontSize: 08),),
                            )),
                      ),
                    ],
                  ),
                ) : Container(),
              ],
            ),
          ),
          loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
          allFavItem(),
        ],
      ),
    );
  }

  Widget allFavItem() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return   LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 600) {
          return   Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              color: Colors.transparent,
              height: screenHeight * 0.75,
              child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
              favoriteCarModelObject.message == "no data found." ?
              Center(child: Text('No Cars Found In Favorite.', style: TextStyle(fontWeight: FontWeight.bold))) :
              favoriteCarModelObject.data == null? Center(child: Text('No Cars Found In Favorite.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))):
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: favoriteCarModelObject.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    carID = favoriteCarModelObject.data![index].carsId;
                    String priceString = favoriteCarModelObject.data![index].carsPlans![0].discountedPricePerMonth.toString();
                    double price = double.parse(priceString);
                    NumberFormat format = NumberFormat('#,##0.00', 'en_US');
                    String formattedPrice = format.format(price);
                    return GestureDetector(
                      onTap: () {
                        carID = favoriteCarModelObject.data?[index].carsId;
                        if (favoriteCarModelObject.data?[index].carsUsageType == "EV Subscriptions") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EVCarDescription(
                                carName: favoriteCarModelObject.data?[index].vehicalName,
                                carPrice: formattedPrice,
                                carImageModel: favoriteCarModelObject.data?[index].objectImage,
                                carImage: favoriteCarModelObject
                                    .data![index].image1!
                                    .endsWith('.jpg') ||
                                    favoriteCarModelObject
                                        .data![index].image1!
                                        .endsWith('.png') ||
                                    favoriteCarModelObject
                                        .data![index].image1!
                                        .endsWith('.jpeg')
                                    ? "$baseUrlImage${favoriteCarModelObject.data?[index].image1}"
                                    : favoriteCarModelObject
                                    .data?[index].image1,
                                carYear:
                                "${favoriteCarModelObject.data![index].year}",
                                carId: favoriteCarModelObject
                                    .data![index].carsId,
                                carRating: favoriteCarModelObject
                                    .data![index].rating,
                                carColorName: favoriteCarModelObject
                                    .data![index].carsColors!.name,
                                carMakesName: favoriteCarModelObject
                                    .data![index].carsMakes!.name,
                                carModelName: favoriteCarModelObject
                                    .data![index].carsModels!.name,
                                carMakesImage:
                                "$baseUrlImage${favoriteCarModelObject.data![index].carsMakes!.image}",
                                discountPercentage:
                                favoriteCarModelObject
                                    .data![index]
                                    .discountPercentage,
                                carDiscountPrice: formattedPrice,
                                carOwnerImage:
                                "$baseUrlImage${favoriteCarModelObject.data![index].usersCompanies!.companyLogo}",
                                carOwnerName:
                                "${favoriteCarModelObject.data![index].usersCompanies!.companyName}",
                                carOwnerId: favoriteCarModelObject
                                    .data![index]
                                    .usersCompanies!
                                    .usersCompaniesId,
                                myCarDescription:
                                favoriteCarModelObject
                                    .data![index].description,
                                favouriteStatus:
                                favoriteCarModelObject
                                    .data![index].favouriteStatus,
                                featureSuv: favoriteCarModelObject
                                    .data![index].featuresSuv,
                                featuresDoors:
                                favoriteCarModelObject
                                    .data![index].featuresDoors,
                                featuresSeats:
                                favoriteCarModelObject
                                    .data![index].featuresSeats,
                                featuresAutomatic:
                                favoriteCarModelObject
                                    .data![index]
                                    .featuresAutomatic,
                                featuresSpeed:
                                favoriteCarModelObject
                                    .data![index].featuresSpeed,
                                featuresElectric:
                                favoriteCarModelObject
                                    .data![index]
                                    .featuresElectric,
                                featuresEngine_capacity:
                                favoriteCarModelObject
                                    .data![index]
                                    .featuresEngineCapacity,
                                featuresFuelCapacity:
                                favoriteCarModelObject
                                    .data![index]
                                    .featuresFuelCapacity,
                                featuresMeterReading:
                                favoriteCarModelObject
                                    .data![index]
                                    .featuresMeterReading,
                                featuresNewCars:
                                favoriteCarModelObject
                                    .data![index].featuresNewCars,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: Get.height * 0.18,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: Get.width * 0.9,
                                height: Get.height * 0.15,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: kWhite,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(3, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 18.0, top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${favoriteCarModelObject.data?[index].vehicalName}",
                                              style: TextStyle(
                                                color: kBlack,
                                                fontSize: 14,
                                                fontFamily: poppinBold,
                                              ),
                                            ),
                                            Text(
                                              "${favoriteCarModelObject.data?[index].year}",
                                              style: TextStyle(
                                                color: textLabelColor,
                                                fontSize: 14,
                                                fontFamily: poppinSemiBold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40,
                              bottom: 20,
                              child: Row(
                                children: [
                                  Text(
                                    "RM ",
                                    style: TextStyle(
                                      color: kBlack,
                                      fontSize: 14,
                                      fontFamily: poppinSemiBold,
                                    ),
                                  ),
                                  Text(
                                    "${formattedPrice}",
                                    style: TextStyle(
                                      color: kBlack,
                                      fontSize: 14,
                                      fontFamily: poppinSemiBold,
                                    ),
                                  ),
                                  Text(
                                    "/Month",
                                    style: TextStyle(
                                      color: textLabelColor,
                                      fontSize: 14,
                                      fontFamily: poppinSemiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 50,
                              bottom: 20,
                              child: GestureDetector(
                                            onTap: () async {
                                              carID = favoriteCarModelObject.data![index].carsId;
                                              print("selectedCarId $carID");
                                              await getLikeUnlikeCarWidget();
                                              getFavoriteCarWidget();
                                            },
                                            child: Image.asset("assets/home_page/heart.png", width: 50, height: 50,),),
                            ),
                            Positioned(
                              left: 30,
                              top: -45,
                              child: SizedBox(
                                width: 180,
                                height: 180,
                                child: Image.network(
                                  '$baseUrlImage${favoriteCarModelObject.data?[index].image1}',
                                  errorBuilder: (BuildContext context, Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      child: Image.asset(
                                          'assets/icon/fade_in_image.jpeg'),
                                    );
                                  },
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: borderColor,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // favoriteCarModelObject
                              //     .data?[index].image1 ==
                              //     null
                              //     ? Padding(
                              //   padding: const EdgeInsets.only(top: 80.0),
                              //   child: Image.asset(
                              //     'assets/icon/fade_in_image.jpeg',
                              //     width: 50,
                              //     height: 50,
                              //   ),
                              // )
                              //     : FadeInImage(
                              //   placeholder: AssetImage(
                              //     "assets/icon/fade_in_image.jpeg",
                              //   ),
                              //   width: 180,
                              //   height: 180,
                              //   image: NetworkImage(
                              //     "$baseUrlImage${favoriteCarModelObject.data?[index].image1}",
                              //   ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    );
                    //   Stack(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 20),
                    //       child: Container(
                    //         height: screenHeight * 0.25,
                    //       ),
                    //     ),
                    //     Positioned(
                    //       top: 90,
                    //       left: 30,
                    //       right: 30,
                    //       child: Padding(
                    //         padding: EdgeInsets.only(left: 9),
                    //         child: Container(
                    //           height: screenHeight * 0.19,
                    //           // width: 343,
                    //           width: screenWidth,
                    //           decoration: BoxDecoration(
                    //             color: kWhite,
                    //             borderRadius: BorderRadius.circular(20),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.grey.withOpacity(0.1),
                    //                 spreadRadius: 5,
                    //                 blurRadius: 5,
                    //                 offset: Offset(3, 3),
                    //               ),
                    //             ],
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Container(height: screenHeight * 0.06),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(height: 93.6),
                    //                   Padding(
                    //                     padding: EdgeInsets.symmetric(horizontal: 15),
                    //                     child: Column(
                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                    //                       children: [
                    //                         Row(
                    //                           children: [
                    //                             Text("${favoriteCarModelObject.data![index].vehicalName} | ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                    //
                    //                             Text("${favoriteCarModelObject.data![index].carsColors!.name} ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                    //                           ],
                    //                         ),
                    //                         SizedBox(height: screenHeight * 0.005),
                    //                         Row(
                    //                           children: [
                    //                             Text("${favoriteCarModelObject.data![index].carsModels!.name} ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                    //
                    //                             Text("${favoriteCarModelObject.data![index].carsMakes!.name} ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 10, fontFamily: poppinMedium)),
                    //                             Text("${favoriteCarModelObject.data![index].year}",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                    //                           ],
                    //                         ),
                    //                         SizedBox(height: screenHeight * 0.005),
                    //                         Row(
                    //                           children: [
                    //                             favoriteCarModelObject.data![index].discountPercentage != "0.00" ? Padding(
                    //                               padding: EdgeInsets.only(top: 04),
                    //                               child: Text("RM",  textAlign: TextAlign.left, style: TextStyle(
                    //                                   color: kRed, fontSize: 5, fontFamily: poppinRegular)),
                    //                             ) : SizedBox(),
                    //                             favoriteCarModelObject.data![index].carsUsageType == "EV Subscriptions"?
                    //                             favoriteCarModelObject.data![index].discountPercentage != "0.00" ? originalPriceText("${favoriteCarModelObject.data![index].carsPlans![0].pricePerMonth}"): SizedBox() : SizedBox(),
                    //                             // favoriteCarModelObject.data![index].carsUsageType == "EV Subscriptions"?
                    //                             // originalPriceText("${favoriteCarModelObject.data![index].carsPlans![0].pricePerMonth}"):
                    //                             // favoriteCarModelObject.data![index].carsUsageType == "Photography"?
                    //                             // originalPriceText("${favoriteCarModelObject.data![index].carsPlans![0].pricePerHour}"):
                    //                             // originalPriceText("${favoriteCarModelObject.data![index].carsPlans![0].pricePerSlot}"),
                    //                             SizedBox(width: 5),
                    //                             Padding(
                    //                               padding: EdgeInsets.only(top: 06),
                    //                               child: Text("RM",  textAlign: TextAlign.left,
                    //                                   style: TextStyle(color: borderColor,
                    //                                       fontSize: 7, fontFamily: poppinSemiBold)),
                    //                             ),
                    //
                    //                             favoriteCarModelObject.data![index].carsUsageType == "EV Subscriptions"?
                    //                             discountedPriceText("${formattedPrice }/", ""):
                    //                             favoriteCarModelObject.data![index].carsUsageType == "Photography"?
                    //                             discountedPriceText("${favoriteCarModelObject.data![index].carsPlans![0].discountedPricePerHour}/", "Hour"):
                    //                             discountedPriceText("${favoriteCarModelObject.data![index].carsPlans![0].discountedPricePerSlot}/", "Slot"),
                    //
                    //                             SizedBox(width: screenWidth * 0.01),
                    //                             // showRatingStars(double.parse("${favoriteCarModelObject.data![index].rating}")),
                    //                             // SizedBox(width: screenWidth * 0.01),
                    //                             // Text("${favoriteCarModelObject.data![index].rating}",
                    //                             //     textAlign: TextAlign.left, style: TextStyle(
                    //                             //         color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                    //                           ],
                    //                         ),
                    //
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       left: 30, right: 30, top: 0,
                    //       child: favoriteCarModelObject.data![index].image1 == null
                    //           ? ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: Image.asset('assets/icon/fade_in_image.jpeg'),
                    //       )
                    //           : favoriteCarModelObject.data![index].image1!.endsWith('.jpg') || favoriteCarModelObject.data![index].image1!.endsWith('.png') || favoriteCarModelObject.data![index].image1!.endsWith('.jpeg')
                    //           ? ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: FadeInImage(
                    //           placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                    //           height: 65,
                    //           image: NetworkImage("$baseUrlImage${favoriteCarModelObject.data![index].image1}"),
                    //         ),
                    //       )
                    //           : Container(
                    //         height: MediaQuery.of(context).size.height * 0.24,
                    //         child: ModelViewer(
                    //           backgroundColor: Colors.transparent,
                    //           src: '${favoriteCarModelObject.data![index].image1}',
                    //           alt: "A 3D model of car",
                    //           autoPlay: false,
                    //           autoRotate: false,
                    //           cameraControls: false,
                    //           disableTap: false,
                    //           ar: false,
                    //           disablePan: true,
                    //           arModes: ["quicklook", "scene-viewer"],
                    //           iosSrc: "${favoriteCarModelObject.data![index].image1}",
                    //           disableZoom: true,
                    //         ),
                    //       ),
                    //     ),
                    //     favoriteCarModelObject.data![index].discountPercentage != "0.00"
                    //     ? Positioned(
                    //         top: 10, left: 15,
                    //         child: Container(
                    //           height: MediaQuery.of(context).size.width * 0.07,
                    //           width: MediaQuery.of(context).size.width * 0.16,
                    //           decoration: BoxDecoration(
                    //             color: kRed.withOpacity(0.8),
                    //             borderRadius: BorderRadius.only(
                    //                 topRight: Radius.circular(15),
                    //                 bottomLeft: Radius.circular(15)),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text("${favoriteCarModelObject.data![index].discountPercentage} %",
                    //                   textAlign: TextAlign.left, style: TextStyle(
                    //                       color: kWhite, fontSize: 10, fontFamily: poppinSemiBold)),
                    //               Text(" OFF ",  textAlign: TextAlign.left, style: TextStyle(
                    //                   color: kWhite, fontSize: 8, fontFamily: poppinSemiBold)),
                    //             ],
                    //           ),
                    //         ))
                    //     : Positioned(top: 10, left: 15, child: SizedBox()),
                    //     Positioned(
                    //         top: 10, right: 15,
                    //         child: GestureDetector(
                    //             onTap: () async {
                    //               carID = favoriteCarModelObject.data![index].carsId;
                    //               print("selectedCarId $carID");
                    //               await getLikeUnlikeCarWidget();
                    //               getFavoriteCarWidget();
                    //             },
                    //             child: Image.asset("assets/home_page/heart.png"))),
                    //   ],
                    // );
                  }),
            ),
          );
        } else {
          return  Padding(
            padding: EdgeInsets.only(top: 15),
            child: Container(
              color: Colors.transparent,
              height: screenHeight * 0.78,
              child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
              favoriteCarModelObject.message == "no data found." ?
              Center(child: Text('No Cars Found In Favorite.', style: TextStyle(fontWeight: FontWeight.bold))) :
              favoriteCarModelObject.data == null? Center(child: Text('No Cars Found In Favorite.',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))):
              ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: favoriteCarModelObject.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    carID = favoriteCarModelObject.data![index].carsId;
                    String priceString = favoriteCarModelObject.data![index].carsPlans![0].discountedPricePerMonth.toString();
                    double price = double.parse(priceString);
                    NumberFormat format = NumberFormat('#,##0.00', 'en_US');
                    String formattedPrice = format.format(price);
                    return Container(
                      height: Get.height * 0.18,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: Get.width * 0.9,
                              height: Get.height * 0.15,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 18.0, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${favoriteCarModelObject.data?[index].vehicalName}",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: poppinBold,
                                            ),
                                          ),
                                          Text(
                                            "${favoriteCarModelObject.data?[index].year}",
                                            style: TextStyle(
                                              color: textLabelColor,
                                              fontSize: 14,
                                              fontFamily: poppinSemiBold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 40,
                            bottom: 20,
                            child: Row(
                              children: [
                                Text(
                                  "RM",
                                  style: TextStyle(
                                    color: kBlack,
                                    fontSize: 14,
                                    fontFamily: poppinSemiBold,
                                  ),
                                ),
                                Text(
                                  "${formattedPrice}",
                                  style: TextStyle(
                                    color: kBlack,
                                    fontSize: 14,
                                    fontFamily: poppinSemiBold,
                                  ),
                                ),
                                Text(
                                  "/Month",
                                  style: TextStyle(
                                    color: textLabelColor,
                                    fontSize: 14,
                                    fontFamily: poppinSemiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 50,
                            bottom: 20,
                            child: GestureDetector(
                              onTap: () async {
                                carID = favoriteCarModelObject.data![index].carsId;
                                print("selectedCarId $carID");
                                await getLikeUnlikeCarWidget();
                                getFavoriteCarWidget();
                              },
                              child: Image.asset("assets/home_page/heart.png", width: 50, height: 50,),),
                          ),
                          Positioned(
                            left: 30,
                            top: -45,
                            child: SizedBox(
                              width: 180,
                              height: 180,
                              child: Image.network(
                                '$baseUrlImage${favoriteCarModelObject.data?[index].image1}',
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                                  return Container(
                                    child: Image.asset(
                                        'assets/icon/fade_in_image.jpeg'),
                                  );
                                },
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: borderColor,
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),

                            // favoriteCarModelObject
                            //     .data?[index].image1 ==
                            //     null
                            //     ? Padding(
                            //   padding: const EdgeInsets.only(top: 80.0),
                            //   child: Image.asset(
                            //     'assets/icon/fade_in_image.jpeg',
                            //     width: 50,
                            //     height: 50,
                            //   ),
                            // )
                            //     : FadeInImage(
                            //   placeholder: AssetImage(
                            //     "assets/icon/fade_in_image.jpeg",
                            //   ),
                            //   width: 180,
                            //   height: 180,
                            //   image: NetworkImage(
                            //     "$baseUrlImage${favoriteCarModelObject.data?[index].image1}",
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                    );
                    //   Stack(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 20),
                    //       child: Container(
                    //         height: screenHeight * 0.25,
                    //       ),
                    //     ),
                    //     Positioned(
                    //       top: 90,
                    //       left: 30,
                    //       right: 30,
                    //       child: Padding(
                    //         padding: EdgeInsets.only(left: 9),
                    //         child: Container(
                    //           height: screenHeight * 0.19,
                    //           // width: 343,
                    //           width: screenWidth,
                    //           decoration: BoxDecoration(
                    //             color: kWhite,
                    //             borderRadius: BorderRadius.circular(20),
                    //             boxShadow: [
                    //               BoxShadow(
                    //                 color: Colors.grey.withOpacity(0.1),
                    //                 spreadRadius: 5,
                    //                 blurRadius: 5,
                    //                 offset: Offset(3, 3),
                    //               ),
                    //             ],
                    //           ),
                    //           child: Column(
                    //             children: [
                    //               Container(height: screenHeight * 0.06),
                    //               Row(
                    //                 children: [
                    //                   SizedBox(height: 93.6),
                    //                   Padding(
                    //                     padding: EdgeInsets.symmetric(horizontal: 15),
                    //                     child: Column(
                    //                       crossAxisAlignment: CrossAxisAlignment.start,
                    //                       children: [
                    //                         Row(
                    //                           children: [
                    //                             Text("${favoriteCarModelObject.data![index].vehicalName} | ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                    //
                    //                             Text("${favoriteCarModelObject.data![index].carsColors!.name} ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 12, fontFamily: poppinMedium)),
                    //                           ],
                    //                         ),
                    //                         SizedBox(height: screenHeight * 0.005),
                    //                         Row(
                    //                           children: [
                    //                             Text("${favoriteCarModelObject.data![index].carsModels!.name} ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                    //
                    //                             Text("${favoriteCarModelObject.data![index].carsMakes!.name} ",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 10, fontFamily: poppinMedium)),
                    //                             Text("${favoriteCarModelObject.data![index].year}",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                    //                           ],
                    //                         ),
                    //                         SizedBox(height: screenHeight * 0.005),
                    //                         Row(
                    //                           children: [
                    //                             Padding(
                    //                               padding: EdgeInsets.only(top: 04),
                    //                               child: Text("RM",  textAlign: TextAlign.left, style: TextStyle(
                    //                                   color: kRed, fontSize: 5, fontFamily: poppinRegular)),
                    //                             ),
                    //                             favoriteCarModelObject.data![index].carsUsageType == "EV Subscriptions"?
                    //                             originalPriceText("${favoriteCarModelObject.data![index].carsPlans![0].pricePerMonth}"):
                    //                             favoriteCarModelObject.data![index].carsUsageType == "Photography"?
                    //                             originalPriceText("${favoriteCarModelObject.data![index].carsPlans![0].pricePerHour}"):
                    //                             originalPriceText("${favoriteCarModelObject.data![index].carsPlans![0].pricePerSlot}"),
                    //                             SizedBox(width: 5),
                    //                             Padding(
                    //                               padding: EdgeInsets.only(top: 06),
                    //                               child: Text("RM",  textAlign: TextAlign.left,
                    //                                   style: TextStyle(color: borderColor,
                    //                                       fontSize: 7, fontFamily: poppinSemiBold)),
                    //                             ),
                    //
                    //                             favoriteCarModelObject.data![index].carsUsageType == "EV Subscriptions"?
                    //                             discountedPriceText("${formattedPrice}/", ""):
                    //                             favoriteCarModelObject.data![index].carsUsageType == "Photography"?
                    //                             discountedPriceText("${favoriteCarModelObject.data![index].carsPlans![0].discountedPricePerHour}/", "Hour"):
                    //                             discountedPriceText("${favoriteCarModelObject.data![index].carsPlans![0].discountedPricePerSlot}/", "Slot"),
                    //
                    //                             SizedBox(width: screenWidth * 0.01),
                    //                             showRatingStars(double.parse("${favoriteCarModelObject.data![index].rating}")),
                    //                             SizedBox(width: screenWidth * 0.01),
                    //                             Text("${favoriteCarModelObject.data![index].rating}",
                    //                                 textAlign: TextAlign.left, style: TextStyle(
                    //                                     color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                    //                           ],
                    //                         ),
                    //
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       left: 30, right: 30, top: 30,
                    //       child: favoriteCarModelObject.data![index].image1 == null
                    //           ? ClipRRect(
                    //           borderRadius: BorderRadius.circular(10),
                    //           child: Image.asset('assets/icon/fade_in_image.jpeg'))
                    //           : ClipRRect(
                    //         borderRadius: BorderRadius.circular(10),
                    //         child: FadeInImage(
                    //             placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                    //             width: 350, height: 100,
                    //             image: NetworkImage("$baseUrlImage${favoriteCarModelObject.data![index].image1}")),
                    //       ),
                    //     ),
                    //     Positioned(
                    //         top: 10, left: 15,
                    //         child: Container(
                    //           height: MediaQuery.of(context).size.width * 0.07,
                    //           width: MediaQuery.of(context).size.width * 0.16,
                    //           decoration: BoxDecoration(
                    //             color: kRed.withOpacity(0.8),
                    //             borderRadius: BorderRadius.only(
                    //                 topRight: Radius.circular(15),
                    //                 bottomLeft: Radius.circular(15)),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Text("${favoriteCarModelObject.data![index].discountPercentage} %",
                    //                   textAlign: TextAlign.left, style: TextStyle(
                    //                       color: kWhite, fontSize: 10, fontFamily: poppinSemiBold)),
                    //               Text(" OFF ",  textAlign: TextAlign.left, style: TextStyle(
                    //                   color: kWhite, fontSize: 8, fontFamily: poppinSemiBold)),
                    //             ],
                    //           ),
                    //         )),
                    //     Positioned(
                    //         top: 10, right: 15,
                    //         child: GestureDetector(
                    //             onTap: () async {
                    //               carID = favoriteCarModelObject.data![index].carsId;
                    //               print("selectedCarId $carID");
                    //               await getLikeUnlikeCarWidget();
                    //               getFavoriteCarWidget();
                    //             },
                    //             child: Image.asset("assets/home_page/heart.png"))),
                    //   ],
                    // );
                  }),
            ),
          );
        }
      },
    );
  }

  originalPriceText(carPrice){
    return Text("$carPrice/",
      textAlign: TextAlign.left, style: TextStyle(color: kRed,
          decoration: TextDecoration.lineThrough,
          decorationColor: kRed,
          decorationThickness: 3,
          fontSize: 10,
          fontFamily: poppinLight,
          height: 2),);
  }
  discountedPriceText(discountedPrice, type){
    return Row(
      children: [
        Text("$discountedPrice", textAlign: TextAlign.left, style: TextStyle(
            color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
        Padding(
          padding: EdgeInsets.only(top: 06),
          child: Text(type, textAlign: TextAlign.left, style: TextStyle(
                  color: borderColor, fontSize: 8, fontFamily: poppinRegular)),
        ),
      ],
    );
  }
}
