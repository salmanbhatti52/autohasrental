import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/HomePageModels/FavoritesModel/car_favorite_like_unlike_model.dart';
import '../../../Model/HomePageModels/FavoritesModel/favorite_cars_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:flutter/material.dart';
import '../../../Model/HomePageModels/FavoritesModel/like_unlike_favorite_cars_model.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/constants.dart';
import '../../../Utils/fontFamily.dart';
import '../../../Widget/toast_message.dart';
import '../MyAppBarHeader/app_bar_header.dart';
import 'package:http/http.dart' as  http;

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  // FavoriteCarModel favoriteCarModelObject = FavoriteCarModel();



  sharedPrefs() async {
    loadingP = true;
    setState(() {});
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print("userId in favoriteCar Prefs is = $userId");
    setState(() {
      getLikeUnlikeCarWidget();
      getFavoriteCarWidget();
    });
  }

  // getFavoriteCarWidget() async {
  //   loadingP = true;
  //   setState(() {});
  //
  //   prefs = await SharedPreferences.getInstance();
  //   userId = (prefs!.getString('userid'));
  //   print('in favoriteCarModel api');
  //
  //   // try {
  //     String apiUrl = favoriteCarsApiUrl;
  //     print("favoriteCarModelApi: $apiUrl");
  //     final response = await http.post(Uri.parse(apiUrl),
  //         headers: {
  //           'Accept': 'application/json'
  //         },
  //         body: {
  //       "users_customers_id": userId
  //       });
  //     print('${response.statusCode}');
  //     print(response);
  //     if (response.statusCode == 200) {
  //       final responseString = response.body;
  //       print("responseFavoriteCars: ${responseString.toString()}");
  //       favoriteCarModelObject = favoriteCarModelFromJson(responseString);
  //       print("favoriteCarModelLength is: ${favoriteCarModelObject.data!.length}");
  //     }
  //   // } catch (e) {
  //   //   print('Error in favoriteCarModel: ${e.toString()}');
  //   // }
  //   loadingP = false;
  //   setState(() {});
  // }

  List<FavoriteCarModel> favoriteCarModelObject = [];
  getFavoriteCarWidget() async {
    setState(() {
      loadingP = true;
    });
    Map body = {
      "users_customers_id": userId
    };
    http.Response response = await http.post(Uri.parse(favoriteCarsApiUrl),
        body: body,
        headers: {
          "Accept": "application/json"
        });
    Map jsonData = jsonDecode(response.body);
    print("favoriteCarsApiUrl: $favoriteCarsApiUrl");
    print('favoriteCarsResponse $jsonData');
    if (jsonData['message'] == 'no data found.') {
      toastFailedMessage("no data found.", kRed);
      print('no data found.');
      setState(() {
        loadingP = false;
      });
    }
    else if (response.statusCode == 200) {
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> obj = jsonData['data'][i];
        print(obj['id']);
        var pos = FavoriteCarModel();
        pos = FavoriteCarModel.fromJson(obj);
        favoriteCarModelObject.add(pos);
        print("favoriteCarsLength: ${favoriteCarModelObject.length}");
        setState(() {
          loadingP = false;
        });
      }
    }
  }

  CarLikeUnlikeModel carLikeUnlikeModelObject = CarLikeUnlikeModel();
  getLikeUnlikeCarWidget() async {
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = likeUnlikeFavoriteCarsApiUrl;
      print("carLikeUnlikeModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl),
        body: {
          "users_customers_id" : userId,
          "cars_id" : "1",
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
      }
    } catch (e) {
      print('Error: ${e.toString()}');
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
          SizedBox(height: screenHeight * 0.04,),
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
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor,)) :
      favoriteCarModelObject.isEmpty
          ? const Center(child: Text('no data found...',
          style: TextStyle(fontWeight: FontWeight.bold))) :
      Container(
        color: Colors.transparent,
        height: screenHeight * 0.75,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: favoriteCarModelObject.length,
            itemBuilder: (BuildContext context, int index) {
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
                            Container(height: screenHeight * 0.1,),
                            Row(
                              children: [
                                const SizedBox(height: 93.6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("${favoriteCarModelObject[index].vehicalName} | ",
                                            style: TextStyle(color: kBlack,
                                              fontSize: 14, fontFamily: poppinBold,),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "MODEL ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: poppinRegular,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text("${favoriteCarModelObject[index].year} ",
                                            style: TextStyle(color: kBlack,
                                              fontSize: 14, fontFamily: poppinMedium,),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text("${favoriteCarModelObject[index].year}",
                                            style: TextStyle(color: kBlack,
                                              fontSize: 10, fontFamily: poppinRegular,),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01,),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 04),
                                            child: Text("RM",
                                              style: TextStyle(color: kRed,
                                                fontSize: 5, fontFamily: poppinRegular,),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text("0.0",
                                            style: TextStyle(
                                              color: kRed,
                                              decoration: TextDecoration.lineThrough,
                                              decorationColor: kRed,
                                              decorationThickness: 3,
                                              fontSize: 10,
                                              fontFamily: poppinLight,
                                              height: 2,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 06),
                                            child: Text("RM",
                                              style: TextStyle(color: borderColor,
                                                fontSize: 7, fontFamily: poppinSemiBold,),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text("0.0",
                                            style: TextStyle(color: borderColor,
                                              fontSize: 16, fontFamily: poppinSemiBold,),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text("/ Month",
                                            style: TextStyle(color: kBlack,
                                              fontSize: 8, fontFamily: poppinRegular,),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(width: screenWidth * 0.01,),
                                          Image.asset("assets/car_bookings_images/rating_stars.png"),
                                          SizedBox(width: screenWidth * 0.01,),
                                          Text("4.0",
                                            style: TextStyle(color: kBlack,
                                              fontSize: 12, fontFamily: poppinRegular,),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                      Row(
                                        children: [
                                          Image.asset("assets/car_bookings_images/promoted.png"),
                                          const SizedBox(width: 5,),
                                          Text("Verified Dealer",
                                            style: TextStyle(color: textLabelColor,
                                              fontSize: 10, fontFamily: poppinRegular,),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(width: 05,),
                                          Container(
                                            height: 20,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: kBlack,
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text("New",
                                                style: TextStyle(
                                                  color: kWhite, fontSize: 8,
                                                  fontFamily: poppinRegular,),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset("assets/car_bookings_images/more_button.png"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 10,
                      left: 15,
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
                            Text("${favoriteCarModelObject[index].discountPercentage}",
                              style: TextStyle(
                                color: kWhite, fontSize: 13,
                                fontWeight: FontWeight.bold, fontFamily: 'Poppins',),),
                            Text(" OFF ", style: TextStyle(
                                  color: kWhite, fontSize: 8,
                              fontWeight: FontWeight.w300, fontFamily: 'Poppins',)),
                          ],
                        ),
                      )),
                  Positioned(
                    child: favoriteCarModelObject[index].image1 == null ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/icon/fade_in_image.jpeg'))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: const AssetImage(
                            "assets/icon/fade_in_image.jpeg"),
                        // fit: BoxFit.fill,
                        width: 350,
                        height: 150,
                        image: NetworkImage(
                            "$baseUrlImage${favoriteCarModelObject[index].image1}"),
                      ),
                    ),

                    // Image.asset(favoriteItemsList[index].carImage,),
                  ),
                  Positioned(
                      top: 10,
                      right: 15,
                      child: GestureDetector(
                        onTap: () async {
                          // isPostLiked? Image.asset("assets/home_page/heart.png"):
                          //     Image.asset("assets/home_page/heart_transparent.png");
                          if (isPostLiked) {
                           await likeUnlikeCarsWidget();
                            // add your code
                            print('unlike');
                          } else {
                            // add your code
                            print('like');
                          }
                          isPostLiked = !isPostLiked;
                        },
                        child: Image.asset("assets/home_page/heart.png",),
                      )),
                ],
              );
            }),
      ),
    );
  }
  bool isPostLiked = true;
  LikeUnlikeFavoriteCarModel likeUnlikeFavoriteCarModel = LikeUnlikeFavoriteCarModel();
  likeUnlikeCarsWidget() async {
    try {
      String apiUrl = likeUnlikeFavoriteCarsApiUrl;
      print("likeUnlikeFavoriteCarModelApi: $apiUrl");
      print("email: 1");
      print("carId: 1");
      final response = await http.post(Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json'
        },
        body: {
          'users_customers_id': "userId",
          'cars_id': "1",
        },
      );
      final responseString = response.body;
      print("likeUnlikeFavoriteCarModelResponse: $responseString");

      print("status Code likeUnlikeFavoriteCarModel: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("in 200 signUp");
        // print("resS $responseString");
        if (responseString != 'false') {
          likeUnlikeFavoriteCarModel = likeUnlikeFavoriteCarModelFromJson(responseString);
          setState(() {});
          print('likeUnlikeFavoriteCarModel status: ${likeUnlikeFavoriteCarModel.status}');
        }
      }
    } catch (e) {
      print('likeUnlikeFavoriteCarModel error in catch = ${e.toString()}');
      return null;
    }
  }
}

List favoriteItemsList = [
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/bmw_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/bmw_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/bmw_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
  FavoriteItemsClass("assets/home_page/tesla_car_image.png", "5%", 'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
];

class FavoriteItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  FavoriteItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
