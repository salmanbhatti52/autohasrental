import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'ev_car_description.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:auto_haus_rental_app/Model/get_car_makes_model.dart';
import 'package:auto_haus_rental_app/Model/Notification/notifications_unread_model.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/FavoritesModel/like_unlike_model.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Drawer/Settings/settings_screen.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/Notifications/notification_screen.dart';

int selectedIndex = 0;
String? carName;
class EvSubscriptionPage extends StatefulWidget {
   EvSubscriptionPage({Key? key}) : super(key: key);

  @override
  State<EvSubscriptionPage> createState() => _EvSubscriptionPageState();
}

class _EvSubscriptionPageState extends State<EvSubscriptionPage> {
  EvCarsModel evCarsModelObject = EvCarsModel();
  int? selectedCarMakesId, evCarMakesId;
  String? selectedCarMakesName;
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

  NotificationsUnReadModel notificationsUnReadModelObject = NotificationsUnReadModel();
  GetCarMakesModel getCarMakesModelObject = GetCarMakesModel();

  getCarMakesListWidget() async {
    loadingP = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in evSubscriptionPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
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
        print("getCarMakesLength: ${getCarMakesModelObject.data!.length}");
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
    loadingP = false;
    setState(() {
      getEvSubscriptionCarsWidget();
    });
  }

  String? myCurrentCarIndex;
  bool loadingP = true;

  getEvSubscriptionCarsWidget() async {
    loadingP = true;
    setState(() {});
    // try {
    selectedCarMakesId ?? (selectedCarMakesId = 1);
      String apiUrl = carsEvSubscriptionApiUrl;
      print("evSubscriptionApi: $apiUrl");
      print("userId: $userId");
      print("selectedCarMakesId: $selectedCarMakesId");
      print("selectedCarMakesName: $selectedCarMakesName");
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "users_customers_id" : userId,
          "cars_makes_id": "$selectedCarMakesId"
        },
        headers: {
          'Accept': 'application/json'
        });
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("evSubscriptionResponse: ${responseString.toString()}");
        // loadingP = false;
        setState(() {});
        evCarsModelObject = evCarsModelFromJson(responseString);
        print("evCarsLength: ${evCarsModelObject.data?.length}");
        getUnreadNotificationWidget();
        // searchController.clear();
      }
    // } catch (e) {
    //   print('Error in evSubscription: ${e.toString()}');
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

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
        appBar: AppBar(
          systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // <-- SEE HERE
            statusBarIconBrightness:
            Brightness.dark, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
            Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          ),
          actions: [
            notificationStatus == "Yes"?
            GestureDetector(
              onTap: () {
                print("clicked");
                Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>  NotificationsScreen()));
              },
              child: Padding(
                padding:  EdgeInsets.only(top: 30, right: 20),
                child: Stack(
                  children: [
                    SvgPicture.asset("assets/home_page/notification_bell.svg"),
                    Positioned(
                      right: 02,
                      left: 05,
                      bottom: 13,
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
              ),
            ) : Container(),
          ],
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:  EdgeInsets.only(top: 30),
              child: Image.asset("assets/home_page/back_arrow.png",
                  height: 25, width: 25),
            ),
          ),
          title: Padding(
            padding:  EdgeInsets.only(top: 30),
            child: Text("EV Subscription",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20, fontFamily: poppinBold, color: kBlack)),
          ),
          backgroundColor: homeBgColor,
          elevation: 0.0,
          centerTitle: true,
        ),

      body: SingleChildScrollView(
            child: Column(
              children: [

                carMakersListWidget(),

                loadingP ? Center(child: CircularProgressIndicator(color: Colors.transparent)) :
                allEvSubscriptionItemsList(),

              ],
            ),
          )
    );
  }
  carMakersListWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 08),
      child: Container(
        height: MediaQuery.of(context).size.height* 0.1,
        color: Colors.transparent,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: getCarMakesModelObject.data?.length,
            itemBuilder: (context, index){
              return Padding(
                padding:  EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedIndex = index;
                      selectedCarMakesId = getCarMakesModelObject.data![selectedIndex].carsMakesId;
                      selectedCarMakesName = getCarMakesModelObject.data![selectedIndex].name;
                      print("myIndex $index");
                      print("selectedIndex $selectedIndex");
                      print("selectedCarMakesName $selectedCarMakesName");
                      print("selectedCarMakesId $selectedCarMakesId");
                      getEvSubscriptionCarsWidget();
                    });
                  },
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(3),
                    width: Get.width * 0.2,
                    decoration: BoxDecoration(
                        color: selectedIndex == index? borderColor: kWhite,
                        border: Border.all(width: 2,
                            color: selectedIndex == index ? borderColor : kWhite),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.network(
                      "$baseUrlImage${getCarMakesModelObject.data?[index].image}",
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        // Display a placeholder image when the main image fails to load
                        return Image.asset(
                          'assets/icon/fade_in_image.jpeg', // Change the placeholder image path accordingly
                          height: 25,
                          width: 25,
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget allEvSubscriptionItemsList() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.78,
        child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
        evCarsModelObject.status != "success" ?
         Center(child: Text('No Cars Found.',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))):
        // search.isEmpty?
        ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: evCarsModelObject.data!.length,
            itemBuilder: (BuildContext context, int index) {
              int discountedPrice = evCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth;
              NumberFormat format = NumberFormat('#,##0.00', 'en_US');
              String formattedPrice = format.format(discountedPrice);
              return  Container(
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
                              offset: Offset(3,3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${evCarsModelObject.data?[index].vehicalName}",
                                      style: TextStyle(
                                        color: kBlack,
                                        fontSize: 14,
                                        fontFamily: poppinBold,
                                      ),
                                    ),
                                    Text(
                                      "${evCarsModelObject.data?[index].year}",
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
                      right: 19,
                      bottom: 10,
                      child: GestureDetector(
                                    onTap: () {
                                      print("clickedddd");
                                      carID = evCarsModelObject.data![index].carsId;
                                      String desc = "${evCarsModelObject.data![index].description}";
                                      print("object123 $carID");
                                      print("desc123 $desc");
                                      print("favouriteStatus ${evCarsModelObject.data![index].favouriteStatus}");

                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => EVCarDescription(
                                            carName: evCarsModelObject.data![index].vehicalName,
                                            carYear: "${evCarsModelObject.data![index].year}",
                                            carId: evCarsModelObject.data![index].carsId,
                                            carColorName: evCarsModelObject.data![index].carsColors!.name,
                                            carMakesName: evCarsModelObject.data![index].carsMakes!.name,
                                            carModelName: evCarsModelObject.data![index].carsModels!.name,
                                            carImageModel: evCarsModelObject.data?[index].objectImage,
                                            carImage: evCarsModelObject.data![index].image1!.endsWith('.jpg') || evCarsModelObject.data![index].image1!.endsWith('.png') || evCarsModelObject.data![index].image1!.endsWith('.jpeg')
                                                ? "$baseUrlImage${evCarsModelObject.data?[index].image1}"
                                                : evCarsModelObject.data?[index].image1,
                                            carRating: evCarsModelObject.data![index].rating,
                                            carMakesImage: "$baseUrlImage${evCarsModelObject.data![index].carsMakes!.image}",
                                            carStatus: evCarsModelObject.data![index].favouriteStatus,
                                            discountPercentage: evCarsModelObject.data![index].discountPercentage,
                                            carDiscountPrice: "${formattedPrice}",
                                            carPrice: evCarsModelObject.data![index].carsPlans![0].pricePerMonth,
                                            carOwnerImage: "$baseUrlImage${evCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                            carOwnerName: "${evCarsModelObject.data![index].usersCompanies!.companyName}",
                                            carOwnerId: evCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                            myCarDescription: evCarsModelObject.data![index].description,
                                            favouriteStatus: evCarsModelObject.data![index].favouriteStatus,

                                            featureSuv: evCarsModelObject.data![index].featuresSuv,
                                            featuresDoors: evCarsModelObject.data![index].featuresDoors,
                                            featuresSeats: evCarsModelObject.data![index].featuresSeats,
                                            featuresAutomatic: evCarsModelObject.data![index].featuresAutomatic,
                                            featuresSpeed: evCarsModelObject.data![index].featuresSpeed,
                                            featuresElectric: evCarsModelObject.data![index].featuresElectric,
                                            featuresEngine_capacity: evCarsModelObject.data![index].featuresEngineCapacity,
                                            featuresFuelCapacity: evCarsModelObject.data![index].featuresFuelCapacity,
                                            featuresMeterReading: evCarsModelObject.data![index].featuresMeterReading,
                                            featuresNewCars: evCarsModelObject.data![index].featuresNewCars,
                                          )));
                                      print("evCarName ${evCarsModelObject.data![index].vehicalName}");
                                      print("evCarYear ${evCarsModelObject.data![index].year}");
                                      print("evCarImage $baseUrlImage${evCarsModelObject.data![index].image1}");
                                      print("ownerImage $baseUrlImage${evCarsModelObject.data![index].usersCompanies!.companyLogo}");
                                      print("ownerName ${evCarsModelObject.data![index].usersCompanies!.companyName}");
                                      print("ownerId ${evCarsModelObject.data![index].usersCompanies!.usersCompaniesId}");
                                      },
                        child: Container(
                          width: Get.width * 0.4,
                          height: 55,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            color: borderColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Click to see Details",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: kWhite,
                                fontFamily: poppinMedium,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: -45,
                      child: evCarsModelObject.data?[index].image1 == null
                          ? Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Image.asset('assets/icon/fade_in_image.jpeg', width: 50,
                          height: 50, ),
                      )
                          :FadeInImage(
                        placeholder: AssetImage(
                          "assets/icon/fade_in_image.jpeg",),
                        width: 180,
                        height: 180,
                        image: NetworkImage(
                          "$baseUrlImage${evCarsModelObject.data?[index].image1}",),
                      ),
                    ),
                  ],
                ),
              );

              //   Stack(
              //   children: [
              //     Padding(
              //       padding:  EdgeInsets.symmetric(vertical: 20),
              //       child: Container(
              //         height: MediaQuery.of(context).size.height * 0.33),
              //     ),
              //     Positioned(
              //       top: 90,
              //       left: 30,
              //       right: 30,
              //       child: Padding(
              //         padding:  EdgeInsets.only(left: 9),
              //         child: Container(
              //           height: MediaQuery.of(context).size.height * 0.26,
              //           width: 343,
              //           decoration: BoxDecoration(
              //             color: kWhite,
              //             borderRadius: BorderRadius.circular(20),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.grey.withOpacity(0.1),
              //                 spreadRadius: 5,
              //                 blurRadius: 5,
              //                 offset:  Offset(3, 3),
              //               ),
              //             ],
              //           ),
              //           child: Column(
              //             children: [
              //               Container(height: MediaQuery.of(context).size.height*0.1,),
              //               Row(
              //                 children: [
              //                    SizedBox(height: 93.6),
              //                   Padding(
              //                     padding:  EdgeInsets.symmetric(horizontal: 15),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Row(
              //                           children: [
              //                             Text("${evCarsModelObject.data![index].vehicalName}, ",
              //                                 style: TextStyle(color: kBlack, fontSize: 14,
              //                                     fontFamily: poppinBold), textAlign: TextAlign.left),
              //                             Text("${evCarsModelObject.data![index].carsColors!.name} ",
              //                               textAlign: TextAlign.left, style: TextStyle(
              //                                   color: kBlack, fontSize: 14, fontFamily: poppinRegular),),
              //                           ],
              //                         ),
              //                         Row(
              //                           children: [
              //                             Text("${evCarsModelObject.data![index].carsMakes!.name}, ",
              //                                 style: TextStyle(color: kBlack, fontSize: 12,
              //                                     fontFamily: poppinRegular), textAlign: TextAlign.left),
              //                             Text("${evCarsModelObject.data![index].carsModels!.name}, ",
              //                                 textAlign: TextAlign.left, style: TextStyle(
              //                                     color: kBlack, fontSize: 12, fontFamily: poppinSemiBold)),
              //                             Text("${evCarsModelObject.data![index].year}",
              //                                 textAlign: TextAlign.left, style: TextStyle(
              //                                     color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
              //                           ],
              //                         ),
              //                         Row(
              //                           children: [
              //                             evCarsModelObject.data![index].discountPercentage != "0.00" ? Row(
              //                               children: [
              //                                 Padding(
              //                                   padding:  EdgeInsets.only(top: 04),
              //                                   child: Text("RM",  textAlign: TextAlign.left,
              //                                     style: TextStyle(color: kRed, fontSize: 5, fontFamily: poppinRegular),),
              //                                 ),
              //                                 Text("${evCarsModelObject.data![index].carsPlans![0].pricePerMonth}",
              //                                     textAlign: TextAlign.left, style: TextStyle(
              //                                         color: kRed, decoration: TextDecoration.lineThrough,
              //                                         decorationColor: kRed, decorationThickness: 3,
              //                                         fontSize: 10, fontFamily: poppinLight, height: 2)),
              //                                 SizedBox(width: 5),
              //                               ],
              //                             ) : SizedBox(),
              //                             Padding(
              //                               padding:  EdgeInsets.only(top: 06),
              //                               child: Text("RM",  textAlign: TextAlign.left,
              //                                   style: TextStyle(color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
              //                             ),
              //                             Text("${formattedPrice}",
              //                                 textAlign: TextAlign.left, style: TextStyle(
              //                                     color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
              //                             Text("", textAlign: TextAlign.left, style: TextStyle(
              //                                 color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
              //                             SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
              //                             // showRatingStars(double.parse("${evCarsModelObject.data![index].rating}")),
              //                             // evCarsModelObject.data![index].rating == null
              //                             //     ? Text("0.0", style: TextStyle(color: kBlack, fontSize: 12,
              //                             //     fontFamily: poppinRegular), textAlign: TextAlign.left) :
              //                             // Text("${evCarsModelObject.data![index].rating}",
              //                             //     style: TextStyle(color: kBlack, fontSize: 12,
              //                             //         fontFamily: poppinRegular), textAlign: TextAlign.left),
              //                           ],
              //                         ),
              //                         SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              //                         // verifiedDealerText(),
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
              //       right: 30, bottom: 30,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               print("clickedddd");
              //               carID = evCarsModelObject.data![index].carsId;
              //               String desc = "${evCarsModelObject.data![index].description}";
              //               print("object123 $carID");
              //               print("desc123 $desc");
              //               print("favouriteStatus ${evCarsModelObject.data![index].favouriteStatus}");
              //
              //               Navigator.push(context, MaterialPageRoute(
              //                   builder: (context) => EVCarDescription(
              //                     carName: evCarsModelObject.data![index].vehicalName,
              //                     carYear: "${evCarsModelObject.data![index].year}",
              //                     carId: evCarsModelObject.data![index].carsId,
              //                     carColorName: evCarsModelObject.data![index].carsColors!.name,
              //                     carMakesName: evCarsModelObject.data![index].carsMakes!.name,
              //                     carModelName: evCarsModelObject.data![index].carsModels!.name,
              //                     // carImage: "$baseUrlImage${evCarsModelObject.data![index].image1}",
              //                     carImage: evCarsModelObject.data![index].image1!.endsWith('.jpg') || evCarsModelObject.data![index].image1!.endsWith('.png') || evCarsModelObject.data![index].image1!.endsWith('.jpeg')
              //                         ? "$baseUrlImage${evCarsModelObject.data?[index].image1}"
              //                         : evCarsModelObject.data?[index].image1,
              //                     carRating: evCarsModelObject.data![index].rating,
              //                     carMakesImage: "$baseUrlImage${evCarsModelObject.data![index].carsMakes!.image}",
              //                     carStatus: evCarsModelObject.data![index].favouriteStatus,
              //                     discountPercentage: evCarsModelObject.data![index].discountPercentage,
              //                     carDiscountPrice: "${formattedPrice}",
              //                     carPrice: evCarsModelObject.data![index].carsPlans![0].pricePerMonth,
              //                     carOwnerImage: "$baseUrlImage${evCarsModelObject.data![index].usersCompanies!.companyLogo}",
              //                     carOwnerName: "${evCarsModelObject.data![index].usersCompanies!.companyName}",
              //                     carOwnerId: evCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
              //                     myCarDescription: evCarsModelObject.data![index].description,
              //                     favouriteStatus: evCarsModelObject.data![index].favouriteStatus,
              //
              //                     featureSuv: evCarsModelObject.data![index].featuresSuv,
              //                     featuresDoors: evCarsModelObject.data![index].featuresDoors,
              //                     featuresSeats: evCarsModelObject.data![index].featuresSeats,
              //                     featuresAutomatic: evCarsModelObject.data![index].featuresAutomatic,
              //                     featuresSpeed: evCarsModelObject.data![index].featuresSpeed,
              //                     featuresElectric: evCarsModelObject.data![index].featuresElectric,
              //                     featuresEngine_capacity: evCarsModelObject.data![index].featuresEngineCapacity,
              //                     featuresFuelCapacity: evCarsModelObject.data![index].featuresFuelCapacity,
              //                     featuresMeterReading: evCarsModelObject.data![index].featuresMeterReading,
              //                     featuresNewCars: evCarsModelObject.data![index].featuresNewCars,
              //                   )));
              //               print("evCarName ${evCarsModelObject.data![index].vehicalName}");
              //               print("evCarYear ${evCarsModelObject.data![index].year}");
              //               print("evCarImage $baseUrlImage${evCarsModelObject.data![index].image1}");
              //               print("ownerImage $baseUrlImage${evCarsModelObject.data![index].usersCompanies!.companyLogo}");
              //               print("ownerName ${evCarsModelObject.data![index].usersCompanies!.companyName}");
              //               print("ownerId ${evCarsModelObject.data![index].usersCompanies!.usersCompaniesId}");
              //               },
              //             child: Image.asset("assets/car_bookings_images/more_button.png"),
              //           ),
              //         ],
              //       ),
              //     ),
              //     // Positioned(
              //     //   left: 20, right: 20,top: 30,
              //     //   child: evCarsModelObject.data![index].image1 == null ?
              //     //   ClipRRect(
              //     //       borderRadius: BorderRadius.circular(10),
              //     //       child: Image.asset('assets/icon/fade_in_image.jpeg')) :
              //     //   ClipRRect(
              //     //     borderRadius: BorderRadius.circular(10),
              //     //     child: FadeInImage(
              //     //       placeholder:  AssetImage("assets/icon/fade_in_image.jpeg"),
              //     //       width: MediaQuery.of(context).size.width * 0.3,
              //     //       height: MediaQuery.of(context).size.height * 0.15,
              //     //       image: NetworkImage("$baseUrlImage${evCarsModelObject.data![index].image1}"),),
              //     //   ),
              //     // ),
              //     Positioned(
              //       left: 20, right: 20,top: 0,
              //       child: evCarsModelObject.data![index].image1 == null
              //           ? ClipRRect(
              //         borderRadius: BorderRadius.circular(10),
              //         child: Image.asset('assets/icon/fade_in_image.jpeg'),
              //       )
              //           : evCarsModelObject.data![index].image1!.endsWith('.jpg') || evCarsModelObject.data![index].image1!.endsWith('.png') || evCarsModelObject.data![index].image1!.endsWith('.jpeg')
              //           ? ClipRRect(
              //         borderRadius: BorderRadius.circular(10),
              //         child: FadeInImage(
              //           placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
              //           height: 65,
              //           image: NetworkImage("$baseUrlImage${evCarsModelObject.data?[index].image1}"),
              //         ),
              //       )
              //           : Container(
              //         height: MediaQuery.of(context).size.height * 0.24,
              //         child: ModelViewer(
              //           // cameraOrbit: Clipboard.kTextPlain,
              //           backgroundColor: Colors.transparent,
              //           src: '${evCarsModelObject.data?[index].image1}',
              //           alt: "A 3D model of car",
              //           autoPlay: false,
              //           autoRotate: false,
              //           cameraControls: false,
              //           disableTap: false,
              //           ar: false,
              //           disablePan: true,
              //           arModes: ["quicklook", "scene-viewer"],
              //           iosSrc: "${evCarsModelObject.data?[index].image1}",
              //           disableZoom: true,
              //         ),
              //       ),
              //     ),
              //     evCarsModelObject.data![index].discountPercentage != "0.00" ? Positioned(
              //         top: 10, left: 10,
              //         child: Container(
              //           height: MediaQuery.of(context).size.width * 0.07,
              //           width: MediaQuery.of(context).size.width * 0.18,
              //           decoration: BoxDecoration(
              //             color: kRed.withOpacity(0.8),
              //             borderRadius:  BorderRadius.only(
              //                 topRight: Radius.circular(15),
              //                 bottomLeft: Radius.circular(15)),
              //           ),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text("${evCarsModelObject.data![index].discountPercentage}",
              //                   textAlign: TextAlign.left, style: TextStyle(color: kWhite,
              //                       fontSize: 13, fontFamily: poppinSemiBold)),
              //               Text(" OFF ", textAlign: TextAlign.left, style: TextStyle(
              //                   color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
              //             ],
              //           ),
              //         )) : Positioned( top: 10, left: 10,child: SizedBox()),
              //     Positioned(
              //       top: 15, right: 15,
              //       child: evCarsModelObject.data![index].favouriteStatus == "like"?
              //       Image.asset("assets/home_page/heart.png"):
              //       GestureDetector(
              //         onTap: () async {
              //           myCurrentCarIndex = "${evCarsModelObject.data![index].carsId}";
              //           print("evCarIds $myCurrentCarIndex");
              //           await getLikeUnlikeCarWidget();
              //           getEvSubscriptionCarsWidget();
              //         },
              //         child: Image.asset("assets/car_bookings_images/heart.png"),
              //       ),
              //     ),
              //   ],
              // );
            })
      ),
    );
  }

  LikeUnlikeCarModel carLikeUnlikeModelObject = LikeUnlikeCarModel();
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
        if (carLikeUnlikeModelObject.message == "Liked") {
          toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
        }
      }
    loadingP = false;
    setState(() {});
  }
}
