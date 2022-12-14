import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/HomePageModels/FavoritesModel/car_favorite_like_unlike_model.dart';
import '../../../../../Model/HomePageModels/HomePageTopWidgetModels/ev_subscription_cars_model.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/constants.dart';
import '../../../../../Utils/fontFamily.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import '../../Filter/filter_screen.dart';
import 'package:http/http.dart' as http;
import 'ev_car_description.dart';

class EvSubscriptionPage extends StatefulWidget {
  const EvSubscriptionPage({Key? key}) : super(key: key);

  @override
  State<EvSubscriptionPage> createState() => _EvSubscriptionPageState();
}

class _EvSubscriptionPageState extends State<EvSubscriptionPage> {
  EvSubscriptionCarsModel evSubscriptionCarsModelObject = EvSubscriptionCarsModel();

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  String? myCurrentCarIndex;
  bool loadingP = true;

  sharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in LoginPage shared prefs');
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in Prefs is = $userId");
    getEvSubscriptionCarsWidget();
    getLikeUnlikeCarWidget();
  }

  getEvSubscriptionCarsWidget() async {
    loadingP = true;
    setState(() {});
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
      }
    } catch (e) {
      print('Error in evSubscription: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
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
          allEvSubscriptionItemsList(),
        ],
      ),
    );
  }

  Widget allEvSubscriptionItemsList() {
    return SingleChildScrollView(
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
          : evSubscriptionCarsModelObject.status != "success" ?
      const Center(child: Text('no data found...',
          style: TextStyle(fontWeight: FontWeight.bold)))
              : Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.78,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: evSubscriptionCarsModelObject.data!.length,
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
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                      color: Colors.transparent,
                                                      child: Text("${evSubscriptionCarsModelObject.data![index].vehicalName} | ",
                                                        style: TextStyle(color: kBlack, fontSize: 14,
                                                            fontFamily: poppinBold), textAlign: TextAlign.left),
                                                    ),
                                                    Text("MODEL ", textAlign: TextAlign.left,
                                                        style: TextStyle(color: kBlack,
                                                          fontSize: 12, fontFamily: poppinRegular)),
                                                    Text("${evSubscriptionCarsModelObject.data![index].carsModels!.name} ",
                                                        textAlign: TextAlign.left, style: TextStyle(
                                                          color: kBlack, fontSize: 14, fontFamily: poppinMedium),),
                                                    Text("${evSubscriptionCarsModelObject.data![index].year}",
                                                        textAlign: TextAlign.left, style: TextStyle(
                                                          color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 04),
                                                      child: Text("RM",  textAlign: TextAlign.left,
                                                          style: TextStyle(color: kRed, fontSize: 5, fontFamily: poppinRegular),),
                                                    ),
                                                    Text("${evSubscriptionCarsModelObject.data![index].carsPlans![0].pricePerMonth}",
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
                                                    Text("${evSubscriptionCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}",
                                                        textAlign: TextAlign.left, style: TextStyle(
                                                          color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                                    Text("/ Month", textAlign: TextAlign.left, style: TextStyle(
                                                            color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                                    SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                                                    Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                                    SizedBox(width: MediaQuery.of(context).size.height * 0.01,),
                                                    evSubscriptionCarsModelObject.data![index].rating == null
                                                        ? Text("0.0", style: TextStyle(color: kBlack, fontSize: 12,
                                                        fontFamily: poppinRegular), textAlign: TextAlign.left) :
                                                    Text("${evSubscriptionCarsModelObject.data![index].rating}",
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
                                      Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => EVCarDescription(
                                                carName: evSubscriptionCarsModelObject.data![index].vehicalName,
                                                carYear: evSubscriptionCarsModelObject.data![index].year,
                                                carImage: "$baseUrlImage${evSubscriptionCarsModelObject.data![index].image1}",
                                                carRating: "${evSubscriptionCarsModelObject.data![index].rating}",
                                                carDescription: "${evSubscriptionCarsModelObject.data![index].description}",
                                              )));
                                      print("evCarName ${evSubscriptionCarsModelObject.data![index].vehicalName}");
                                      print("evCarYear ${evSubscriptionCarsModelObject.data![index].year}");
                                      print("evCarImage $baseUrlImage${evSubscriptionCarsModelObject.data![index].image1}");

                                    },
                                    child: Image.asset("assets/car_bookings_images/more_button.png"),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 10,
                                left: 15,
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
                                      Text("${evSubscriptionCarsModelObject.data![index].discountPercentage}",
                                        textAlign: TextAlign.left, style: TextStyle(color: kWhite,
                                              fontSize: 13, fontFamily: poppinSemiBold)),
                                      Text(" OFF ", textAlign: TextAlign.left, style: TextStyle(
                                              color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                                    ],
                                  ),
                                )),
                            Positioned(
                              top: 10,
                              child: evSubscriptionCarsModelObject.data![index].image1 == null ?
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset('assets/icon/fade_in_image.jpeg')) :
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
                                  height: 150,  width: 350,
                                  image: NetworkImage("$baseUrlImage${evSubscriptionCarsModelObject.data![index].image1}"),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 15,
                              child:
                              // evSubscriptionCarsModelObject.data![index].favouriteStatus == "like"?
                              // Image.asset("assets/home_page/heart.png"):
                              GestureDetector(
                                onTap: () async {
                                  myCurrentCarIndex = "${evSubscriptionCarsModelObject.data![index].carsId}";
                                  print("evCarIds $myCurrentCarIndex");
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
        carLikeUnlikeModelObject = carLikeUnlikeModelFromJson(responseString);
        print("carLikeUnlikeModelMessage: ${carLikeUnlikeModelObject.message}");
      }
    } catch (e) {
      print('Error in carLikeUnlike: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }
}
