import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/HomePageModels/FavoritesModel/car_favorite_like_unlike_model.dart';
import '../../../Model/HomePageModels/FavoritesModel/favorite_cars_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  CarLikeUnlikeModel carLikeUnlikeModelObject = CarLikeUnlikeModel();
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
    setState(() {
      getFavoriteCarWidget();
    });
  }

  getFavoriteCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in favoriteCarModelObjectCarApi');
    try {
      String apiUrl = favoriteCarsApiUrl;
      print("favoriteCarModelObjectCarModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json'
      }, body: {
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
        print("favoriteCarModelObjectLength: ${favoriteCarModelObject.data!.length}");
      }
    } catch (e) {
      print('Error in favoriteCarModelObject: ${e.toString()}');
    }
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
        carLikeUnlikeModelObject = carLikeUnlikeModelFromJson(responseString);
        print("carLikeUnlikeModelMessage: ${carLikeUnlikeModelObject.message}");
        setState(() {});
      }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
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
          myHeaderDrawer(context, "assets/home_page/Side_Menu.png", "Favorite",
              "assets/home_page/notification_image.png"),
          allFavItem(),
        ],
      ),
    );
  }

  Widget allFavItem() {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
      favoriteCarModelObject.message == "no data found." ? const Center(child: Text('no data found...', style: TextStyle(fontWeight: FontWeight.bold))) :

      favoriteCarModelObject.data == null? const Center(child: Text('no data found...', style: TextStyle(fontWeight: FontWeight.bold))):
      Container(
        color: Colors.transparent,
        height: screenHeight * 0.75,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: favoriteCarModelObject.data!.length,
            itemBuilder: (BuildContext context, int index) {
              carID = favoriteCarModelObject.data![index].carsId;
              // myCarsIndexId = favoriteCarModelObject.data![index].carsId.toString();
              // print("myCarsIndexIds $myCarsIndexId");
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: screenHeight * 0.33,
                    ),
                  ),
                  Positioned(
                    top: 90,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Container(
                        height: screenHeight * 0.24,
                        width: 343,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(height: screenHeight * 0.1),
                            Row(
                              children: [
                                const SizedBox(height: 93.6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("${favoriteCarModelObject.data![index].vehicalName} | ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                                          Text("MODEL ",  textAlign: TextAlign.left,
                                              style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                          Text("${favoriteCarModelObject.data![index].year} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
                                          Text("${favoriteCarModelObject.data![index].year}",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 04),
                                            child: Text("RM",  textAlign: TextAlign.left, style: TextStyle(
                                                  color: kRed, fontSize: 5, fontFamily: poppinRegular)),
                                          ),
                                          Text("0.0", textAlign: TextAlign.left,
                                              style: TextStyle(color: kRed,
                                                  decoration: TextDecoration.lineThrough,
                                                  decorationColor: kRed,
                                                  decorationThickness: 3,
                                                  fontSize: 10,
                                                  fontFamily: poppinLight,
                                                  height: 2),
                                              ),
                                          const SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 06),
                                            child: Text("RM",  textAlign: TextAlign.left,
                                                style: TextStyle(color: borderColor,
                                                    fontSize: 7, fontFamily: poppinSemiBold)),
                                          ),
                                          Text("0.0",  textAlign: TextAlign.left, style: TextStyle(
                                                  color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                          Text("/ Month",  textAlign: TextAlign.left, style: TextStyle(
                                                  color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                          SizedBox(width: screenWidth * 0.01),
                                          Image.asset("assets/car_bookings_images/rating_stars.png"),
                                          SizedBox(width: screenWidth * 0.01),
                                          Text("4.0",  textAlign: TextAlign.left, style: TextStyle(
                                              color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                      Row(
                                        children: [
                                          Image.asset("assets/car_bookings_images/promoted.png"),
                                          const SizedBox(width: 5),
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
                                              child: Text("New",
                                                  style: TextStyle(color: kWhite,
                                                      fontSize: 8, fontFamily: poppinRegular),
                                                  textAlign: TextAlign.left)
                                            ),
                                          ),
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
                    right: 30, bottom: 35,
                    child: Image.asset("assets/car_bookings_images/more_button.png"),
                  ),
                  Positioned(
                    left: 30, right: 30,
                    child: favoriteCarModelObject.data![index].image1 == null
                        ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/icon/fade_in_image.jpeg'))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                        width: 350, height: 130,
                        image: NetworkImage("$baseUrlImage${favoriteCarModelObject.data![index].image1}")),
                    ),
                  ),
                  Positioned(
                      top: 10, left: 15,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.07,
                        width: MediaQuery.of(context).size.width * 0.16,
                        decoration: BoxDecoration(
                          color: kRed.withOpacity(0.8),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${favoriteCarModelObject.data![index].discountPercentage}",
                              textAlign: TextAlign.left, style: TextStyle(
                                  color: kWhite, fontSize: 13, fontFamily: poppinSemiBold)),
                            Text(" OFF ",  textAlign: TextAlign.left, style: TextStyle(
                                  color: kWhite, fontSize: 8, fontFamily: poppinSemiBold)),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 10, right: 15,
                      child: GestureDetector(
                          onTap: () async {
                            carID = favoriteCarModelObject.data![index].carsId;
                            print("selectedCarId $carID");
                            await getLikeUnlikeCarWidget();
                           getFavoriteCarWidget();
                          },
                          child: Image.asset("assets/home_page/heart.png"))),
                      // GestureDetector(
                      //   onTap: () async {
                      //     myCarsIndexId = "${favoriteCarModelObject.data![index].carsId}";
                      //     print("favoriteCarId $myCarsIndexId");
                      //     // carID = favoriteCarModelObject.data![index].carsId;
                      //     // print("favoriteCarId $carID");
                      //     await getLikeUnlikeCarWidget();
                      //     if (carLikeUnlikeModelObject.message == "Liked") {
                      //       print("isLiked");
                      //       toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                      //     }
                      //     if (carLikeUnlikeModelObject.message == "Unliked") {
                      //       print("isUnLiked");
                      //       toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                      //     }
                      //     },
                      //   child: carLikeUnlikeModelObject.message == "Liked"
                      //       ? Image.asset("assets/home_page/heart.png")
                      //       : Image.asset("assets/car_bookings_images/heart.png"),
                      // )),
                ],
              );
            }),
      ),
    );
  }
}
