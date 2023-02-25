import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/HomePageModels/FavoritesModel/car_favorite_like_unlike_model.dart';
import '../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
import 'package:http/http.dart' as http;
import '../../../MyAppBarHeader/app_bar_header.dart';
import '../../Filter/filter_screen.dart';
import '../BookForWedding/book_for_wedding_car_logo_container.dart';
import 'ev_car_description.dart';

class EvSubscriptionPage extends StatefulWidget {
  const EvSubscriptionPage({Key? key}) : super(key: key);

  @override
  State<EvSubscriptionPage> createState() => _EvSubscriptionPageState();
}

class _EvSubscriptionPageState extends State<EvSubscriptionPage> {
  EvCarsModel evCarsModelObject = EvCarsModel();

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  String? myCurrentCarIndex;
  bool loadingP = true;

  sharedPrefs() async {
    loadingP = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    // getLikeUnlikeCarWidget();
    getEvSubscriptionCarsWidget();

  }

  getEvSubscriptionCarsWidget() async {
    loadingP = true;
    setState(() {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in evSubscriptionPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    // try {
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
        evCarsModelObject = evCarsModelFromJson(responseString);
        print("evSubscriptionObjectLength: ${evCarsModelObject.data!.length}");
      }
    // } catch (e) {
    //   print('Error in evSubscription: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {
    });
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarDoubleImage(
          frontImage: "assets/home_page/back_arrow.png",
          title: "EV Subscription",
          backImage: "assets/home_page/notification_image.png"),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 12, 10, 0),
                        hintText: 'Search for Cars',
                        hintStyle: TextStyle(
                            color: const Color(0xffD4DCE1),
                            fontSize: 14,
                            fontFamily: poppinLight),
                        focusColor: borderColor,
                        suffixIcon: const Icon(
                          Icons.search_outlined,
                          color: Color(0xffD4DCE1),
                        ),
                      ),
                      style: TextStyle(color: borderColor, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const FilterScreen()));
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.asset("assets/home_page/filter.png")),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: const BookForWeddingCarLogoContainer()),
          ),

          loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
          evCarsModelObject.status != "success" ?
          const Center(child: Text('no data found...',
              style: TextStyle(fontWeight: FontWeight.bold)))
              : allEvSubscriptionItemsList(),
        ],
      ),
    );
  }

  Widget allEvSubscriptionItemsList() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: evCarsModelObject.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.33,),
                  ),
                  Positioned(
                              top: 90,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.26,
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
                                      Container(height: MediaQuery.of(context).size.height * 0.1,),
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
                                                    Text("${evCarsModelObject.data![index].vehicalName}, ",
                                                      style: TextStyle(color: kBlack, fontSize: 14,
                                                          fontFamily: poppinBold), textAlign: TextAlign.left),
                                                    Text("${evCarsModelObject.data![index].carsColors!.name} ",
                                                      textAlign: TextAlign.left, style: TextStyle(
                                                          color: kBlack, fontSize: 14, fontFamily: poppinRegular),),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("${evCarsModelObject.data![index].carsMakes!.name}, ",
                                                        style: TextStyle(color: kBlack, fontSize: 12,
                                                            fontFamily: poppinRegular), textAlign: TextAlign.left),
                                                    Text("${evCarsModelObject.data![index].carsModels!.name}, ",
                                                        textAlign: TextAlign.left, style: TextStyle(
                                                            color: kBlack, fontSize: 12, fontFamily: poppinSemiBold)),
                                                    Text("${evCarsModelObject.data![index].year}",
                                                        textAlign: TextAlign.left, style: TextStyle(
                                                            color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 04),
                                                      child: Text("RM",  textAlign: TextAlign.left,
                                                          style: TextStyle(color: kRed, fontSize: 5, fontFamily: poppinRegular),),
                                                    ),
                                                    Text("${evCarsModelObject.data![index].carsPlans![0].pricePerMonth}",
                                                      style: TextStyle(
                                                        color: kRed,
                                                        decoration: TextDecoration.lineThrough,
                                                        decorationColor: kRed,
                                                        decorationThickness: 3,
                                                        fontSize: 10,
                                                        fontFamily: poppinLight,
                                                        height: 2),
                                                      textAlign: TextAlign.left),
                                                    const SizedBox(width: 5),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 06),
                                                      child: Text("RM",  textAlign: TextAlign.left,
                                                          style: TextStyle(color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                                    ),
                                                    Text("${evCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}",
                                                        textAlign: TextAlign.left, style: TextStyle(
                                                          color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                                    Text("/Month", textAlign: TextAlign.left, style: TextStyle(
                                                            color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                                    SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                                                    showRatingStars(double.parse("${evCarsModelObject.data![index].rating}")),
                                                    // Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                                    SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                                                    evCarsModelObject.data![index].rating == null
                                                        ? Text("0.0", style: TextStyle(color: kBlack, fontSize: 12,
                                                        fontFamily: poppinRegular), textAlign: TextAlign.left) :
                                                    Text("${evCarsModelObject.data![index].rating}",
                                                        style: TextStyle(color: kBlack, fontSize: 12,
                                                            fontFamily: poppinRegular), textAlign: TextAlign.left),
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
                                                        child: Text("New",  textAlign: TextAlign.left,
                                                            style: TextStyle(color: kWhite,
                                                                fontSize: 8, fontFamily: poppinRegular)),
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("clickedddd");
                                      carID = evCarsModelObject.data![index].carsId;
                                      Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => EVCarDescription(
                                                carName: evCarsModelObject.data![index].vehicalName,
                                                carYear: "${evCarsModelObject.data![index].year}",
                                                carId: evCarsModelObject.data![index].carsId,
                                                carColorName: evCarsModelObject.data![index].carsColors!.name,
                                                carMakesName: evCarsModelObject.data![index].carsMakes!.name,
                                                carModelName: evCarsModelObject.data![index].carsModels!.name,
                                                carImage: "$baseUrlImage${evCarsModelObject.data![index].image1}",
                                                carRating: evCarsModelObject.data![index].rating,
                                                carMakesImage: "$baseUrlImage${evCarsModelObject.data![index].carsMakes!.image}",
                                                carStatus: evCarsModelObject.data![index].favouriteStatus,
                                                discountPercentage: evCarsModelObject.data![index].discountPercentage,
                                                carDiscountPrice: double.parse("${evCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}"),
                                                carPrice: evCarsModelObject.data![index].carsPlans![0].pricePerMonth,
                                                carOwnerImage: "$baseUrlImage${evCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                                carOwnerName: "${evCarsModelObject.data![index].usersCompanies!.companyName}",
                                                carOwnerId: evCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                                myCarDescription: evCarsModelObject.data![index].description,
                                                myCarRating: evCarsModelObject.data![index].carsRatings![0].rateStars,
                                                myCarComment: evCarsModelObject.data![index].carsRatings![0].comments,

                                                // evDatum: evSubscriptionCarsModelObject.data![index],
                                              )));
                                      print("evCarName ${evCarsModelObject.data![index].vehicalName}");
                                      print("evCarYear ${evCarsModelObject.data![index].year}");
                                      print("evCarImage $baseUrlImage${evCarsModelObject.data![index].image1}");
                                      print("ownerImage $baseUrlImage${evCarsModelObject.data![index].usersCompanies!.companyLogo}");
                                      print("ownerName ${evCarsModelObject.data![index].usersCompanies!.companyName}");
                                      print("ownerId ${evCarsModelObject.data![index].usersCompanies!.usersCompaniesId}");

                                    },
                                    child: Image.asset("assets/car_bookings_images/more_button.png"),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              top: 10,
                              left: 10, right: 10,
                              child: evCarsModelObject.data![index].image1 == null ?
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/icon/fade_in_image.jpeg')) :
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                                  height: 130, width: 350,
                                  image: NetworkImage("$baseUrlImage${evCarsModelObject.data![index].image1}"),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 10,
                                left: 10,
                                child: Container(
                                  height: MediaQuery.of(context).size.width * 0.07,
                                  width: MediaQuery.of(context).size.width * 0.18,
                                  decoration: BoxDecoration(
                                    color: kRed.withOpacity(0.8),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${evCarsModelObject.data![index].discountPercentage}",
                                          textAlign: TextAlign.left, style: TextStyle(color: kWhite,
                                              fontSize: 13, fontFamily: poppinSemiBold)),
                                      Text(" OFF ", textAlign: TextAlign.left, style: TextStyle(
                                          color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                                    ],
                                  ),
                                )),
                            Positioned(
                              top: 15,
                              right: 15,
                              child: evCarsModelObject.data![index].favouriteStatus == "like"?
                              Image.asset("assets/home_page/heart.png"):
                            GestureDetector(
                                onTap: () async {
                                  myCurrentCarIndex = "${evCarsModelObject.data![index].carsId}";
                                  print("evCarIds $myCurrentCarIndex");
                                  await getLikeUnlikeCarWidget();
                                  getEvSubscriptionCarsWidget();
                                  if (carLikeUnlikeModelObject.message == "Liked") {
                                    print("isLiked");
                                    toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                                  }
                                  // if (carLikeUnlikeModelObject.message == "Unliked") {
                                  //   print("isUnLiked");
                                  //   toastSuccessMessage("${carLikeUnlikeModelObject.message}", colorGreen);
                                  // }
                                },
                                child: carLikeUnlikeModelObject.message == "Liked"
                                    ? Image.asset("assets/home_page/heart.png")
                                    : Image.asset("assets/car_bookings_images/heart.png"),
                              ),
                            ),
                          ],
                        );
                      }),
      ),
    );
  }

  CarLikeUnlikeModel carLikeUnlikeModelObject = CarLikeUnlikeModel();
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
