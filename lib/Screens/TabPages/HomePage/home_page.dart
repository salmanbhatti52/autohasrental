import 'package:auto_haus_rental_app/Model/Notification/notifications_unread_model.dart';
import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/HomePageModels/top_rented_cars_model.dart';
import '../../../Model/SettingsModel/ProfileModels/get_user_profile_model.dart';
import '../../../Widget/cars_home_widget.dart';
import 'Drawer/Settings/EditProfile/edit_profile_screen.dart';
import 'Filter/filter_screen.dart';
import 'HomePageTopCard/BookForWedding/book_for_wedding_car_description.dart';
import 'HomePageTopCard/EvSubscriptions/ev_car_description.dart';
import 'HomePageTopCard/EvSubscriptions/ev_subscription_page.dart';
import 'TopRented/Driving_Home/home_driving_booking.dart';
import 'HomePageTopCard/home_top_card.dart';
import 'Drawer/drawer_screen.dart';
import 'Notifications/notification_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GetUserProfileModel getUserProfileModelObject = GetUserProfileModel();
  TopRentedCarsModel topRentedCarsModelObject = TopRentedCarsModel();
  NotificationsUnReadModel notificationsUnReadModelObject = NotificationsUnReadModel();
  List<TopRentedCarsModel> topRentedCarsModelObject1 = [];
  SearchModel searchModelObject = SearchModel();
  var searchController = TextEditingController();
  bool loadingP = true;
  List<String> filteredData = [];

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

    }
    // } catch (e) {
    //   print('Error: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  getUserProfileWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in HomePagePrefs is= $userId");
    loadingP = true;
    setState(() {});
    try {
      String apiUrl = getUserProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
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
        getUserProfileModelObject = getUserProfileModelFromJson(responseString);
        print("getUserProfileImageHomePage: $baseUrlImage${getUserProfileModelObject.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileHomePage: ${e.toString()}');
    }
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
    getUnreadNotificationWidget();
    getTopRentedCarsWidget();
    getUserProfileWidget();
    getUnreadNotificationWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: homeBgColor,
      body: loadingP? Center(child: CircularProgressIndicator(color: borderColor)):
      SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      print("clicked");
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  DrawerScreen()));
                    },
                      child: Image.asset("assets/home_page/Side_Menu.png", height: 25, width: 25)),
                  Text("Home",
                    style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kBlack)),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotificationsScreen()));
                        },
                        child: Stack(
                          children: [

                            SvgPicture.asset("assets/home_page/notification_bell.svg"),
                            Positioned(
                              right: 02,
                              left: 04,
                              bottom: 08,
                              child: notificationsUnReadModelObject.data?.length == null? Container():
                              Container(
                                  height: 15, width: 15,
                                  decoration: BoxDecoration(
                                      color: kRed,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Center(
                                      child: Text("${notificationsUnReadModelObject.data!.length}",
                                        style: TextStyle(color: kWhite, fontSize: 10),),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      GestureDetector(
                        onTap: (){
                          Get.to(() =>  EditProfileScreen());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: "$baseUrlImage${getUserProfileModelObject.data?.profilePic}",
                            height: 30, width: 30,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(strokeWidth: 2, value: downloadProgress.progress, color: borderColor,),
                            errorWidget: (context, url, error) => Image.asset("assets/icon/fade_in_image.jpeg"),
                                // Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchCarsWidget();
                            });
                          },
                          controller: searchController,
                          autofocus: false,
                          style: TextStyle(color: borderColor),
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 14.0),
                            hintText: 'Search for Cars',
                            border: InputBorder.none,
                            suffixIcon: searchController.text.isNotEmpty?

                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    searchController.text = '';
                                    print("searchControllerClear ${searchController.text}");
                                  });
                                },
                                child: Icon(Icons.clear, size: 22.0, color: Color(0xffD4DCE1))):
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    // searchCarsWidget();
                                  });
                                },
                                child: Icon(Icons.search, size: 22.0, color: Color(0xffD4DCE1))),
                          ),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(width: 15),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  FilterScreen()));
                    },
                    child: Container(
                      height: 50, width: 50,
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Image.asset("assets/home_page/filter.png")),
                  ),
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 05, vertical: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  homeTopHorizontalCard(context),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Top Rented",
                      style: TextStyle(fontSize: 20, fontFamily: poppinBold, color: kBlack),),
                  ),
                  loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
                  topRentedCars(searchController.text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget topRentedCars(String searchText){
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      color: Colors.transparent,
      child: loadingP ? Center(child: CircularProgressIndicator(color: borderColor)) :
      topRentedCarsModelObject.status != "success" ?  Center(
          child: Text('No Cars Found.', style: TextStyle(fontWeight: FontWeight.bold))):
      searchText.isEmpty?
      GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.25,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          itemCount: topRentedCarsModelObject.data!.length,
          itemBuilder: (BuildContext context, int index) {
            print("topRentedCarsModelObject1 ${topRentedCarsModelObject1.length}");
            carName = topRentedCarsModelObject.data![index].vehicalName;
            print("carName $carName");

            return Padding(
              padding:  EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Positioned(
                    top: 50, left: 0, right: 0,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("${topRentedCarsModelObject.data?[index].vehicalName} ",
                                          style: TextStyle(color: kBlack,
                                              fontSize: 8, fontFamily: poppinBold)),
                                      Padding(
                                        padding:  EdgeInsets.only(top: 4),
                                        child: Text("${topRentedCarsModelObject.data?[index].carsColors!.name} ",
                                            style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RatingBar(
                                          initialRating: double.parse("${topRentedCarsModelObject.data?[index].rating}"),
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 1,
                                          minRating: 0,
                                          itemSize: 18.0,
                                          ignoreGestures: true,
                                          ratingWidget: RatingWidget(
                                              full: Icon(Icons.star, color: borderColor),
                                              half: Icon(
                                                Icons.star_half,
                                                color: borderColor,
                                              ),
                                              empty: Icon(
                                                Icons.star_outline,
                                                color: borderColor,
                                              )),
                                          onRatingUpdate: (value) {}),
                                      topRentedCarsModelObject.data?[index].rating == null
                                          ? Text("0.0", style: TextStyle(
                                          color: kBlack, fontSize: 10, fontFamily: poppinMedium))
                                          : Text("${topRentedCarsModelObject.data?[index].rating}",
                                          style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinMedium)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                children: [
                                  Text("${topRentedCarsModelObject.data?[index].carsMakes?.name}, ",
                                      style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                  Text("${topRentedCarsModelObject.data?[index].carsModels?.name}, ",
                                      style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinSemiBold)),
                                  Text("${topRentedCarsModelObject.data?[index].year} ",
                                      style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                ],
                              ),
                              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                              Divider(),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(top: 04),
                                        child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                            color: kRed, fontSize: 5, fontFamily: poppinLight)),
                                      ),
                                      topRentedCarsModelObject.data?[index].carsUsageType == "EV Subscriptions" ?
                                      originalPriceWidget("${topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerMonth}") :
                                      topRentedCarsModelObject.data?[index].carsUsageType == "Photography" ?
                                      originalPriceWidget("${topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerHour}") :
                                      originalPriceWidget("${topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerSlot}") ,
                                    ],
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(top: 06),
                                        child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                            color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                      ),
                                      topRentedCarsModelObject.data?[index].carsUsageType == "EV Subscriptions" ?
                                      discountedPriceWidget("${topRentedCarsModelObject.data?[index].carsPlans?[0].discountedPricePerMonth}/", "Month"):
                                      topRentedCarsModelObject.data?[index].carsUsageType == "Photography" ?
                                      discountedPriceWidget("${topRentedCarsModelObject.data?[index].carsPlans?[0].discountedPricePerHour}/", "Hour"):
                                      discountedPriceWidget("${topRentedCarsModelObject.data?[index].carsPlans?[0].discountedPricePerSlot}/", "Slot"),
                                    ],
                                  ),
                                ],
                              ),
                               // Divider(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Image.asset("assets/home_page/Promoted.png"),
                              //          SizedBox(width: 05),
                              //         Text("Verified Dealer", textAlign: TextAlign.left,
                              //             style: TextStyle(color: textLabelColor,
                              //                 fontSize: 10, fontFamily: poppinRegular)),
                              //       ],
                              //     ),
                              //     Container(
                              //       height: 17, width: 35,
                              //       decoration: BoxDecoration(
                              //           color: kBlack,
                              //           borderRadius: BorderRadius.circular(10)),
                              //       child: Center(
                              //         child: Text("New", textAlign: TextAlign.left, style: TextStyle(
                              //             color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                              GestureDetector(
                                onTap: () {
                                  carID = topRentedCarsModelObject.data![index].carsId;
                                  print("cardId $carID");
                                  print("carsUsageType ${topRentedCarsModelObject.data?[index].carsUsageType}");

                                  if(topRentedCarsModelObject.data![index].carsUsageType == "EV Subscriptions"){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => EVCarDescription(
                                          carName: topRentedCarsModelObject.data![index].vehicalName,
                                          carPrice: topRentedCarsModelObject.data![index].carsPlans![0].pricePerMonth,
                                          carImage: "$baseUrlImage${topRentedCarsModelObject.data![index].image1}",
                                          carYear: "${topRentedCarsModelObject.data![index].year}",
                                          carId: topRentedCarsModelObject.data![index].carsId,
                                          carRating: topRentedCarsModelObject.data![index].rating,
                                          carColorName: topRentedCarsModelObject.data![index].carsColors!.name,
                                          carMakesName: topRentedCarsModelObject.data![index].carsMakes!.name,
                                          carModelName: topRentedCarsModelObject.data![index].carsModels!.name,
                                          carMakesImage: "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                          carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                          discountPercentage: topRentedCarsModelObject.data![index].discountPercentage,
                                          carDiscountPrice: double.parse("${topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}"),
                                          carOwnerImage: "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                          carOwnerName: "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                          carOwnerId: topRentedCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                          myCarDescription: topRentedCarsModelObject.data![index].description)));
                                  }
                                  else if(topRentedCarsModelObject.data![index].carsUsageType == "Photography"){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => BookForWeddingCarDescription(
                                          carName: topRentedCarsModelObject.data![index].vehicalName,
                                          carYear: "${topRentedCarsModelObject.data![index].year}",
                                          carId: topRentedCarsModelObject.data![index].carsId,
                                          carRating: topRentedCarsModelObject.data![index].rating,
                                          carColorName: topRentedCarsModelObject.data![index].carsColors!.name,
                                          carMakesName: topRentedCarsModelObject.data![index].carsMakes!.name,
                                          carModelName: topRentedCarsModelObject.data![index].carsModels!.name,
                                          carImage: "$baseUrlImage${topRentedCarsModelObject.data![index].image1}",
                                          carMakesImage: "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                          favouriteStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                          discountPercentage: topRentedCarsModelObject.data![index].discountPercentage,
                                          carDiscountPrice: topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerHour,
                                          carPrice: topRentedCarsModelObject.data![index].carsPlans![0].pricePerHour,
                                          carOwnerImage: "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                          carOwnerName: "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                          carOwnerId: topRentedCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                          myCarDescription: topRentedCarsModelObject.data![index].description,
                                        )));
                                  }
                                  else if(topRentedCarsModelObject.data![index].carsUsageType == "Driving Experience"){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => HomeDrivingBooking(
                                          datum: topRentedCarsModelObject.data![index],
                                        )));
                                  }
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.035,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: borderColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Click to see Details", textAlign: TextAlign.left, style: TextStyle(
                                            color: kWhite, fontFamily: poppinMedium, fontSize: 10)),
                                         SizedBox(width: 10),
                                        Image.asset("assets/home_page/more_buttons_home.png")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30, left: 10, right: 10,
                    child: topRentedCarsModelObject.data?[index].image1 == null ?
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/icon/fade_in_image.jpeg')) :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder:  AssetImage("assets/icon/fade_in_image.jpeg"),
                        height: 65,
                        image: NetworkImage("$baseUrlImage${topRentedCarsModelObject.data?[index].image1}"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 03, left: 05,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.065,
                      width: MediaQuery.of(context).size.width * 0.19,
                      decoration: BoxDecoration(
                        color: kRed.withOpacity(0.8),
                        borderRadius:  BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${topRentedCarsModelObject.data?[index].discountPercentage}% ",
                                textAlign: TextAlign.left, style: TextStyle(
                                    color: kWhite, fontSize: 12, fontFamily: poppinSemiBold)),
                            Text("OFF", textAlign: TextAlign.left, style: TextStyle(
                                color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }):

      searchModelObject.data?.length == null?
      Center(child: Text("No Cars Found.", style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500))):
      GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.25,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
          ),
          itemCount: searchModelObject.data?.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Positioned(
                    top: 50, left: 0, right: 0,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.width * 0.47,
                        decoration: BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // Text("${searchModelObject.data?[index].vehicalName} ",
                                      Text("${searchModelObject.data?[index].vehicalName} ",
                                          style: TextStyle(color: kBlack,
                                              fontSize: 8, fontFamily: poppinBold)),
                                      Padding(
                                        padding:  EdgeInsets.only(top: 4),
                                        child: Text("${searchModelObject.data?[index].carsColors?.name} ",
                                            style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [

                                      searchModelObject.data?[index].rating == null?
                                      RatingBar(
                                          // initialRating: double.parse("${searchModelObject.data?[index].rating}"),
                                          initialRating: 0.0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 1,
                                          minRating: 0,
                                          itemSize: 18.0,
                                          ignoreGestures: true,
                                          ratingWidget: RatingWidget(
                                              full: Icon(Icons.star, color: borderColor),
                                              half: Icon(
                                                Icons.star_half,
                                                color: borderColor,
                                              ),
                                              empty: Icon(
                                                Icons.star_outline,
                                                color: borderColor,
                                              )),
                                          onRatingUpdate: (value) {}):
                                      RatingBar(
                                        initialRating: double.parse("${searchModelObject.data?[index].rating}"),
                                          // initialRating: searchModelObject.data?[index].rating,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 1,
                                          minRating: 0,
                                          itemSize: 18.0,
                                          ignoreGestures: true,
                                          ratingWidget: RatingWidget(
                                              full: Icon(Icons.star, color: borderColor),
                                              half: Icon(
                                                Icons.star_half,
                                                color: borderColor,
                                              ),
                                              empty: Icon(
                                                Icons.star_outline,
                                                color: borderColor,
                                              )),
                                          onRatingUpdate: (value) {}),
                                      searchModelObject.data?[index].rating == null
                                          ? Text("0.0", style: TextStyle(
                                          color: kBlack, fontSize: 10, fontFamily: poppinMedium))
                                          : Text("${searchModelObject.data?[index].rating}",
                                          style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinMedium)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Row(
                                children: [
                                  Text("${searchModelObject.data?[index].carsMakes?.name}, ",
                                      style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                  Text("${searchModelObject.data?[index].carsModels?.name}, ",
                                      style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinSemiBold)),
                                  Text("${searchModelObject.data?[index].year} ",
                                      style: TextStyle(color: kBlack, fontSize: 7, fontFamily: poppinRegular)),
                                ],
                              ),
                              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                              Divider(),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(top: 04),
                                        child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                            color: kRed, fontSize: 5, fontFamily: poppinLight)),
                                      ),
                                      searchModelObject.data?[index].carsUsageType == "EV Subscriptions" ?
                                      originalPriceWidget("${searchModelObject.data?[index].carsPlans![0].pricePerMonth}") :
                                      searchModelObject.data?[index].carsUsageType == "Photography" ?
                                      originalPriceWidget("${searchModelObject.data?[index].carsPlans![0].pricePerHour}") :
                                      originalPriceWidget("${searchModelObject.data?[index].carsPlans![0].pricePerSlot}") ,
                                    ],
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:  EdgeInsets.only(top: 06),
                                        child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                            color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                      ),
                                      searchModelObject.data?[index].carsUsageType == "EV Subscriptions" ?
                                      discountedPriceWidget("${searchModelObject.data?[index].carsPlans?[0].discountedPricePerMonth}/", "Month"):
                                      searchModelObject.data?[index].carsUsageType == "Photography" ?
                                      discountedPriceWidget("${searchModelObject.data?[index].carsPlans?[0].discountedPricePerHour}/", "Hour"):
                                      discountedPriceWidget("${searchModelObject.data?[index].carsPlans?[0].discountedPricePerSlot}/", "Slot"),
                                    ],
                                  ),
                                ],
                              ),

                              // Divider(),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Image.asset("assets/home_page/Promoted.png"),
                              //         SizedBox(width: 05),
                              //         Text("Verified Dealer", textAlign: TextAlign.left,
                              //             style: TextStyle(color: textLabelColor,
                              //                 fontSize: 10, fontFamily: poppinRegular)),
                              //       ],
                              //     ),
                              //     Container(
                              //       height: 17, width: 35,
                              //       decoration: BoxDecoration(
                              //           color: kBlack,
                              //           borderRadius: BorderRadius.circular(10)),
                              //       child: Center(
                              //         child: Text("New", textAlign: TextAlign.left, style: TextStyle(
                              //             color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                              GestureDetector(
                                onTap: () {
                                  carID = searchModelObject.data?[index].carsId;
                                  print("cardId $carID");
                                  print("carsUsageType ${searchModelObject.data![index].carsUsageType}");

                                  if(topRentedCarsModelObject.data![index].carsUsageType == "EV Subscriptions"){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => EVCarDescription(
                                          carName: topRentedCarsModelObject.data![index].vehicalName,
                                          carPrice: topRentedCarsModelObject.data![index].carsPlans![0].pricePerMonth,
                                          carImage: "$baseUrlImage${topRentedCarsModelObject.data![index].image1}",
                                          carYear: "${topRentedCarsModelObject.data![index].year}",
                                          carId: topRentedCarsModelObject.data![index].carsId,
                                          carRating: topRentedCarsModelObject.data![index].rating,
                                          carColorName: topRentedCarsModelObject.data![index].carsColors!.name,
                                          carMakesName: topRentedCarsModelObject.data![index].carsMakes!.name,
                                          carModelName: topRentedCarsModelObject.data![index].carsModels!.name,
                                          carMakesImage: "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                          carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                          discountPercentage: topRentedCarsModelObject.data![index].discountPercentage,
                                          carDiscountPrice: double.parse("${topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerMonth}"),
                                          carOwnerImage: "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                          carOwnerName: "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                          carOwnerId: topRentedCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                          myCarDescription: topRentedCarsModelObject.data![index].description,
                                          myCarRating: topRentedCarsModelObject.data![index].carsRatings![0].rateStars,
                                          myCarComment: topRentedCarsModelObject.data![index].carsRatings![0].comments,
                                        )));
                                  }
                                  else if(topRentedCarsModelObject.data![index].carsUsageType == "Photography"){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => BookForWeddingCarDescription(
                                          carName: topRentedCarsModelObject.data![index].vehicalName,
                                          carYear: "${topRentedCarsModelObject.data![index].year}",
                                          carId: topRentedCarsModelObject.data![index].carsId,
                                          carRating: topRentedCarsModelObject.data![index].rating,
                                          carColorName: topRentedCarsModelObject.data![index].carsColors!.name,
                                          carMakesName: topRentedCarsModelObject.data![index].carsMakes!.name,
                                          carModelName: topRentedCarsModelObject.data![index].carsModels!.name,
                                          carImage: "$baseUrlImage${topRentedCarsModelObject.data![index].image1}",
                                          carMakesImage: "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                          favouriteStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                          discountPercentage: topRentedCarsModelObject.data![index].discountPercentage,
                                          carDiscountPrice: topRentedCarsModelObject.data![index].carsPlans![0].discountedPricePerHour,
                                          carPrice: topRentedCarsModelObject.data![index].carsPlans![0].pricePerHour,
                                          carOwnerImage: "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                          carOwnerName: "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                          carOwnerId: topRentedCarsModelObject.data![index].usersCompanies!.usersCompaniesId,
                                          myCarDescription: topRentedCarsModelObject.data![index].description,
                                          myCarRating: topRentedCarsModelObject.data![index].rating,
                                          // myCarRating: topRentedCarsModelObject.data![index].carsRatings![0].rateStars,
                                          // myCarComment: topRentedCarsModelObject.data![index].carsRatings![0].comments,
                                        )));
                                  }
                                  else if(topRentedCarsModelObject.data![index].carsUsageType == "Driving Experience"){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => HomeDrivingBooking(
                                          datum: topRentedCarsModelObject.data![index],
                                        )));
                                  }
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.035,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: borderColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Click to see Details", textAlign: TextAlign.left, style: TextStyle(
                                            color: kWhite, fontFamily: poppinMedium, fontSize: 10)),
                                        SizedBox(width: 10),
                                        Image.asset("assets/home_page/more_buttons_home.png")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30, left: 10, right: 10,
                    child: searchModelObject.data?[index].image1 == null ?
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/icon/fade_in_image.jpeg')) :
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder:  AssetImage("assets/icon/fade_in_image.jpeg"),
                        height: 65,
                        image: NetworkImage("$baseUrlImage${searchModelObject.data?[index].image1}"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 03, left: 05,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.065,
                      width: MediaQuery.of(context).size.width * 0.19,
                      decoration: BoxDecoration(
                        color: kRed.withOpacity(0.8),
                        borderRadius:  BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${searchModelObject.data?[index].discountPercentage}% ",
                                textAlign: TextAlign.left, style: TextStyle(
                                    color: kWhite, fontSize: 12, fontFamily: poppinSemiBold)),
                            Text("OFF", textAlign: TextAlign.left, style: TextStyle(
                                color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
            // Center(child: Text("No cars Available...", style: TextStyle(
            //     fontSize: 15, fontWeight: FontWeight.w500)));
          }),

    );
  }

  Widget priceWidget(originalPrice){
    return Padding(
      padding:  EdgeInsets.only(top: 04),
      child: Text("$originalPrice",
          textAlign: TextAlign.left, style: TextStyle(
              color: kRed, decoration: TextDecoration.lineThrough,
              fontSize: 8, fontFamily: poppinLight)),
    );
  }
  Widget discountedPriceWidget(price, typeText){
    return  Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 04),
          child: Text("$price",
              textAlign: TextAlign.left, style: TextStyle(
                  fontSize: 12, fontFamily: poppinBold, color: borderColor)),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 5),
          child: Text(typeText, textAlign: TextAlign.left, style: TextStyle(
              color: borderColor, fontSize: 8, fontFamily: poppinSemiBold)),
        ),
      ],
    );
  }
}
