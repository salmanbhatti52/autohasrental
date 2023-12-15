import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../../../Model/filter_car_by_attribute_model.dart';
import 'Drawer/drawer_screen.dart';
import 'Filter/filter_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomePageTopCard/home_top_card.dart';
import 'Drawer/Settings/settings_screen.dart';
import 'Notifications/notification_screen.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Drawer/Settings/EditProfile/edit_profile_screen.dart';
import 'package:auto_haus_rental_app/Model/search_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'HomePageTopCard/EvSubscriptions/ev_car_description.dart';
import 'package:auto_haus_rental_app/Widget/cars_home_widget.dart';
import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';
import 'package:auto_haus_rental_app/Model/Notification/notifications_unread_model.dart';
import 'package:auto_haus_rental_app/Model/SettingsModel/ProfileModels/get_user_profile_model.dart';

class HomePage extends StatefulWidget {
  FilterCarByAttributeModel? filterCarByAttributeModelObject;
  bool? clearFilters;
  HomePage({Key? key, this.filterCarByAttributeModelObject, this.clearFilters}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationsUnReadModel notificationsUnReadModelObject =
      NotificationsUnReadModel();
  GetUserProfileModel getUserProfileModelObject = GetUserProfileModel();
  TopRentedCarsModel topRentedCarsModelObject = TopRentedCarsModel();
  var searchController = TextEditingController();
  SearchModel searchModelObject = SearchModel();

  List<String> filteredData = [];
  bool loadingP = false;

  searchCarsWidget() async {
    String apiUrl = getCarFilterByNameApiUrl;
    if (searchController.text.isNotEmpty) {
      print("searchControllerValue ${searchController.text}");
      searchModelObject.data?.clear();
      print("searchApiUrl $apiUrl");
      print("userId $userId");
      final response = await http.post(Uri.parse(apiUrl), body: {
        "users_customers_id": userId,
        "keyword": searchController.text
      }, headers: {
        'Accept': 'application/json'
      });
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseString $responseString");
        searchModelObject = searchModelFromJson(responseString);
        setState(() {
        });
        print("searchItemsLengthHomePage: ${searchModelObject.data?.length}");
      }
    }
  }

  getTopRentedCarsWidget() async {
    loadingP = true;
    setState(() {});
      prefs = await SharedPreferences.getInstance();
      userId = prefs!.getString('userid');
      print("users_customers_id: $userId");
    prefs = await SharedPreferences.getInstance();
    print('in topRenterCarModelApi');
    String apiUrl = topRentedCarsApiUrl;
    print("topRenterCarModelApi: $apiUrl");
    print("users_customers_id: $userId");
    final response = await http.post(Uri.parse(apiUrl),
        body: {"users_customers_id": userId},
        headers: {'Accept': 'application/json'});
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      loadingP = false;
      setState(() {});
      print("topRenterCarResponse : ${responseString.toString()}");
      topRentedCarsModelObject = topRentedCarsModelFromJson(responseString);
      print("topRentedCarsLength: ${topRentedCarsModelObject.data?.length}");
    }
  }

  getUserProfileWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in HomePagePrefs is= $userId");
    try {
      String apiUrl = getUserProfileApiUrl;
      print("getUserProfileApi: $apiUrl");
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
        getUserProfileModelObject = getUserProfileModelFromJson(responseString);
        print(
            "getUserProfileImageHomePage: $baseUrlImage${getUserProfileModelObject.data!.profilePic}");
      }
    } catch (e) {
      print('Error in getUserProfileHomePage: ${e.toString()}');
    }
    setState(() {});
  }

  getUnreadNotificationWidget() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userid');
    print("userId in HomePagePrefs is= $userId");
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
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();
    loadData();
    print("notificationStatusHome $notificationStatus");
  }

  void loadData() async {
    await getTopRentedCarsWidget();
    await getUnreadNotificationWidget();
    await getUserProfileWidget();
  }

  sharedPrefs() async {
    print('in HomePage sharedPrefs');
    prefs = await SharedPreferences.getInstance();
    notificationStatus = (prefs!.getString('notification_status'));
    print("notificationStatus in HomePage sharedPrefs $notificationStatus");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        print("clicked");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrawerScreen()));
                      },
                      child: Image.asset("assets/home_page/Side_Menu.png",
                          height: 25, width: 25)),
                  Text("Home",
                      style: TextStyle(
                          fontSize: 20, fontFamily: poppinBold, color: kBlack)),
                  Row(
                    children: [
                      notificationStatus == "Yes"
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationsScreen()));
                              },
                              child: Stack(
                                children: [
                                  SvgPicture.asset(
                                      "assets/home_page/notification_bell.svg"),
                                  Positioned(
                                    right: 02,
                                    left: 05,
                                    bottom: 10,
                                    child: notificationsUnReadModelObject
                                                .data ==
                                            null
                                        ? Container()
                                        : Container(
                                            height: 12,
                                            width: 12,
                                            decoration: BoxDecoration(
                                                color: kRed,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                              child: Text(
                                                "${notificationsUnReadModelObject.data?.length}",
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: 08),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => EditProfileScreen());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl:
                                "$baseUrlImage${getUserProfileModelObject.data?.profilePic}",
                            height: 30, width: 30,
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Center(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchCarsWidget();
                            });
                          },
                          controller: searchController,
                          autofocus: false,
                          style: TextStyle(color: borderColor),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 14.0),
                            hintText: 'Search for Cars',
                            border: InputBorder.none,
                            suffixIcon: searchController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        searchController.text = '';
                                        print(
                                            "searchControllerClear ${searchController.text}");
                                      });
                                    },
                                    child: Icon(Icons.clear,
                                        size: 22.0, color: Color(0xffD4DCE1)))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // searchCarsWidget();
                                      });
                                    },
                                    child: Icon(Icons.search,
                                        size: 22.0, color: Color(0xffD4DCE1))),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilterScreen()));
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
              padding: EdgeInsets.symmetric(horizontal: 05, vertical: 00),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  homeTopHorizontalCard(context),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Text(
                      "Top Rented",
                      style: TextStyle(
                          fontSize: 20, fontFamily: poppinBold, color: kBlack),
                    ),
                  ),

                  loadingP
                      ? Center(child: CircularProgressIndicator(color: borderColor))
                      : widget.clearFilters  == true
                      ?  topRentedCarsModelObject.data != null
                          ? topRentedCars(searchController.text)
                          : Center(
                              child: Text('No Cars Found.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))) : widget.filterCarByAttributeModelObject?.status == "success"
                      ? Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    color: Colors.transparent,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth < 600) {
                          return GridView.builder(
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.25,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemCount: widget.filterCarByAttributeModelObject!.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var pricePerMonthString = widget.filterCarByAttributeModelObject!.data?[index].carsPlans![0].pricePerMonth;
                                double pricePerMonth;
                                String formattedPrice = "";
                                if (pricePerMonthString != null) {
                                  pricePerMonth = double.parse(pricePerMonthString);
                                  if (pricePerMonth != null) {
                                    final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                    formattedPrice = numberFormat.format(pricePerMonth);
                                    // print("RM $formattedPrice");
                                  } else {
                                    print("Invalid price format");
                                  }
                                } else {
                                  print("Price not available");
                                }

                                var discountPricePerMonthString = widget.filterCarByAttributeModelObject!.data?[index].carsPlans![0].discountedPricePerMonth;
                                double discountPricePerMonth;
                                String discountFormattedPrice = "";
                                if (discountPricePerMonthString != null) {
                                  discountPricePerMonth = double.parse(discountPricePerMonthString);
                                  if (discountPricePerMonth != null) {
                                    final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                    discountFormattedPrice = numberFormat.format(discountPricePerMonth);
                                    // print("RM $discountFormattedPrice");
                                  } else {
                                    print("Invalid price format");
                                  }
                                } else {
                                  print("Price not available");
                                }
                                if (index >= 0 && index < widget.filterCarByAttributeModelObject!.data!.length) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 50,
                                          left: 0,
                                          right: 0,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.21,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.47,
                                              decoration: BoxDecoration(
                                                  color: kWhite,
                                                  borderRadius:
                                                  BorderRadius.circular(20)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                        height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.06),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            // Text("${searchModelObject.data?[index].vehicalName} ",
                                                            Container(
                                                              width:
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                                  0.15,
                                                              child: Text(
                                                                  "${widget.filterCarByAttributeModelObject?.data?[index].vehicalName} ",
                                                                  overflow: TextOverflow
                                                                      .ellipsis,
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                      color: kBlack,
                                                                      fontSize: 8,
                                                                      fontFamily:
                                                                      poppinBold)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  top: 4),
                                                              child: Text(
                                                                  "${widget.filterCarByAttributeModelObject?.data?[index].carsColors?.name} ",
                                                                  style: TextStyle(
                                                                      color:
                                                                      kBlack,
                                                                      fontSize: 7,
                                                                      fontFamily:
                                                                      poppinRegular)),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(),
                                                        // Row(
                                                        //   children: [
                                                        //     widget
                                                        //         .filterCarByAttributeModelObject
                                                        //         ?.data?[
                                                        //     index]
                                                        //         .rating ==
                                                        //         null
                                                        //         ? RatingBar(
                                                        //       // initialRating: double.parse("${searchModelObject.data?[index].rating}"),
                                                        //         initialRating:
                                                        //         0.0,
                                                        //         direction: Axis
                                                        //             .horizontal,
                                                        //         allowHalfRating:
                                                        //         true,
                                                        //         itemCount: 1,
                                                        //         minRating: 0,
                                                        //         itemSize:
                                                        //         18.0,
                                                        //         ignoreGestures:
                                                        //         true,
                                                        //         ratingWidget:
                                                        //         RatingWidget(
                                                        //             full: Icon(Icons.star,
                                                        //                 color:
                                                        //                 borderColor),
                                                        //             half:
                                                        //             Icon(
                                                        //               Icons.star_half,
                                                        //               color:
                                                        //               borderColor,
                                                        //             ),
                                                        //             empty:
                                                        //             Icon(
                                                        //               Icons.star_outline,
                                                        //               color:
                                                        //               borderColor,
                                                        //             )),
                                                        //         onRatingUpdate:
                                                        //             (value) {})
                                                        //         : RatingBar(
                                                        //         initialRating:
                                                        //         double.parse(
                                                        //             "${widget.filterCarByAttributeModelObject?.data?[index].rating}"),
                                                        //         // initialRating: searchModelObject.data?[index].rating,
                                                        //         direction: Axis
                                                        //             .horizontal,
                                                        //         allowHalfRating:
                                                        //         true,
                                                        //         itemCount: 1,
                                                        //         minRating: 0,
                                                        //         itemSize:
                                                        //         18.0,
                                                        //         ignoreGestures:
                                                        //         true,
                                                        //         ratingWidget:
                                                        //         RatingWidget(
                                                        //             full: Icon(Icons.star,
                                                        //                 color:
                                                        //                 borderColor),
                                                        //             half:
                                                        //             Icon(
                                                        //               Icons.star_half,
                                                        //               color:
                                                        //               borderColor,
                                                        //             ),
                                                        //             empty:
                                                        //             Icon(
                                                        //               Icons.star_outline,
                                                        //               color:
                                                        //               borderColor,
                                                        //             )),
                                                        //         onRatingUpdate:
                                                        //             (value) {}),
                                                        //     widget
                                                        //         .filterCarByAttributeModelObject
                                                        //         ?.data?[
                                                        //     index]
                                                        //         .rating ==
                                                        //         null
                                                        //         ? Text("0.0",
                                                        //         style: TextStyle(
                                                        //             color:
                                                        //             kBlack,
                                                        //             fontSize:
                                                        //             10,
                                                        //             fontFamily:
                                                        //             poppinMedium))
                                                        //         : Text(
                                                        //         "${widget.filterCarByAttributeModelObject?.data?[index].rating}",
                                                        //         style: TextStyle(
                                                        //             color:
                                                        //             kBlack,
                                                        //             fontSize:
                                                        //             10,
                                                        //             fontFamily:
                                                        //             poppinMedium)),
                                                        //   ],
                                                        // ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.01),
                                                    Row(
                                                      children: [
                                                        Text(
                                                            "${widget.filterCarByAttributeModelObject?.data?[index].carsMakes?.name}, ",
                                                            style: TextStyle(
                                                                color: kBlack,
                                                                fontSize: 7,
                                                                fontFamily:
                                                                poppinRegular)),
                                                        Text(
                                                            "${widget.filterCarByAttributeModelObject?.data?[index].carsModels?.name}, ",
                                                            style: TextStyle(
                                                                color: kBlack,
                                                                fontSize: 7,
                                                                fontFamily:
                                                                poppinSemiBold)),
                                                        Text(
                                                            "${widget.filterCarByAttributeModelObject?.data?[index].year} ",
                                                            style: TextStyle(
                                                                color: kBlack,
                                                                fontSize: 7,
                                                                fontFamily:
                                                                poppinRegular)),
                                                      ],
                                                    ),
                                                    // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                                    Divider(),
                                                    Row(
                                                      children: [
                                                        widget.filterCarByAttributeModelObject?.data?[index].discountPercentage != "0.00"
                                                            ? Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  top: 04),
                                                              child: Text("RM ",
                                                                  textAlign:
                                                                  TextAlign
                                                                      .left,
                                                                  style: TextStyle(
                                                                      color: kRed,
                                                                      fontSize: 5,
                                                                      fontFamily:
                                                                      poppinLight)),
                                                            ),
                                                            widget
                                                                .filterCarByAttributeModelObject?.data?[
                                                            index]
                                                                .carsUsageType ==
                                                                "EV Subscriptions"
                                                                ? originalPriceWidget(
                                                                "${ formattedPrice}")
                                                                : originalPriceWidget(
                                                                "${ formattedPrice}"),
                                                           ],
                                                        )
                                                        : SizedBox(),
                                                        SizedBox(
                                                            width: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.01),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  top: 06),
                                                              child: Text("RM ",
                                                                  textAlign:
                                                                  TextAlign
                                                                      .left,
                                                                  style: TextStyle(
                                                                      color:
                                                                      borderColor,
                                                                      fontSize: 7,
                                                                      fontFamily:
                                                                      poppinSemiBold)),
                                                            ),
                                                            widget
                                                                .filterCarByAttributeModelObject
                                                                ?.data?[
                                                            index]
                                                                .carsUsageType ==
                                                                "EV Subscriptions"
                                                                ? discountedPriceWidget(
                                                                "${discountFormattedPrice}/",
                                                                "")
                                                                : discountedPriceWidget(
                                                                "${discountFormattedPrice}/",
                                                                "")
                                                             ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.02),
                                                    GestureDetector(
                                                      onTap: () {
                                                        carID = widget.filterCarByAttributeModelObject?.data![index].carsId;
                                                        print("cardId $carID");
                                                        print(
                                                            "carsUsageType ${widget.filterCarByAttributeModelObject!.data?[index].carsUsageType}");
                                                        print(
                                                            "favouriteStatusHome ${widget.filterCarByAttributeModelObject!.data?[index].favouriteStatus}");

                                                        if (widget.filterCarByAttributeModelObject!
                                                            .data![index]
                                                            .carsUsageType ==
                                                            "EV Subscriptions") {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      EVCarDescription(
                                                                        carName: widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .vehicalName,
                                                                        carPrice: formattedPrice,
                                                                        carImage: widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpg') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.png') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpeg')
                                                                            ? "$baseUrlImage${widget.filterCarByAttributeModelObject!.data?[index].image1}"
                                                                            : widget.filterCarByAttributeModelObject!.data?[index].image1,
                                                                        carYear:
                                                                        "${widget.filterCarByAttributeModelObject!.data![index].year}",
                                                                        carId:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .carsId,
                                                                        carRating:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .rating,
                                                                        carColorName:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .carsColors!
                                                                            .name,
                                                                        carMakesName:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .carsMakes!
                                                                            .name,
                                                                        carModelName:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .carsModels!
                                                                            .name,
                                                                        carMakesImage:
                                                                        "$baseUrlImage${widget.filterCarByAttributeModelObject!.data![index].carsMakes!.image}",
                                                                        // carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                                        discountPercentage:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .discountPercentage,
                                                                        carDiscountPrice: discountFormattedPrice,
                                                                        carOwnerImage:
                                                                        "$baseUrlImage${widget.filterCarByAttributeModelObject!.data![index].usersCompanies!.companyLogo}",
                                                                        carOwnerName:
                                                                        "${widget.filterCarByAttributeModelObject!.data![index].usersCompanies!.companyName}",
                                                                        carOwnerId: widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .usersCompanies!
                                                                            .usersCompaniesId,
                                                                        myCarDescription:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .description,
                                                                        favouriteStatus:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .favouriteStatus,

                                                                        featureSuv:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresSuv,
                                                                        featuresDoors:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresDoors,
                                                                        featuresSeats:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresSeats,
                                                                        featuresAutomatic:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresAutomatic,
                                                                        featuresSpeed:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresSpeed,
                                                                        featuresElectric:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresElectric,
                                                                        featuresEngine_capacity:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresEngineCapacity,
                                                                        featuresFuelCapacity:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresFuelCapacity,
                                                                        featuresMeterReading:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresMeterReading,
                                                                        featuresNewCars:
                                                                        widget.filterCarByAttributeModelObject!
                                                                            .data![
                                                                        index]
                                                                            .featuresNewCars,
                                                                      )));
                                                        }
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.035,
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.4,
                                                        decoration: BoxDecoration(
                                                            color: borderColor,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                30)),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                  "Click to see Details",
                                                                  textAlign:
                                                                  TextAlign.left,
                                                                  style: TextStyle(
                                                                      color: kWhite,
                                                                      fontFamily:
                                                                      poppinMedium,
                                                                      fontSize: 10)),
                                                              SizedBox(width: 10),
                                                              Image.asset(
                                                                  "assets/home_page/more_buttons_home.png")
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
                                          top: 0,
                                          left: 10,
                                          right: 10,
                                          child: widget.filterCarByAttributeModelObject!.data?[index].image1 == null
                                              ? ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset('assets/icon/fade_in_image.jpeg'),
                                          )
                                              : widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpg') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.png') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpeg')
                                              ? ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: FadeInImage(
                                              placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                                              height: 65,
                                              image: NetworkImage("$baseUrlImage${widget.filterCarByAttributeModelObject!.data?[index].image1}"),
                                            ),
                                          )
                                              : Container(
                                            height: 130,
                                            child: ModelViewer(
                                              backgroundColor: Colors.transparent,
                                              src: '${widget.filterCarByAttributeModelObject!.data?[index].image1}',
                                              alt: "A 3D model of car",
                                              autoPlay: false,
                                              autoRotate: false,
                                              cameraControls: false,
                                              disableTap: false,
                                              ar: false,
                                              disablePan: true,
                                              arModes: ["quicklook", "scene-viewer"],
                                              iosSrc: "${widget.filterCarByAttributeModelObject!.data?[index].image1}",
                                              disableZoom: true,
                                            ),
                                          ),
                                        ),
                                        widget.filterCarByAttributeModelObject?.data?[index].discountPercentage != "0.00"
                                            ? Positioned(
                                          top: 03,
                                          left: 05,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.065,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.19,
                                            decoration: BoxDecoration(
                                              color: kRed.withOpacity(0.8),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft:
                                                  Radius.circular(15)),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "${widget.filterCarByAttributeModelObject?.data?[index].discountPercentage}% ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kWhite,
                                                          fontSize: 12,
                                                          fontFamily:
                                                          poppinSemiBold)),
                                                  Text("OFF",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: kWhite,
                                                          fontSize: 8,
                                                          fontFamily:
                                                          poppinRegular)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        : SizedBox(),
                                      ],
                                    ),
                                  );
                                }  else {
                                  return SizedBox.shrink();
                                }
                              });
                        } else {
                          return GridView.builder(
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.5,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemCount:widget.filterCarByAttributeModelObject
                                  ?.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                var pricePerMonthString = widget.filterCarByAttributeModelObject!.data?[index].carsPlans![0].pricePerMonth;
                                double pricePerMonth;
                                String formattedPrice = "";
                                if (pricePerMonthString != null) {
                                  pricePerMonth = double.parse(pricePerMonthString);
                                  if (pricePerMonth != null) {
                                    final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                    formattedPrice = numberFormat.format(pricePerMonth);
                                  } else {
                                    print("Invalid price format");
                                  }
                                } else {
                                  print("Price not available");
                                }

                                var discountPricePerMonthString = widget.filterCarByAttributeModelObject!.data?[index].carsPlans![0].discountedPricePerMonth;
                                double discountPricePerMonth;
                                String discountFormattedPrice = "";
                                if (discountPricePerMonthString != null) {
                                  discountPricePerMonth = double.parse(discountPricePerMonthString);
                                  if (discountPricePerMonth != null) {
                                    final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                    discountFormattedPrice = numberFormat.format(discountPricePerMonth);
                                  } else {
                                    print("Invalid price format");
                                  }
                                } else {
                                  print("Price not available");
                                }
                                return Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 50,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.21,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.47,
                                            decoration: BoxDecoration(
                                                color: kWhite,
                                                borderRadius:
                                                BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.06),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          // Text("${searchModelObject.data?[index].vehicalName} ",
                                                          Container(
                                                            width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.15,
                                                            child: Text(
                                                                "${widget.filterCarByAttributeModelObject?.data?[index].vehicalName} ",
                                                                overflow: TextOverflow
                                                                    .ellipsis,
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color: kBlack,
                                                                    fontSize: 8,
                                                                    fontFamily:
                                                                    poppinBold)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 4),
                                                            child: Text(
                                                                "${widget.filterCarByAttributeModelObject?.data?[index].carsColors?.name} ",
                                                                style: TextStyle(
                                                                    color:
                                                                    kBlack,
                                                                    fontSize: 7,
                                                                    fontFamily:
                                                                    poppinRegular)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox()
                                                      // Row(
                                                      //   children: [
                                                      //     widget
                                                      //         .filterCarByAttributeModelObject
                                                      //         ?.data?[
                                                      //     index]
                                                      //         .rating ==
                                                      //         null
                                                      //         ? RatingBar(
                                                      //       initialRating:
                                                      //         0.0,
                                                      //         direction: Axis
                                                      //             .horizontal,
                                                      //         allowHalfRating:
                                                      //         true,
                                                      //         itemCount: 1,
                                                      //         minRating: 0,
                                                      //         itemSize:
                                                      //         18.0,
                                                      //         ignoreGestures:
                                                      //         true,
                                                      //         ratingWidget:
                                                      //         RatingWidget(
                                                      //             full: Icon(Icons.star,
                                                      //                 color:
                                                      //                 borderColor),
                                                      //             half:
                                                      //             Icon(
                                                      //               Icons.star_half,
                                                      //               color:
                                                      //               borderColor,
                                                      //             ),
                                                      //             empty:
                                                      //             Icon(
                                                      //               Icons.star_outline,
                                                      //               color:
                                                      //               borderColor,
                                                      //             )),
                                                      //         onRatingUpdate:
                                                      //             (value) {})
                                                      //         : RatingBar(
                                                      //         initialRating:
                                                      //         double.parse(
                                                      //             "${widget.filterCarByAttributeModelObject?.data?[index].rating}"),
                                                      //         // initialRating: searchModelObject.data?[index].rating,
                                                      //         direction: Axis
                                                      //             .horizontal,
                                                      //         allowHalfRating:
                                                      //         true,
                                                      //         itemCount: 1,
                                                      //         minRating: 0,
                                                      //         itemSize:
                                                      //         18.0,
                                                      //         ignoreGestures:
                                                      //         true,
                                                      //         ratingWidget:
                                                      //         RatingWidget(
                                                      //             full: Icon(Icons.star,
                                                      //                 color:
                                                      //                 borderColor),
                                                      //             half:
                                                      //             Icon(
                                                      //               Icons.star_half,
                                                      //               color:
                                                      //               borderColor,
                                                      //             ),
                                                      //             empty:
                                                      //             Icon(
                                                      //               Icons.star_outline,
                                                      //               color:
                                                      //               borderColor,
                                                      //             )),
                                                      //         onRatingUpdate:
                                                      //             (value) {}),
                                                      //     widget
                                                      //         .filterCarByAttributeModelObject
                                                      //         ?.data?[
                                                      //     index]
                                                      //         .rating ==
                                                      //         null
                                                      //         ? Text("0.0",
                                                      //         style: TextStyle(
                                                      //             color:
                                                      //             kBlack,
                                                      //             fontSize:
                                                      //             10,
                                                      //             fontFamily:
                                                      //             poppinMedium))
                                                      //         : Text(
                                                      //         "${widget.filterCarByAttributeModelObject?.data?[index].rating}",
                                                      //         style: TextStyle(
                                                      //             color:
                                                      //             kBlack,
                                                      //             fontSize:
                                                      //             10,
                                                      //             fontFamily:
                                                      //             poppinMedium)),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.01),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          "${widget.filterCarByAttributeModelObject?.data?[index].carsMakes?.name}, ",
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 7,
                                                              fontFamily:
                                                              poppinRegular)),
                                                      Text(
                                                          "${widget.filterCarByAttributeModelObject?.data?[index].carsModels?.name}, ",
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 7,
                                                              fontFamily:
                                                              poppinSemiBold)),
                                                      Text(
                                                          "${widget.filterCarByAttributeModelObject?.data?[index].year} ",
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 7,
                                                              fontFamily:
                                                              poppinRegular)),
                                                    ],
                                                  ),
                                                  // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                                  Divider(),
                                                  Row(
                                                    children: [
                                                      widget.filterCarByAttributeModelObject?.data?[index].discountPercentage != "0.00"
                                                          ? Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 04),
                                                            child: Text("RM ",
                                                                textAlign:
                                                                TextAlign
                                                                    .left,
                                                                style: TextStyle(
                                                                    color: kRed,
                                                                    fontSize: 5,
                                                                    fontFamily:
                                                                    poppinLight)),
                                                          ),
                                                          topRentedCarsModelObject.data?[
                                                          index]
                                                              .carsUsageType ==
                                                              "EV Subscriptions"
                                                              ? originalPriceWidget(
                                                              "${formattedPrice}")
                                                              : originalPriceWidget(
                                                              "${formattedPrice}"),
                                                           ],
                                                      )
                                                      : SizedBox(),
                                                      SizedBox(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.01),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 06),
                                                            child: Text("RM ",
                                                                textAlign:
                                                                TextAlign
                                                                    .left,
                                                                style: TextStyle(
                                                                    color:
                                                                    borderColor,
                                                                    fontSize: 7,
                                                                    fontFamily:
                                                                    poppinSemiBold)),
                                                          ),
                                                          widget
                                                              .filterCarByAttributeModelObject
                                                              ?.data?[
                                                          index]
                                                              .carsUsageType ==
                                                              "EV Subscriptions"
                                                              ? discountedPriceWidget(
                                                              "${discountFormattedPrice}/",
                                                              "")
                                                              : discountedPriceWidget(
                                                              "${discountFormattedPrice}/",
                                                              "")
                                                         ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.02),
                                                  GestureDetector(
                                                    onTap: () {
                                                      carID = widget.filterCarByAttributeModelObject?.data![index].carsId;
                                                      print("cardId $carID");
                                                      print(
                                                          "carsUsageType ${widget.filterCarByAttributeModelObject!.data?[index].carsUsageType}");
                                                      print(
                                                          "favouriteStatusHome ${widget.filterCarByAttributeModelObject!.data?[index].favouriteStatus}");

                                                      if (widget.filterCarByAttributeModelObject!
                                                          .data![index]
                                                          .carsUsageType ==
                                                          "EV Subscriptions") {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EVCarDescription(
                                                                      carName: widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .vehicalName,
                                                                      carPrice: formattedPrice,
                                                                      carImage: widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpg') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.png') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpeg')
                                                                          ? "$baseUrlImage${widget.filterCarByAttributeModelObject!.data?[index].image1}"
                                                                          : widget.filterCarByAttributeModelObject!.data?[index].image1,
                                                                      carYear:
                                                                      "${widget.filterCarByAttributeModelObject!.data![index].year}",
                                                                      carId:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .carsId,
                                                                      carRating:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .rating,
                                                                      carColorName:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .carsColors!
                                                                          .name,
                                                                      carMakesName:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .carsMakes!
                                                                          .name,
                                                                      carModelName:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .carsModels!
                                                                          .name,
                                                                      carMakesImage:
                                                                      "$baseUrlImage${widget.filterCarByAttributeModelObject!.data![index].carsMakes!.image}",
                                                                      // carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                                      discountPercentage:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .discountPercentage,
                                                                      carDiscountPrice: discountFormattedPrice,
                                                                      carOwnerImage:
                                                                      "$baseUrlImage${widget.filterCarByAttributeModelObject!.data![index].usersCompanies!.companyLogo}",
                                                                      carOwnerName:
                                                                      "${widget.filterCarByAttributeModelObject!.data![index].usersCompanies!.companyName}",
                                                                      carOwnerId: widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .usersCompanies!
                                                                          .usersCompaniesId,
                                                                      myCarDescription:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .description,
                                                                      favouriteStatus:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .favouriteStatus,

                                                                      featureSuv:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresSuv,
                                                                      featuresDoors:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresDoors,
                                                                      featuresSeats:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresSeats,
                                                                      featuresAutomatic:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresAutomatic,
                                                                      featuresSpeed:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresSpeed,
                                                                      featuresElectric:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresElectric,
                                                                      featuresEngine_capacity:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresEngineCapacity,
                                                                      featuresFuelCapacity:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresFuelCapacity,
                                                                      featuresMeterReading:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresMeterReading,
                                                                      featuresNewCars:
                                                                      widget.filterCarByAttributeModelObject!
                                                                          .data![
                                                                      index]
                                                                          .featuresNewCars,
                                                                    )));
                                                      }
                                                    },
                                                    child: Container(
                                                      height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.035,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.4,
                                                      decoration: BoxDecoration(
                                                          color: borderColor,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                                "Click to see Details",
                                                                textAlign:
                                                                TextAlign.left,
                                                                style: TextStyle(
                                                                    color: kWhite,
                                                                    fontFamily:
                                                                    poppinMedium,
                                                                    fontSize: 10)),
                                                            SizedBox(width: 10),
                                                            Image.asset(
                                                                "assets/home_page/more_buttons_home.png")
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
                                        top: 0,
                                        left: 10,
                                        right: 10,
                                        child:widget.filterCarByAttributeModelObject!.data?[index].image1 == null
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset('assets/icon/fade_in_image.jpeg'),
                                        )
                                            : widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpg') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.png') || widget.filterCarByAttributeModelObject!.data![index].image1!.endsWith('.jpeg')
                                            ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage(
                                            placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                                            height: 65,
                                            image: NetworkImage("$baseUrlImage${widget.filterCarByAttributeModelObject!.data?[index].image1}"),
                                          ),
                                        )
                                            : Container(
                                          height: 130,
                                          child: ModelViewer(
                                            backgroundColor: Colors.transparent,
                                            src: '${widget.filterCarByAttributeModelObject!.data?[index].image1}',
                                            alt: "A 3D model of car",
                                            autoPlay: false,
                                            autoRotate: false,
                                            cameraControls: false,
                                            disableTap: false,
                                            ar: false,
                                            disablePan: true,
                                            arModes: ["quicklook", "scene-viewer"],
                                            iosSrc: "${widget.filterCarByAttributeModelObject!.data?[index].image1}",
                                            disableZoom: true,
                                          ),
                                        ),
                                      ),
                                      widget.filterCarByAttributeModelObject?.data?[index].discountPercentage != "0.00"
                                          ? Positioned(
                                        top: 03,
                                        left: 05,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.065,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.19,
                                          decoration: BoxDecoration(
                                            color: kRed.withOpacity(0.8),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomLeft:
                                                Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${widget.filterCarByAttributeModelObject?.data?[index].discountPercentage}% ",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 12,
                                                        fontFamily:
                                                        poppinSemiBold)),
                                                Text("OFF",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: kWhite,
                                                        fontSize: 8,
                                                        fontFamily:
                                                        poppinRegular)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      : SizedBox(),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  )
                      : topRentedCarsModelObject.data != null
                      ? topRentedCars(searchController.text)
                      : Center(
                      child: Text('No Cars Found.',
                          style:
                          TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topRentedCars(String searchText) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      color: Colors.transparent,
      child: searchText.isEmpty
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 600) {
                      return GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.25,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          ),
                          itemCount: topRentedCarsModelObject.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            print("CarID ${topRentedCarsModelObject.data?[index].carsId}");
                            double pricePerMonth;
                            String formattedPrice = "";

                            if (topRentedCarsModelObject != null &&
                                topRentedCarsModelObject.data != null &&
                                index < topRentedCarsModelObject.data!.length &&
                                topRentedCarsModelObject.data?[index] != null &&
                                topRentedCarsModelObject.data?[index].carsPlans != null &&
                                topRentedCarsModelObject.data![index].carsPlans!.isNotEmpty) {
                               var pricePerMonthString =
                                  topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerMonth;

                              if (pricePerMonthString != null) {
                                try {
                                  pricePerMonth = double.parse(pricePerMonthString);
                                  final numberFormat = NumberFormat.decimalPattern();
                                  formattedPrice = numberFormat.format(pricePerMonth);
                                  print("formattedPrice $formattedPrice");
                                } catch (e) {
                                  print("Error parsing price: $e");
                                }
                              } else {
                                print("Price not available");
                              }
                            } else {
                              print("Invalid data or index");
                            }


                            var discountPricePerMonthString = topRentedCarsModelObject.data?[index].carsPlans![0].discountedPricePerMonth;
                            double discountPricePerMonth;
                            String discountFormattedPrice = "";
                            if (discountPricePerMonthString != null) {
                              discountPricePerMonth = double.parse(discountPricePerMonthString);
                              if (discountPricePerMonth != null) {
                                final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                discountFormattedPrice = numberFormat.format(discountPricePerMonth);
                                // print("RM $discountFormattedPrice");
                              } else {
                                print("Invalid price format");
                              }
                            } else {
                              print("Price not available");
                            }
                           return Stack(
                              children: [
                                Positioned(
                                  top: 50,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.21,
                                      width: MediaQuery.of(context).size.width *
                                          0.47,
                                      decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.11,
                                                      child: Text(
                                                          "${topRentedCarsModelObject.data?[index].vehicalName} ",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  poppinBold)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2, left: 0),
                                                      child: Text(
                                                          "${topRentedCarsModelObject.data?[index].carsColors!.name} ",
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 7,
                                                              fontFamily:
                                                                  poppinRegular)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox()
                                                // Row(
                                                //   children: [
                                                //     topRentedCarsModelObject
                                                //                 .data?[index]
                                                //                 .rating ==
                                                //             null
                                                //         ? RatingBar(
                                                //             initialRating: 0.0,
                                                //             direction:
                                                //                 Axis.horizontal,
                                                //             allowHalfRating:
                                                //                 true,
                                                //             itemCount: 1,
                                                //             minRating: 0,
                                                //             itemSize: 18.0,
                                                //             ignoreGestures:
                                                //                 true,
                                                //             ratingWidget:
                                                //                 RatingWidget(
                                                //                     full: Icon(
                                                //                         Icons
                                                //                             .star,
                                                //                         color:
                                                //                             borderColor),
                                                //                     half: Icon(
                                                //                       Icons
                                                //                           .star_half,
                                                //                       color:
                                                //                           borderColor,
                                                //                     ),
                                                //                     empty: Icon(
                                                //                       Icons
                                                //                           .star_outline,
                                                //                       color:
                                                //                           borderColor,
                                                //                     )),
                                                //             onRatingUpdate:
                                                //                 (value) {})
                                                //         : RatingBar(
                                                //             initialRating:
                                                //                 double.parse(
                                                //                     "${topRentedCarsModelObject.data![index].rating}"),
                                                //             direction:
                                                //                 Axis.horizontal,
                                                //             allowHalfRating:
                                                //                 true,
                                                //             itemCount: 1,
                                                //             minRating: 0,
                                                //             itemSize: 18.0,
                                                //             ignoreGestures:
                                                //                 true,
                                                //             ratingWidget:
                                                //                 RatingWidget(
                                                //                     full: Icon(
                                                //                         Icons
                                                //                             .star,
                                                //                         color:
                                                //                             borderColor),
                                                //                     half: Icon(
                                                //                       Icons
                                                //                           .star_half,
                                                //                       color:
                                                //                           borderColor,
                                                //                     ),
                                                //                     empty: Icon(
                                                //                       Icons
                                                //                           .star_outline,
                                                //                       color:
                                                //                           borderColor,
                                                //                     )),
                                                //             onRatingUpdate:
                                                //                 (value) {}),
                                                //     topRentedCarsModelObject
                                                //                 .data?[index]
                                                //                 .rating ==
                                                //             null
                                                //         ? Text("0.0",
                                                //             style: TextStyle(
                                                //                 color: kBlack,
                                                //                 fontSize: 10,
                                                //                 fontFamily:
                                                //                     poppinMedium))
                                                //         : Text(
                                                //             "${topRentedCarsModelObject.data?[index].rating}",
                                                //             style: TextStyle(
                                                //                 color: kBlack,
                                                //                 fontSize: 10,
                                                //                 fontFamily:
                                                //                     poppinMedium)),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            Row(
                                              children: [
                                                Text(
                                                    "${topRentedCarsModelObject.data?[index].carsMakes?.name}, ",
                                                    style: TextStyle(
                                                        color: kBlack,
                                                        fontSize: 7,
                                                        fontFamily:
                                                            poppinRegular)),
                                                Text(
                                                    "${topRentedCarsModelObject.data?[index].carsModels?.name}, ",
                                                    style: TextStyle(
                                                        color: kBlack,
                                                        fontSize: 7,
                                                        fontFamily:
                                                            poppinSemiBold)),
                                                Text(
                                                    "${topRentedCarsModelObject.data?[index].year} ",
                                                    style: TextStyle(
                                                        color: kBlack,
                                                        fontSize: 7,
                                                        fontFamily:
                                                            poppinRegular)),
                                              ],
                                            ),
                                            // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                            Divider(),
                                            Row(
                                              children: [
                                                topRentedCarsModelObject.data?[index].discountPercentage != "0.00"
                                                    ? Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 04),
                                                      child: Text("RM ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: kRed,
                                                              fontSize: 5,
                                                              fontFamily:
                                                                  poppinLight)),
                                                    ),
                                                    topRentedCarsModelObject
                                                                .data?[index]
                                                                .carsUsageType ==
                                                            "EV Subscriptions"
                                                        ? originalPriceWidget(
                                                            "${formattedPrice}")
                                                        : topRentedCarsModelObject
                                                                    .data?[
                                                                        index]
                                                                    .carsUsageType ==
                                                                "Photography"
                                                            ? originalPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerHour}")
                                                            : originalPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerSlot}"),
                                                  ],
                                                )
                                                    : SizedBox(),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 06),
                                                      child: Text("RM ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color:
                                                                  borderColor,
                                                              fontSize: 7,
                                                              fontFamily:
                                                                  poppinSemiBold)),
                                                    ),
                                                    topRentedCarsModelObject
                                                                .data?[index]
                                                                .carsUsageType ==
                                                            "EV Subscriptions"
                                                        ? discountedPriceWidget(
                                                            "${discountFormattedPrice}/",
                                                            "")
                                                        : topRentedCarsModelObject
                                                                    .data?[
                                                                        index]
                                                                    .carsUsageType ==
                                                                "Photography"
                                                            ? discountedPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].discountedPricePerHour}/",
                                                                "Hour")
                                                            : discountedPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].discountedPricePerSlot}/",
                                                                "Slot"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            GestureDetector(
                                              onTap: () {
                                                carID = topRentedCarsModelObject
                                                    .data![index].carsId;
                                                print("cardId $carID");
                                                print(
                                                    "carsUsageType ${topRentedCarsModelObject.data?[index].carsUsageType}");
                                                print(
                                                    "favouriteStatusHome ${topRentedCarsModelObject.data?[index].favouriteStatus}");

                                                if (topRentedCarsModelObject
                                                        .data![index]
                                                        .carsUsageType ==
                                                    "EV Subscriptions") {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EVCarDescription(
                                                                carName: topRentedCarsModelObject
                                                                    .data![
                                                                        index]
                                                                    .vehicalName,
                                                                carPrice: formattedPrice,
                                                                carImage: topRentedCarsModelObject.data![index].image1!.endsWith('.jpg') || topRentedCarsModelObject.data![index].image1!.endsWith('.png') || topRentedCarsModelObject.data![index].image1!.endsWith('.jpeg')
                                                                    ? "$baseUrlImage${topRentedCarsModelObject.data?[index].image1}"
                                                                    : topRentedCarsModelObject.data?[index].image1,
                                                                carYear:
                                                                    "${topRentedCarsModelObject.data![index].year}",
                                                                carId:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsId,
                                                                carRating:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .rating,
                                                                carColorName:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsColors!
                                                                        .name,
                                                                carMakesName:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsMakes!
                                                                        .name,
                                                                carModelName:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsModels!
                                                                        .name,
                                                                carMakesImage:
                                                                    "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                                                // carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                                discountPercentage:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .discountPercentage,
                                                                carDiscountPrice: discountFormattedPrice,
                                                                carOwnerImage:
                                                                    "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                                                carOwnerName:
                                                                    "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                                                carOwnerId: topRentedCarsModelObject
                                                                    .data![
                                                                        index]
                                                                    .usersCompanies!
                                                                    .usersCompaniesId,
                                                                myCarDescription:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .description,
                                                                favouriteStatus:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .favouriteStatus,

                                                                featureSuv:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresSuv,
                                                                featuresDoors:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresDoors,
                                                                featuresSeats:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresSeats,
                                                                featuresAutomatic:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresAutomatic,
                                                                featuresSpeed:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresSpeed,
                                                                featuresElectric:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresElectric,
                                                                featuresEngine_capacity:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresEngineCapacity,
                                                                featuresFuelCapacity:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresFuelCapacity,
                                                                featuresMeterReading:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresMeterReading,
                                                                featuresNewCars:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresNewCars,
                                                              )));
                                                }
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: borderColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "Click to see Details",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: kWhite,
                                                              fontFamily:
                                                                  poppinMedium,
                                                              fontSize: 10)),
                                                      SizedBox(width: 10),
                                                      Image.asset(
                                                          "assets/home_page/more_buttons_home.png")
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
                                  top: 0,
                                  left: 10,
                                  right: 10,
                                  child: topRentedCarsModelObject.data?[index].image1 == null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset('assets/icon/fade_in_image.jpeg'),
                                  )
                                      : topRentedCarsModelObject.data![index].image1!.endsWith('.jpg') || topRentedCarsModelObject.data![index].image1!.endsWith('.png') || topRentedCarsModelObject.data![index].image1!.endsWith('.jpeg')
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                                      height: 65,
                                      image: NetworkImage("$baseUrlImage${topRentedCarsModelObject.data?[index].image1}"),
                                    ),
                                  )
                                      : Container(
                                    height: 130,
                                        child: ModelViewer(
                                          backgroundColor: Colors.transparent,
                                          src: '${topRentedCarsModelObject.data?[index].image1}',
                                          alt: "A 3D model of car",
                                          autoPlay: false,
                                          autoRotate: false,
                                          cameraControls: false,
                                          disableTap: false,
                                          ar: false,
                                          disablePan: true,
                                          arModes: ["quicklook", "scene-viewer"],
                                          iosSrc: "${topRentedCarsModelObject.data?[index].image1}",
                                          disableZoom: true,
                                        ),
                                  ),
                                ),
                                topRentedCarsModelObject.data?[index].discountPercentage != "0.00"
                                    ? Positioned(
                                  top: 03,
                                  left: 05,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.065,
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    decoration: BoxDecoration(
                                      color: kRed.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${topRentedCarsModelObject.data?[index].discountPercentage}% ",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 12,
                                                  fontFamily: poppinSemiBold)),
                                          Text("OFF",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 8,
                                                  fontFamily: poppinRegular)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                    : SizedBox(),
                              ],
                            );
                          });
                    } else {
                      return GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                          ),
                          itemCount: topRentedCarsModelObject.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            var pricePerMonthString = topRentedCarsModelObject.data?[index].carsPlans![0].pricePerMonth;
                            double pricePerMonth;
                            String formattedPrice = "";
                            if (pricePerMonthString != null) {
                              pricePerMonth = double.parse(pricePerMonthString);
                              if (pricePerMonth != null) {
                                final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                formattedPrice = numberFormat.format(pricePerMonth);
                                // print("RM $formattedPrice");
                              } else {
                                print("Invalid price format");
                              }
                            } else {
                              print("Price not available");
                            }

                            var discountPricePerMonthString = topRentedCarsModelObject.data?[index].carsPlans![0].discountedPricePerMonth;
                            double discountPricePerMonth;
                            String discountFormattedPrice = "";
                            if (discountPricePerMonthString != null) {
                              discountPricePerMonth = double.parse(discountPricePerMonthString);
                              if (discountPricePerMonth != null) {
                                final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                discountFormattedPrice = numberFormat.format(discountPricePerMonth);
                                // print("RM $discountFormattedPrice");
                              } else {
                                print("Invalid price format");
                              }
                            } else {
                              print("Price not available");
                            }
                            // print("topRentedCarsModelObject1 ${topRentedCarsModelObject1.length}");
                            // carName = topRentedCarsModelObject.data![index].vehicalName;
                            // print("carName $carName");

                            return Stack(
                              children: [
                                Positioned(
                                  top: 50,
                                  left: 0,
                                  right: 0,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.21,
                                      width: MediaQuery.of(context).size.width *
                                          0.47,
                                      decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.11,
                                                      child: Text(
                                                          "${topRentedCarsModelObject.data?[index].vehicalName} ",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  poppinBold)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2, left: 0),
                                                      child: Text(
                                                          "${topRentedCarsModelObject.data?[index].carsColors!.name} ",
                                                          style: TextStyle(
                                                              color: kBlack,
                                                              fontSize: 7,
                                                              fontFamily:
                                                                  poppinRegular)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox()
                                                // Row(
                                                //   children: [
                                                //     topRentedCarsModelObject
                                                //                 .data?[index]
                                                //                 .rating ==
                                                //             null
                                                //         ? RatingBar(
                                                //             initialRating: 0.0,
                                                //             direction:
                                                //                 Axis.horizontal,
                                                //             allowHalfRating:
                                                //                 true,
                                                //             itemCount: 1,
                                                //             minRating: 0,
                                                //             itemSize: 18.0,
                                                //             ignoreGestures:
                                                //                 true,
                                                //             ratingWidget:
                                                //                 RatingWidget(
                                                //                     full: Icon(
                                                //                         Icons
                                                //                             .star,
                                                //                         color:
                                                //                             borderColor),
                                                //                     half: Icon(
                                                //                       Icons
                                                //                           .star_half,
                                                //                       color:
                                                //                           borderColor,
                                                //                     ),
                                                //                     empty: Icon(
                                                //                       Icons
                                                //                           .star_outline,
                                                //                       color:
                                                //                           borderColor,
                                                //                     )),
                                                //             onRatingUpdate:
                                                //                 (value) {})
                                                //         : RatingBar(
                                                //             initialRating:
                                                //                 double.parse(
                                                //                     "${topRentedCarsModelObject.data![index].rating}"),
                                                //             direction:
                                                //                 Axis.horizontal,
                                                //             allowHalfRating:
                                                //                 true,
                                                //             itemCount: 1,
                                                //             minRating: 0,
                                                //             itemSize: 18.0,
                                                //             ignoreGestures:
                                                //                 true,
                                                //             ratingWidget:
                                                //                 RatingWidget(
                                                //                     full: Icon(
                                                //                         Icons
                                                //                             .star,
                                                //                         color:
                                                //                             borderColor),
                                                //                     half: Icon(
                                                //                       Icons
                                                //                           .star_half,
                                                //                       color:
                                                //                           borderColor,
                                                //                     ),
                                                //                     empty: Icon(
                                                //                       Icons
                                                //                           .star_outline,
                                                //                       color:
                                                //                           borderColor,
                                                //                     )),
                                                //             onRatingUpdate:
                                                //                 (value) {}),
                                                //     topRentedCarsModelObject
                                                //                 .data?[index]
                                                //                 .rating ==
                                                //             null
                                                //         ? Text("0.0",
                                                //             style: TextStyle(
                                                //                 color: kBlack,
                                                //                 fontSize: 10,
                                                //                 fontFamily:
                                                //                     poppinMedium))
                                                //         : Text(
                                                //             "${topRentedCarsModelObject.data?[index].rating}",
                                                //             style: TextStyle(
                                                //                 color: kBlack,
                                                //                 fontSize: 10,
                                                //                 fontFamily:
                                                //                     poppinMedium)),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            Row(
                                              children: [
                                                Text(
                                                    "${topRentedCarsModelObject.data?[index].carsMakes?.name}, ",
                                                    style: TextStyle(
                                                        color: kBlack,
                                                        fontSize: 7,
                                                        fontFamily:
                                                            poppinRegular)),
                                                Text(
                                                    "${topRentedCarsModelObject.data?[index].carsModels?.name}, ",
                                                    style: TextStyle(
                                                        color: kBlack,
                                                        fontSize: 7,
                                                        fontFamily:
                                                            poppinSemiBold)),
                                                Text(
                                                    "${topRentedCarsModelObject.data?[index].year} ",
                                                    style: TextStyle(
                                                        color: kBlack,
                                                        fontSize: 7,
                                                        fontFamily:
                                                            poppinRegular)),
                                              ],
                                            ),
                                            // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                            Divider(),
                                            Row(
                                              children: [
                                                topRentedCarsModelObject.data?[index].discountPercentage != "0.00"
                                                    ? Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 04),
                                                      child: Text("RM ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: kRed,
                                                              fontSize: 5,
                                                              fontFamily:
                                                                  poppinLight)),
                                                    ),
                                                    topRentedCarsModelObject
                                                                .data?[index]
                                                                .carsUsageType ==
                                                            "EV Subscriptions"
                                                        ? originalPriceWidget(
                                                            "${formattedPrice}")
                                                        : topRentedCarsModelObject
                                                                    .data?[
                                                                        index]
                                                                    .carsUsageType ==
                                                                "Photography"
                                                            ? originalPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerHour}")
                                                            : originalPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].pricePerSlot}"),
                                                  ],
                                                )
                                                    : SizedBox(),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 06),
                                                      child: Text("RM ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color:
                                                                  borderColor,
                                                              fontSize: 7,
                                                              fontFamily:
                                                                  poppinSemiBold)),
                                                    ),
                                                    topRentedCarsModelObject
                                                                .data?[index]
                                                                .carsUsageType ==
                                                            "EV Subscriptions"
                                                        ? discountedPriceWidget(
                                                            "${discountFormattedPrice}/",
                                                            "")
                                                        : topRentedCarsModelObject
                                                                    .data?[
                                                                        index]
                                                                    .carsUsageType ==
                                                                "Photography"
                                                            ? discountedPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].discountedPricePerHour}/",
                                                                "Hour")
                                                            : discountedPriceWidget(
                                                                "${topRentedCarsModelObject.data?[index].carsPlans?[0].discountedPricePerSlot}/",
                                                                "Slot"),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            GestureDetector(
                                              onTap: () {
                                                carID = topRentedCarsModelObject
                                                    .data![index].carsId;
                                                print("cardId $carID");
                                                print(
                                                    "carsUsageType ${topRentedCarsModelObject.data?[index].carsUsageType}");
                                                print(
                                                    "favouriteStatusHome ${topRentedCarsModelObject.data?[index].favouriteStatus}");

                                                if (topRentedCarsModelObject
                                                        .data![index]
                                                        .carsUsageType ==
                                                    "EV Subscriptions") {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EVCarDescription(
                                                                carName: topRentedCarsModelObject
                                                                    .data![
                                                                        index]
                                                                    .vehicalName,
                                                                carPrice: formattedPrice,
                                                                carImage: topRentedCarsModelObject.data![index].image1!.endsWith('.jpg') || topRentedCarsModelObject.data![index].image1!.endsWith('.png') || topRentedCarsModelObject.data![index].image1!.endsWith('.jpeg')
                                                                    ? "$baseUrlImage${topRentedCarsModelObject.data?[index].image1}"
                                                                    : topRentedCarsModelObject.data?[index].image1,
                                                                carYear:
                                                                    "${topRentedCarsModelObject.data![index].year}",
                                                                carId:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsId,
                                                                carRating:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .rating,
                                                                carColorName:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsColors!
                                                                        .name,
                                                                carMakesName:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsMakes!
                                                                        .name,
                                                                carModelName:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .carsModels!
                                                                        .name,
                                                                carMakesImage:
                                                                    "$baseUrlImage${topRentedCarsModelObject.data![index].carsMakes!.image}",
                                                                // carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                                discountPercentage:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .discountPercentage,
                                                                carDiscountPrice:discountFormattedPrice,
                                                                carOwnerImage:
                                                                    "$baseUrlImage${topRentedCarsModelObject.data![index].usersCompanies!.companyLogo}",
                                                                carOwnerName:
                                                                    "${topRentedCarsModelObject.data![index].usersCompanies!.companyName}",
                                                                carOwnerId: topRentedCarsModelObject
                                                                    .data![
                                                                        index]
                                                                    .usersCompanies!
                                                                    .usersCompaniesId,
                                                                myCarDescription:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .description,
                                                                favouriteStatus:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .favouriteStatus,

                                                                featureSuv:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresSuv,
                                                                featuresDoors:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresDoors,
                                                                featuresSeats:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresSeats,
                                                                featuresAutomatic:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresAutomatic,
                                                                featuresSpeed:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresSpeed,
                                                                featuresElectric:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresElectric,
                                                                featuresEngine_capacity:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresEngineCapacity,
                                                                featuresFuelCapacity:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresFuelCapacity,
                                                                featuresMeterReading:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresMeterReading,
                                                                featuresNewCars:
                                                                    topRentedCarsModelObject
                                                                        .data![
                                                                            index]
                                                                        .featuresNewCars,
                                                              )));
                                                }
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: borderColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "Click to see Details",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: kWhite,
                                                              fontFamily:
                                                                  poppinMedium,
                                                              fontSize: 10)),
                                                      SizedBox(width: 10),
                                                      Image.asset(
                                                          "assets/home_page/more_buttons_home.png")
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
                                  top: 0,
                                  left: 10,
                                  right: 10,
                                  child: topRentedCarsModelObject.data?[index].image1 == null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset('assets/icon/fade_in_image.jpeg'),
                                  )
                                      : topRentedCarsModelObject.data![index].image1!.endsWith('.jpg') || topRentedCarsModelObject.data![index].image1!.endsWith('.png') || topRentedCarsModelObject.data![index].image1!.endsWith('.jpeg')
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                                      height: 65,
                                      image: NetworkImage("$baseUrlImage${topRentedCarsModelObject.data?[index].image1}"),
                                    ),
                                  )
                                      : Container(
                                    height: 130,
                                    child: ModelViewer(
                                      backgroundColor: Colors.transparent,
                                      // src: '$baseUrlImage${topRentedCarsModelObject.data?[index].image1}',
                                      src: '${topRentedCarsModelObject.data?[index].image1}',
                                      alt: "A 3D model of car",
                                      autoPlay: false,
                                      autoRotate: false,
                                      cameraControls: false,
                                      disableTap: false,
                                      ar: false,
                                      disablePan: true,
                                      arModes: ["quicklook", "scene-viewer"],
                                      iosSrc: "${topRentedCarsModelObject.data?[index].image1}",
                                      disableZoom: true,
                                    ),
                                  ),
                                ),
                                topRentedCarsModelObject.data?[index].discountPercentage != "0.00"
                                    ? Positioned(
                                  top: 03,
                                  left: 05,
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.065,
                                    width: MediaQuery.of(context).size.width *
                                        0.19,
                                    decoration: BoxDecoration(
                                      color: kRed.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "${topRentedCarsModelObject.data?[index].discountPercentage}% ",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 12,
                                                  fontFamily: poppinSemiBold)),
                                          Text("OFF",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 8,
                                                  fontFamily: poppinRegular)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                     : SizedBox(),
                              ],
                            );
                          });
                    }
                  },
                )
              :  searchModelObject.data == null
                      ? Center(
                          child: Text("No Cars Found.",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)))
                      : LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            if (constraints.maxWidth < 600) {
                              return GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.25,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                  ),
                                  itemCount: searchModelObject.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        var pricePerMonthString = searchModelObject.data?[index].carsPlans![0].pricePerMonth;
                                        double pricePerMonth;
                                        String formattedPrice = "";
                                        if (pricePerMonthString != null) {
                                          pricePerMonth = double.parse(pricePerMonthString);
                                          if (pricePerMonth != null) {
                                            final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                            formattedPrice = numberFormat.format(pricePerMonth);
                                            // print("RM $formattedPrice");
                                          } else {
                                            print("Invalid price format");
                                          }
                                        } else {
                                          print("Price not available");
                                        }

                                        var discountPricePerMonthString = searchModelObject.data?[index].carsPlans![0].discountedPricePerMonth;
                                        double discountPricePerMonth;
                                        String discountFormattedPrice = "";
                                        if (discountPricePerMonthString != null) {
                                          discountPricePerMonth = double.parse(discountPricePerMonthString.toString());
                                          if (discountPricePerMonth != null) {
                                            final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                            discountFormattedPrice = numberFormat.format(discountPricePerMonth);
                                            // print("RM $discountFormattedPrice");
                                          } else {
                                            print("Invalid price format");
                                          }
                                        } else {
                                          print("Price not available");
                                        }
                                    return Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 50,
                                            left: 0,
                                            right: 0,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.21,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47,
                                                decoration: BoxDecoration(
                                                    color: kWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.06),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              // Text("${searchModelObject.data?[index].vehicalName} ",
                                                              Text(
                                                                  "${searchModelObject.data?[index].vehicalName} ",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kBlack,
                                                                      fontSize:
                                                                          8,
                                                                      fontFamily:
                                                                          poppinBold)),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 4),
                                                                child: Text(
                                                                    "${searchModelObject.data?[index].carsColors?.name} ",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kBlack,
                                                                        fontSize:
                                                                            7,
                                                                        fontFamily:
                                                                            poppinRegular)),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox()
                                                          // Row(
                                                          //   children: [
                                                          //     searchModelObject
                                                          //                 .data?[
                                                          //                     index]
                                                          //                 .rating ==
                                                          //             null
                                                          //         ? RatingBar(
                                                          //             // initialRating: double.parse("${searchModelObject.data?[index].rating}"),
                                                          //             initialRating:
                                                          //                 0.0,
                                                          //             direction:
                                                          //                 Axis
                                                          //                     .horizontal,
                                                          //             allowHalfRating:
                                                          //                 true,
                                                          //             itemCount:
                                                          //                 1,
                                                          //             minRating:
                                                          //                 0,
                                                          //             itemSize:
                                                          //                 18.0,
                                                          //             ignoreGestures:
                                                          //                 true,
                                                          //             ratingWidget:
                                                          //                 RatingWidget(
                                                          //                     full: Icon(Icons.star,
                                                          //                         color:
                                                          //                             borderColor),
                                                          //                     half:
                                                          //                         Icon(
                                                          //                       Icons.star_half,
                                                          //                       color: borderColor,
                                                          //                     ),
                                                          //                     empty:
                                                          //                         Icon(
                                                          //                       Icons.star_outline,
                                                          //                       color: borderColor,
                                                          //                     )),
                                                          //             onRatingUpdate:
                                                          //                 (value) {})
                                                          //         : RatingBar(
                                                          //             initialRating:
                                                          //                 double.parse(
                                                          //                     "${searchModelObject.data?[index].rating}"),
                                                          //             // initialRating: searchModelObject.data?[index].rating,
                                                          //             direction:
                                                          //                 Axis
                                                          //                     .horizontal,
                                                          //             allowHalfRating:
                                                          //                 true,
                                                          //             itemCount:
                                                          //                 1,
                                                          //             minRating:
                                                          //                 0,
                                                          //             itemSize:
                                                          //                 18.0,
                                                          //             ignoreGestures:
                                                          //                 true,
                                                          //             ratingWidget: RatingWidget(
                                                          //                 full: Icon(Icons.star, color: borderColor),
                                                          //                 half: Icon(
                                                          //                   Icons.star_half,
                                                          //                   color:
                                                          //                       borderColor,
                                                          //                 ),
                                                          //                 empty: Icon(
                                                          //                   Icons.star_outline,
                                                          //                   color:
                                                          //                       borderColor,
                                                          //                 )),
                                                          //             onRatingUpdate: (value) {}),
                                                          //     searchModelObject
                                                          //                 .data?[
                                                          //                     index]
                                                          //                 .rating ==
                                                          //             null
                                                          //         ? Text("0.0",
                                                          //             style: TextStyle(
                                                          //                 color:
                                                          //                     kBlack,
                                                          //                 fontSize:
                                                          //                     10,
                                                          //                 fontFamily:
                                                          //                     poppinMedium))
                                                          //         : Text(
                                                          //             "${searchModelObject.data?[index].rating}",
                                                          //             style: TextStyle(
                                                          //                 color:
                                                          //                     kBlack,
                                                          //                 fontSize:
                                                          //                     10,
                                                          //                 fontFamily:
                                                          //                     poppinMedium)),
                                                          //   ],
                                                          // ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${searchModelObject.data?[index].carsMakes?.name}, ",
                                                              style: TextStyle(
                                                                  color: kBlack,
                                                                  fontSize: 7,
                                                                  fontFamily:
                                                                      poppinRegular)),
                                                          Text(
                                                              "${searchModelObject.data?[index].carsModels?.name}, ",
                                                              style: TextStyle(
                                                                  color: kBlack,
                                                                  fontSize: 7,
                                                                  fontFamily:
                                                                      poppinSemiBold)),
                                                          Text(
                                                              "${searchModelObject.data?[index].year} ",
                                                              style: TextStyle(
                                                                  color: kBlack,
                                                                  fontSize: 7,
                                                                  fontFamily:
                                                                      poppinRegular)),
                                                        ],
                                                      ),
                                                      // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                                      Divider(),
                                                      Row(
                                                        children: [
                                                          searchModelObject.data?[index].discountPercentage != "0.00"
                                                              ?Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            04),
                                                                child: Text(
                                                                    "RM ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color:
                                                                            kRed,
                                                                        fontSize:
                                                                            5,
                                                                        fontFamily:
                                                                            poppinLight)),
                                                              ),
                                                              searchModelObject
                                                                          .data?[
                                                                              index]
                                                                          .carsUsageType ==
                                                                      "EV Subscriptions"
                                                                  ? originalPriceWidget(
                                                                      "${formattedPrice}")
                                                                  : searchModelObject
                                                                              .data?[
                                                                                  index]
                                                                              .carsUsageType ==
                                                                          "Photography"
                                                                      ? originalPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans![0].pricePerHour}")
                                                                      : originalPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans![0].pricePerSlot}"),
                                                            ],
                                                          )
                                                          : SizedBox(),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            06),
                                                                child: Text(
                                                                    "RM ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color:
                                                                            borderColor,
                                                                        fontSize:
                                                                            7,
                                                                        fontFamily:
                                                                            poppinSemiBold)),
                                                              ),
                                                              searchModelObject
                                                                          .data?[
                                                                              index]
                                                                          .carsUsageType ==
                                                                      "EV Subscriptions"
                                                                  ? discountedPriceWidget(
                                                                      "${discountFormattedPrice}/",
                                                                      "")
                                                                  : searchModelObject
                                                                              .data?[
                                                                                  index]
                                                                              .carsUsageType ==
                                                                          "Photography"
                                                                      ? discountedPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans?[0].discountedPricePerHour}/",
                                                                          "Hour")
                                                                      : discountedPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans?[0].discountedPricePerSlot}/",
                                                                          "Slot"),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                      GestureDetector(
                                                        onTap: () {
                                                          carID = searchModelObject
                                                              .data![index].carsId;
                                                          print("cardId $carID");
                                                          print(
                                                              "carsUsageType ${searchModelObject.data?[index].carsUsageType}");
                                                          print(
                                                              "favouriteStatusHome ${searchModelObject.data?[index].favouriteStatus}");

                                                          if (searchModelObject
                                                              .data![index]
                                                              .carsUsageType ==
                                                              "EV Subscriptions") {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        EVCarDescription(
                                                                          carName: searchModelObject.data![
                                                                          index]
                                                                              .vehicalName,
                                                                          carPrice: formattedPrice,
                                                                          carImage: searchModelObject.data![index].image1!.endsWith('.jpg') || searchModelObject.data![index].image1!.endsWith('.png') || searchModelObject.data![index].image1!.endsWith('.jpeg')
                                                                              ? "$baseUrlImage${searchModelObject.data?[index].image1}"
                                                                              : searchModelObject.data?[index].image1,
                                                                          carYear:
                                                                          "${searchModelObject.data![index].year}",
                                                                          carId:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsId,
                                                                          carRating:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .rating,
                                                                          carColorName:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsColors!
                                                                              .name,
                                                                          carMakesName:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsMakes!
                                                                              .name,
                                                                          carModelName:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsModels!
                                                                              .name,
                                                                          carMakesImage:
                                                                          "$baseUrlImage${searchModelObject.data![index].carsMakes!.image}",
                                                                          // carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                                          discountPercentage:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .discountPercentage,
                                                                          carDiscountPrice:discountFormattedPrice,
                                                                          carOwnerImage:
                                                                          "$baseUrlImage${searchModelObject.data![index].usersCompanies!.companyLogo}",
                                                                          carOwnerName:
                                                                          "${searchModelObject.data![index].usersCompanies!.companyName}",
                                                                          carOwnerId: searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .usersCompanies!
                                                                              .usersCompaniesId,
                                                                          myCarDescription:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .description,
                                                                          favouriteStatus:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .favouriteStatus,

                                                                          featureSuv:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresSuv,
                                                                          featuresDoors:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresDoors,
                                                                          featuresSeats:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresSeats,
                                                                          featuresAutomatic:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresAutomatic,
                                                                          featuresSpeed:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresSpeed,
                                                                          featuresElectric:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresElectric,
                                                                          featuresEngine_capacity:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresEngineCapacity,
                                                                          featuresFuelCapacity:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresFuelCapacity,
                                                                          featuresMeterReading:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresMeterReading,
                                                                          featuresNewCars:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresNewCars,
                                                                        ),
                                                                ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.4,
                                                          decoration: BoxDecoration(
                                                              color: borderColor,
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  30)),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                    "Click to see Details",
                                                                    textAlign:
                                                                    TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: kWhite,
                                                                        fontFamily:
                                                                        poppinMedium,
                                                                        fontSize: 10)),
                                                                SizedBox(width: 10),
                                                                Image.asset(
                                                                    "assets/home_page/more_buttons_home.png")
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
                                            top: 0,
                                            left: 10,
                                            right: 10,
                                            child: searchModelObject.data?[index].image1 == null
                                                ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset('assets/icon/fade_in_image.jpeg'),
                                            )
                                                : searchModelObject.data![index].image1!.endsWith('.jpg') || searchModelObject.data![index].image1!.endsWith('.png') || searchModelObject.data![index].image1!.endsWith('.jpeg')
                                                ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: FadeInImage(
                                                placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                                                height: 65,
                                                image: NetworkImage("$baseUrlImage${searchModelObject.data?[index].image1}"),
                                              ),
                                            )
                                                : Container(
                                              height: 130,
                                              child: ModelViewer(
                                                backgroundColor: Colors.transparent,
                                                // src: '$baseUrlImage${topRentedCarsModelObject.data?[index].image1}',
                                                src: '${searchModelObject.data?[index].image1}',
                                                alt: "A 3D model of car",
                                                autoPlay: false,
                                                autoRotate: false,
                                                cameraControls: false,
                                                disableTap: false,
                                                ar: false,
                                                disablePan: true,
                                                arModes: ["quicklook", "scene-viewer"],
                                                iosSrc: "${searchModelObject.data?[index].image1}",
                                                disableZoom: true,
                                              ),
                                            ),
                                          ),
                                          searchModelObject.data?[index].discountPercentage != "0.00"
                                              ? Positioned(
                                            top: 03,
                                            left: 05,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.065,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.19,
                                              decoration: BoxDecoration(
                                                color: kRed.withOpacity(0.8),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(0.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${searchModelObject.data?[index].discountPercentage}% ",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: kWhite,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                poppinSemiBold)),
                                                    Text("OFF",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: kWhite,
                                                            fontSize: 8,
                                                            fontFamily:
                                                                poppinRegular)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          : SizedBox(),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.5,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 0,
                                  ),
                                  itemCount: searchModelObject.data?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                        var pricePerMonthString = searchModelObject.data?[index].carsPlans![0].pricePerMonth;
                                        double pricePerMonth;
                                        String formattedPrice = "";
                                        if (pricePerMonthString != null) {
                                          pricePerMonth = double.parse(pricePerMonthString);
                                          if (pricePerMonth != null) {
                                            final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                            formattedPrice = numberFormat.format(pricePerMonth);
                                            // print("RM $formattedPrice");
                                          } else {
                                            print("Invalid price format");
                                          }
                                        } else {
                                          print("Price not available");
                                        }

                                        var discountPricePerMonthString = searchModelObject.data?[index].carsPlans![0].discountedPricePerMonth;
                                        double discountPricePerMonth;
                                        String discountFormattedPrice = "";
                                        if (discountPricePerMonthString != null) {
                                          discountPricePerMonth = double.parse(discountPricePerMonthString);
                                          if (discountPricePerMonth != null) {
                                            final numberFormat = NumberFormat.decimalPattern(); // Creates a number format with commas for thousands
                                            discountFormattedPrice = numberFormat.format(discountPricePerMonth);
                                            // print("RM $discountFormattedPrice");
                                          } else {
                                            print("Invalid price format");
                                          }
                                        } else {
                                          print("Price not available");
                                        }
                                    return Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 50,
                                            left: 0,
                                            right: 0,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.21,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.47,
                                                decoration: BoxDecoration(
                                                    color: kWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.06),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              // Text("${searchModelObject.data?[index].vehicalName} ",
                                                              Text(
                                                                  "${searchModelObject.data?[index].vehicalName} ",
                                                                  style: TextStyle(
                                                                      color:
                                                                          kBlack,
                                                                      fontSize:
                                                                          8,
                                                                      fontFamily:
                                                                          poppinBold)),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 4),
                                                                child: Text(
                                                                    "${searchModelObject.data?[index].carsColors?.name} ",
                                                                    style: TextStyle(
                                                                        color:
                                                                            kBlack,
                                                                        fontSize:
                                                                            7,
                                                                        fontFamily:
                                                                            poppinRegular)),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox()
                                                          // Row(
                                                          //   children: [
                                                          //     searchModelObject
                                                          //                 .data?[
                                                          //                     index]
                                                          //                 .rating ==
                                                          //             null
                                                          //         ? RatingBar(
                                                          //             // initialRating: double.parse("${searchModelObject.data?[index].rating}"),
                                                          //             initialRating:
                                                          //                 0.0,
                                                          //             direction:
                                                          //                 Axis
                                                          //                     .horizontal,
                                                          //             allowHalfRating:
                                                          //                 true,
                                                          //             itemCount:
                                                          //                 1,
                                                          //             minRating:
                                                          //                 0,
                                                          //             itemSize:
                                                          //                 18.0,
                                                          //             ignoreGestures:
                                                          //                 true,
                                                          //             ratingWidget:
                                                          //                 RatingWidget(
                                                          //                     full: Icon(Icons.star,
                                                          //                         color:
                                                          //                             borderColor),
                                                          //                     half:
                                                          //                         Icon(
                                                          //                       Icons.star_half,
                                                          //                       color: borderColor,
                                                          //                     ),
                                                          //                     empty:
                                                          //                         Icon(
                                                          //                       Icons.star_outline,
                                                          //                       color: borderColor,
                                                          //                     )),
                                                          //             onRatingUpdate:
                                                          //                 (value) {})
                                                          //         : RatingBar(
                                                          //             initialRating:
                                                          //                 double.parse(
                                                          //                     "${searchModelObject.data?[index].rating}"),
                                                          //             // initialRating: searchModelObject.data?[index].rating,
                                                          //             direction:
                                                          //                 Axis
                                                          //                     .horizontal,
                                                          //             allowHalfRating:
                                                          //                 true,
                                                          //             itemCount:
                                                          //                 1,
                                                          //             minRating:
                                                          //                 0,
                                                          //             itemSize:
                                                          //                 18.0,
                                                          //             ignoreGestures:
                                                          //                 true,
                                                          //             ratingWidget: RatingWidget(
                                                          //                 full: Icon(Icons.star, color: borderColor),
                                                          //                 half: Icon(
                                                          //                   Icons.star_half,
                                                          //                   color:
                                                          //                       borderColor,
                                                          //                 ),
                                                          //                 empty: Icon(
                                                          //                   Icons.star_outline,
                                                          //                   color:
                                                          //                       borderColor,
                                                          //                 )),
                                                          //             onRatingUpdate: (value) {}),
                                                          //     searchModelObject
                                                          //                 .data?[
                                                          //                     index]
                                                          //                 .rating ==
                                                          //             null
                                                          //         ? Text("0.0",
                                                          //             style: TextStyle(
                                                          //                 color:
                                                          //                     kBlack,
                                                          //                 fontSize:
                                                          //                     10,
                                                          //                 fontFamily:
                                                          //                     poppinMedium))
                                                          //         : Text(
                                                          //             "${searchModelObject.data?[index].rating}",
                                                          //             style: TextStyle(
                                                          //                 color:
                                                          //                     kBlack,
                                                          //                 fontSize:
                                                          //                     10,
                                                          //                 fontFamily:
                                                          //                     poppinMedium)),
                                                          //   ],
                                                          // ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.01),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "${searchModelObject.data?[index].carsMakes?.name}, ",
                                                              style: TextStyle(
                                                                  color: kBlack,
                                                                  fontSize: 7,
                                                                  fontFamily:
                                                                      poppinRegular)),
                                                          Text(
                                                              "${searchModelObject.data?[index].carsModels?.name}, ",
                                                              style: TextStyle(
                                                                  color: kBlack,
                                                                  fontSize: 7,
                                                                  fontFamily:
                                                                      poppinSemiBold)),
                                                          Text(
                                                              "${searchModelObject.data?[index].year} ",
                                                              style: TextStyle(
                                                                  color: kBlack,
                                                                  fontSize: 7,
                                                                  fontFamily:
                                                                      poppinRegular)),
                                                        ],
                                                      ),
                                                      // SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                                      Divider(),
                                                      Row(
                                                        children: [
                                                          searchModelObject.data?[index].discountPercentage != "0.00"
                                                              ? Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            04),
                                                                child: Text(
                                                                    "RM ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color:
                                                                            kRed,
                                                                        fontSize:
                                                                            5,
                                                                        fontFamily:
                                                                            poppinLight)),
                                                              ),
                                                              searchModelObject
                                                                          .data?[
                                                                              index]
                                                                          .carsUsageType ==
                                                                      "EV Subscriptions"
                                                                  ? originalPriceWidget(
                                                                      "${formattedPrice}")
                                                                  : searchModelObject
                                                                              .data?[
                                                                                  index]
                                                                              .carsUsageType ==
                                                                          "Photography"
                                                                      ? originalPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans![0].pricePerHour}")
                                                                      : originalPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans![0].pricePerSlot}"),
                                                            ],
                                                          )
                                                              : SizedBox(),
                                                          SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.01),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            06),
                                                                child: Text(
                                                                    "RM ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color:
                                                                            borderColor,
                                                                        fontSize:
                                                                            7,
                                                                        fontFamily:
                                                                            poppinSemiBold)),
                                                              ),
                                                              searchModelObject
                                                                          .data?[
                                                                              index]
                                                                          .carsUsageType ==
                                                                      "EV Subscriptions"
                                                                  ? discountedPriceWidget(
                                                                      "${discountFormattedPrice}/",
                                                                      "")
                                                                  : searchModelObject
                                                                              .data?[
                                                                                  index]
                                                                              .carsUsageType ==
                                                                          "Photography"
                                                                      ? discountedPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans?[0].discountedPricePerHour}/",
                                                                          "Hour")
                                                                      : discountedPriceWidget(
                                                                          "${searchModelObject.data?[index].carsPlans?[0].discountedPricePerSlot}/",
                                                                          "Slot"),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                                      GestureDetector(
                                                        onTap: () {
                                                          carID = searchModelObject
                                                              .data![index].carsId;
                                                          print("cardId $carID");
                                                          print(
                                                              "carsUsageType ${searchModelObject.data?[index].carsUsageType}");
                                                          print(
                                                              "favouriteStatusHome ${searchModelObject.data?[index].favouriteStatus}");

                                                          if (searchModelObject
                                                              .data![index]
                                                              .carsUsageType ==
                                                              "EV Subscriptions") {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        EVCarDescription(
                                                                          carName: searchModelObject.data![
                                                                          index]
                                                                              .vehicalName,
                                                                          carPrice: formattedPrice,
                                                                          carImage: searchModelObject.data![index].image1!.endsWith('.jpg') || searchModelObject.data![index].image1!.endsWith('.png') || searchModelObject.data![index].image1!.endsWith('.jpeg')
                                                                              ? "$baseUrlImage${searchModelObject.data?[index].image1}"
                                                                              : searchModelObject.data?[index].image1,
                                                                          carYear:
                                                                          "${searchModelObject.data![index].year}",
                                                                          carId:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsId,
                                                                          carRating:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .rating,
                                                                          carColorName:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsColors!
                                                                              .name,
                                                                          carMakesName:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsMakes!
                                                                              .name,
                                                                          carModelName:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .carsModels!
                                                                              .name,
                                                                          carMakesImage:
                                                                          "$baseUrlImage${searchModelObject.data![index].carsMakes!.image}",
                                                                          // carStatus: topRentedCarsModelObject.data![index].favouriteStatus,
                                                                          discountPercentage:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .discountPercentage,
                                                                          carDiscountPrice:discountFormattedPrice,
                                                                          carOwnerImage:
                                                                          "$baseUrlImage${searchModelObject.data![index].usersCompanies!.companyLogo}",
                                                                          carOwnerName:
                                                                          "${searchModelObject.data![index].usersCompanies!.companyName}",
                                                                          carOwnerId: searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .usersCompanies!
                                                                              .usersCompaniesId,
                                                                          myCarDescription:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .description,
                                                                          favouriteStatus:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .favouriteStatus,

                                                                          featureSuv:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresSuv,
                                                                          featuresDoors:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresDoors,
                                                                          featuresSeats:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresSeats,
                                                                          featuresAutomatic:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresAutomatic,
                                                                          featuresSpeed:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresSpeed,
                                                                          featuresElectric:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresElectric,
                                                                          featuresEngine_capacity:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresEngineCapacity,
                                                                          featuresFuelCapacity:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresFuelCapacity,
                                                                          featuresMeterReading:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresMeterReading,
                                                                          featuresNewCars:
                                                                          searchModelObject
                                                                              .data![
                                                                          index]
                                                                              .featuresNewCars,
                                                                        )));
                                                          }
                                                        },
                                                        child: Container(
                                                          height: MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                              0.035,
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.4,
                                                          decoration: BoxDecoration(
                                                              color: borderColor,
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  30)),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                Text(
                                                                    "Click to see Details",
                                                                    textAlign:
                                                                    TextAlign.left,
                                                                    style: TextStyle(
                                                                        color: kWhite,
                                                                        fontFamily:
                                                                        poppinMedium,
                                                                        fontSize: 10)),
                                                                SizedBox(width: 10),
                                                                Image.asset(
                                                                    "assets/home_page/more_buttons_home.png")
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
                                            top: 0,
                                            left: 10,
                                            right: 10,
                                            child: searchModelObject.data?[index].image1 == null
                                                ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset('assets/icon/fade_in_image.jpeg'),
                                            )
                                                : searchModelObject.data![index].image1!.endsWith('.jpg') || searchModelObject.data![index].image1!.endsWith('.png') || searchModelObject.data![index].image1!.endsWith('.jpeg')
                                                ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: FadeInImage(
                                                placeholder: AssetImage("assets/icon/fade_in_image.jpeg"),
                                                height: 65,
                                                image: NetworkImage("$baseUrlImage${searchModelObject.data?[index].image1}"),
                                              ),
                                            )
                                                : Container(
                                              height: 130,
                                              child: ModelViewer(
                                                backgroundColor: Colors.transparent,
                                                // src: '$baseUrlImage${topRentedCarsModelObject.data?[index].image1}',
                                                src: '${searchModelObject.data?[index].image1}',
                                                alt: "A 3D model of car",
                                                autoPlay: false,
                                                autoRotate: false,
                                                cameraControls: false,
                                                disableTap: false,
                                                ar: false,
                                                disablePan: true,
                                                arModes: ["quicklook", "scene-viewer"],
                                                iosSrc: "${searchModelObject.data?[index].image1}",
                                                disableZoom: true,
                                              ),
                                            ),
                                          ),
                                          searchModelObject.data?[index].discountPercentage != "0.00"
                                              ? Positioned(
                                            top: 03,
                                            left: 05,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.065,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.19,
                                              decoration: BoxDecoration(
                                                color: kRed.withOpacity(0.8),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(0.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${searchModelObject.data?[index].discountPercentage}% ",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: kWhite,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                poppinSemiBold)),
                                                    Text("OFF",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: kWhite,
                                                            fontSize: 8,
                                                            fontFamily:
                                                                poppinRegular)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                              : SizedBox(),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          },
                        ),
    );
  }


  Widget discountedPriceWidget(price, typeText) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 04),
          child: Text("$price",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 12, fontFamily: poppinBold, color: borderColor)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(typeText,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: borderColor, fontSize: 8, fontFamily: poppinSemiBold)),
        ),
      ],
    );
  }
}
