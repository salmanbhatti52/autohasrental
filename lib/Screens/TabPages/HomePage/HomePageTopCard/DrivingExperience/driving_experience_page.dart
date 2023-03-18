import 'package:auto_haus_rental_app/Model/HomePageModels/FavoritesModel/like_unlike_model.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';
import 'package:auto_haus_rental_app/Model/get_car_makes_model.dart';
import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/HomePageModels/HomeTopWidgetModels/driving_cars_model.dart';
import '../../TopRented/Driving_Home/home_driving_booking.dart';
import '../EvSubscriptions/ev_subscription_page.dart';
import 'driving_details_page.dart';
import 'package:http/http.dart' as http;

DrivingCarsModel drivingCarsModelObject = DrivingCarsModel();
class DrivingExperiencePage extends StatefulWidget {
  DrivingExperiencePage({Key? key}) : super(key: key);

  @override
  State<DrivingExperiencePage> createState() => _DrivingExperiencePageState();
}

class _DrivingExperiencePageState extends State<DrivingExperiencePage> with TickerProviderStateMixin {
  DrivingCarsModel drivingCarsModelObject = DrivingCarsModel();
  LikeUnlikeCarModel carLikeUnlikeModelObject = LikeUnlikeCarModel();
  SearchModel searchModelObject = SearchModel();
  var searchController = TextEditingController();
  String? myCurrentCarIndex;
  bool loadingP = true;
  searchCarsWidget() async {
    // try {
    String apiUrl = getCarFilterByNameApiUrl;
    if(searchController.text.isNotEmpty){
      print("searchControllerValue ${searchController.text}");
      searchModelObject.data?.clear();
      print("searchApiUrl $apiUrl");
      print("userId $userId");
      final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            "users_customers_id": userId,
            "keyword": searchController.text
          },
          headers: {
            'Accept': 'application/json'
          });
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseString $responseString");
        searchModelObject = searchModelFromJson(responseString);
        setState(() {});
        print("searchItemsLengthHomePage: ${searchModelObject.data?.length}");
      }
    }

    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
  }

  @override
  void initState() {
    super.initState();
    getCarMakesListWidget();
    selectedIndex = 0;
  }
  int? selectedCarMakesId, evCarMakesId;
  String? selectedCarMakesName;

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
      getDrivingExperienceCarsWidget();
    });
  }

  getDrivingExperienceCarsWidget() async {
    // loadingP = true;
    // setState(() {});
    selectedCarMakesId ?? (selectedCarMakesId = 1);
    // try {
      String apiUrl = carDrivingExperienceApiUrl;
      print("drivingCarsApi: $apiUrl");
      print("userId: $userId");
      print("selectedCarMakesId: $selectedCarMakesId");
      final response = await http.post(Uri.parse(apiUrl),
          body: {
            "users_customers_id" : userId,
            "cars_makes_id": "$selectedCarMakesId"
          },
          headers: {'Accept': 'application/json'});
      print('${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("drivingCarsResponse: ${responseString.toString()}");
        loadingP = false;
        setState(() {});
        drivingCarsModelObject = drivingCarsModelFromJson(responseString);
        print("drivingCarsLength123: ${drivingCarsModelObject.data?.length}");
      }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    // loadingP = false;
    // setState(() {});
  }

  TopRentedCarsModel topRentedCarsModelObject = TopRentedCarsModel();
  getTopRentedCarsWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    print('in topRenterCarModelApi');
    // try {
    String apiUrl = topRentedCarsApiUrl;
    print("topRenterCarModelApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl),
        body: {
          "users_customers_id" : userId
        },
        headers: {
          'Accept': 'application/json'
        });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("topRenterCarResponse : ${responseString.toString()}");
      topRentedCarsModelObject = topRentedCarsModelFromJson(responseString);
      print("topRentedCarsLength: ${topRentedCarsModelObject.data!.length}");
      for(int i = 0; i<topRentedCarsModelObject.data!.length; i++){
        if(carID == topRentedCarsModelObject.data![i].carsId) {
          print("cariddd $carID ${topRentedCarsModelObject.data![i].carsId}");
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeDrivingBooking(
                datum: topRentedCarsModelObject.data![i],
              )));
          break;
        }
      }

    }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   MyAppBarDoubleImage(
          frontImage: "assets/home_page/back_arrow.png",
          title: "Driving Experiences",
          backImage: "assets/home_page/notification_bell.svg"),
      backgroundColor: homeBgColor,
      body: loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
      SingleChildScrollView(
        physics:   BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            carMakersListWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text("Top Experiences",
                      textAlign: TextAlign.left, style: TextStyle(
                        fontSize: 16, fontFamily: poppinBold, color: kBlack)),
                ),
                 topExperienceWidget(searchController.text),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text("Other Best Experiences",
                    style: TextStyle(
                        fontSize: 16, fontFamily: poppinBold, color: kBlack),
                    textAlign: TextAlign.left,
                  ),
                ),
                allDrivingItems(searchController.text),
              ],
            ),
          ],
        ),
      ),
    );
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
      print('Error in drivingExperience carLikeUnlike: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  carMakersListWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 08),
      child: Container(
        height: MediaQuery.of(context).size.height* 0.1,
        color: Colors.transparent,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: getCarMakesModelObject.data!.length,
            itemBuilder: (context, index){
              return Padding(
                padding:   EdgeInsets.all(8.0),
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
                      getDrivingExperienceCarsWidget();
                    });
                  },
                  child: Container(
                    height: 50, width: 70,
                    decoration: BoxDecoration(
                        color: selectedIndex == index? borderColor: kWhite,
                        border: Border.all(width: 2,
                            color: selectedIndex == index ? borderColor : kWhite),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image.network("$baseUrlImage${getCarMakesModelObject.data![index].image}",
                        height: 25, width: 25, fit: BoxFit.fill),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget topExperienceWidget(String searchText) {
    return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
    drivingCarsModelObject.status != "success" ?
      Center(child: Text('No cars Available',
      style: TextStyle(fontWeight: FontWeight.bold))) :
    Container(
      height: 250,
      width: double.infinity,
      color: Colors.transparent,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: drivingCarsModelObject.data!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            evCarMakesId = drivingCarsModelObject.data?[index].carsMakes?.carsMakesId;
            return Padding(
              padding: EdgeInsets.only(left: 20),
              child: Container(
                color: Colors.transparent,
                height: 250,
                width: 230,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.285,
                        width: MediaQuery.of(context).size.width * 0.55,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding:   EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("${drivingCarsModelObject.data![index].vehicalName} ",
                                          style: TextStyle(color: kBlack,
                                              fontSize: 14, fontFamily: poppinBold),
                                          textAlign: TextAlign.left),
                                      Text("${drivingCarsModelObject.data![index].carsColors!.name}",
                                          style: TextStyle(color: kBlack,
                                              fontSize: 10, fontFamily: poppinRegular),
                                          textAlign: TextAlign.left),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                  Row(
                                    children: [
                                      Text("${drivingCarsModelObject.data![index].carsMakes!.name}, ",
                                          style: TextStyle(color: kBlack,
                                              fontSize: 10, fontFamily: poppinRegular),
                                          textAlign: TextAlign.left),
                                      Text("${drivingCarsModelObject.data![index].carsModels!.name}, ",
                                          style: TextStyle(color: kBlack,
                                              fontSize: 10, fontFamily: poppinSemiBold),
                                          textAlign: TextAlign.left),
                                      Text("${drivingCarsModelObject.data![index].year} ",
                                          style: TextStyle(color: kBlack,
                                              fontSize: 10, fontFamily: poppinRegular),
                                          textAlign: TextAlign.left),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Divider(),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:   EdgeInsets.only(top: 04),
                                            child: Text("RM",  textAlign: TextAlign.left,
                                                style: TextStyle(color: kRed,
                                                    fontSize: 5, fontFamily: poppinLight)),
                                          ),
                                          Text("${drivingCarsModelObject.data![index].carsPlans![0].pricePerSlot}",
                                            style: TextStyle(
                                                color: kRed,
                                                decoration: TextDecoration.lineThrough,
                                                decorationColor: kRed,
                                                decorationThickness: 3,
                                                fontSize: 10,
                                                fontFamily: poppinLight,
                                                height: 2),
                                            textAlign: TextAlign.left,),
                                          SizedBox(width: MediaQuery.of(context).size.height * 0.005),

                                          Text("${drivingCarsModelObject.data![index].carsPlans![0].discountedPricePerSlot}",
                                            style: TextStyle(
                                              color: borderColor,
                                              decorationThickness: 3,
                                              fontSize: 14,
                                              fontFamily: poppinSemiBold,),
                                            textAlign: TextAlign.left,),
                                          Text("/Slot",
                                            style: TextStyle(color: kBlack,
                                                fontSize: 8, fontFamily: poppinRegular),
                                            textAlign: TextAlign.left,),
                                        ],
                                      ),
                                    ],
                                  ),
                                    Divider(),
                                  Row(
                                    children: [
                                      showRatingStars(double.parse("${drivingCarsModelObject.data![index].rating}")),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.height * 0.01,),
                                      drivingCarsModelObject.data![index].rating == null
                                          ? Text("0.0", style: TextStyle(color: kBlack,
                                          fontSize: 10, fontFamily: poppinMedium),
                                        textAlign: TextAlign.left,)
                                          : Text("${drivingCarsModelObject.data![index].rating}",
                                        style: TextStyle(color: kBlack,
                                            fontSize: 10, fontFamily: poppinMedium),
                                        textAlign: TextAlign.left,),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                  GestureDetector(
                                    onTap: () {
                                      carID = drivingCarsModelObject.data![index].carsId;
                                      print("selectedCarId $carID");
                                      getTopRentedCarsWidget();
                                      // Navigator.push(context, MaterialPageRoute(
                                      //     builder: (context) => DrivingDetailsPage(
                                      //       datum: drivingCarsModelObject.data![index],
                                      //     )));
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: borderColor,
                                          borderRadius: BorderRadius.circular(30)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Click to see Details",
                                              style: TextStyle(color: Colors.white,
                                                  fontFamily: poppinMedium, fontSize: 10),
                                              textAlign: TextAlign.left),
                                            SizedBox(width: 10,),
                                          Image.asset("assets/home_page/more_buttons_home.png")
                                        ],
                                      ),
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
                      left: 1,
                      right: 16,
                      child: drivingCarsModelObject.data![index].image1 == null
                          ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/icon/fade_in_image.jpeg'))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder:   AssetImage("assets/icon/fade_in_image.jpeg"),
                          // width: 350,
                          height: 80,
                          image: NetworkImage("$baseUrlImage${drivingCarsModelObject.data![index].image1}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget allDrivingItems(String searchText) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      color: Colors.transparent,
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
      drivingCarsModelObject.status != "success" ? Center(
        child: Column(
          children: [
            Text('No cars Available', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ):
      ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: drivingCarsModelObject.data?.length,
          itemBuilder: (BuildContext context, int index) {
            evCarMakesId = drivingCarsModelObject.data?[index].carsMakes?.carsMakesId;
            return Stack(
              children: [
                Padding(
                  padding:   EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.33
                  )
                ),
                Positioned(
                  top: 90,
                  child: Padding(
                    padding:   EdgeInsets.only(left: 9),
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
                            offset:   Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Row(
                            children: [
                                SizedBox(height: 93.6),
                              Padding(
                                padding:   EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${drivingCarsModelObject.data![index].vehicalName} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                                        Text("${drivingCarsModelObject.data![index].carsColors!.name}",
                                            style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinRegular),
                                            textAlign: TextAlign.left),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("${drivingCarsModelObject.data![index].carsMakes!.name}, ",
                                            style: TextStyle(color: kBlack,
                                                fontSize: 12, fontFamily: poppinRegular),
                                            textAlign: TextAlign.left),
                                        Text("${drivingCarsModelObject.data![index].carsModels!.name}, ",
                                            style: TextStyle(color: kBlack,
                                                fontSize: 12, fontFamily: poppinSemiBold),
                                            textAlign: TextAlign.left),
                                        Text("${drivingCarsModelObject.data![index].year} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Row(
                                      children: [
                                        Padding(
                                          padding:   EdgeInsets.only(top: 04),
                                          child: Text("RM",  textAlign: TextAlign.left,                                                       style: TextStyle(
                                              color: kRed, fontSize: 5, fontFamily: poppinRegular)),
                                        ),
                                        Text("${drivingCarsModelObject.data![index].carsPlans![0].pricePerSlot}",
                                            style: TextStyle(color: kRed,
                                                decoration: TextDecoration.lineThrough,
                                                decorationColor: kRed,
                                                decorationThickness: 3,
                                                fontSize: 10,
                                                fontFamily: poppinLight,
                                                height: 2),
                                            textAlign: TextAlign.left),
                                          SizedBox(width: 5),
                                        Padding(
                                          padding:   EdgeInsets.only(top: 06),
                                          child: Text("RM", textAlign: TextAlign.left, style: TextStyle(
                                              color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                        ),
                                        Text("${drivingCarsModelObject.data![index].carsPlans![0].discountedPricePerSlot}",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
                                        Text("/Slot", textAlign: TextAlign.left, style: TextStyle(
                                            color: kBlack, fontSize: 8, fontFamily: poppinRegular),
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                        showRatingStars(double.parse("${drivingCarsModelObject.data![index].rating}")),
                                        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                        drivingCarsModelObject.data![index].rating == null ?
                                        Text("0.0", textAlign: TextAlign.left, style: TextStyle(
                                            color: kBlack, fontSize: 10, fontFamily: poppinMedium))
                                            : Text("${drivingCarsModelObject.data![index].rating}",
                                          textAlign: TextAlign.left, style: TextStyle(
                                              color: kBlack, fontSize: 12, fontFamily: poppinRegular),
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
                  child: GestureDetector(
                    onTap: () {
                      carID = drivingCarsModelObject.data![index].carsId;
                      print("selectedCarId $carID");
                      getTopRentedCarsWidget();
                      //
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context) => DrivingDetailsPage(
                      //         datum: drivingCarsModelObject.data![index])));
                      print("carPlanSelected ${drivingCarsModelObject.data![index].carsPlans![index]}");
                    },
                    child: Image.asset("assets/car_bookings_images/more_button.png"),
                  ),
                ),
                Positioned(
                  top: 40, left: 20, right: 20,
                  child: drivingCarsModelObject.data![index].image1 == null ?
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset('assets/icon/fade_in_image.jpeg')) :
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage(
                      placeholder:   AssetImage("assets/icon/fade_in_image.jpeg"),
                      height: 130, width: 350,
                      image: NetworkImage("$baseUrlImage${drivingCarsModelObject.data![index].image1}"),
                    ),
                  ),
                ),
                Positioned(
                    top: 10, left: 15,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.07,
                      width: MediaQuery.of(context).size.width * 0.16,
                      decoration: BoxDecoration(
                        color: kRed.withOpacity(0.8),
                        borderRadius:   BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${drivingCarsModelObject.data![index].discountPercentage}",
                              textAlign: TextAlign.left, style: TextStyle(
                                  color: kWhite, fontSize: 13, fontFamily: poppinSemiBold)),
                          Text(" OFF ", textAlign: TextAlign.left,
                              style: TextStyle(color: kWhite,
                                  fontSize: 8, fontFamily: poppinRegular)),
                        ],
                      ),
                    )),
                Positioned(
                  top: 10, right: 15,
                  child: drivingCarsModelObject.data![index].favouriteStatus == "like"?
                  Image.asset("assets/home_page/heart.png"):
                  GestureDetector(
                    onTap: () async {
                      myCurrentCarIndex = "${drivingCarsModelObject.data![index].carsId}";
                      print("drivingExperienceCarId $myCurrentCarIndex");
                      await getLikeUnlikeCarWidget();
                      getDrivingExperienceCarsWidget();
                    },
                    child: Image.asset("assets/car_bookings_images/heart.png"),),
                ),
              ],
            );
          }),
    );
  }
}
