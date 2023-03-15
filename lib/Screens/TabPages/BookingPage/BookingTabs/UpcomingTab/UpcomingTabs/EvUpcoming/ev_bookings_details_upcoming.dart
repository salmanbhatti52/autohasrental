// import 'package:auto_haus_rental_app/Model/get_rate_cars_model.dart';
// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../../../Model/BookingModels/Upcoming/EvUpComing/ev_upcoming_model.dart';
// import '../../../../../../../Model/car_ratings_model.dart';
// import '../../../../../MyAppBarHeader/app_bar_header.dart';
// import 'package:http/http.dart'as http;
// import 'EvUpcomingDetailsTabs/ev_upcoming_details_tabs.dart';
//
// class EvBookingDetailsUpcoming extends StatefulWidget {
//   final EvUpcomingDatum? datumEvUpcoming;
//
//   EvBookingDetailsUpcoming({super.key, this.datumEvUpcoming});
//
//   @override
//   State<EvBookingDetailsUpcoming> createState() => _EvBookingDetailsUpcomingState();
// }
//
// class _EvBookingDetailsUpcomingState extends State<EvBookingDetailsUpcoming> {
//   double? ratingValue;
//   var carRatingController = TextEditingController();
//   final GlobalKey<FormState> ratingsFormKey = GlobalKey<FormState>();
//   RateCarModel rateCarModelObject = RateCarModel();
//   GetStatusRateCarsModel getRateCarsModel = GetStatusRateCarsModel();
//   bool loadingP = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getRateCarWidget();
//     super.initState();
//   }
//
//   getRateCarWidget() async {
//     loadingP = true;
//     setState(() {});
//
//     prefs = await SharedPreferences.getInstance();
//     userId = (prefs!.getString('userid'));
//     // print('in getRateCarApi');
//     print('userId in getRateCarApi $userId ${widget.datumEvUpcoming!.carsId}');
//
//     // try {
//     String apiUrl = getRateCarApiUrl;
//     print("getRateCarApi: $apiUrl");
//     final response = await http.post(Uri.parse(apiUrl), headers: {
//       'Accept': 'application/json'
//     },
//         body: {
//           "users_customers_id": userId,
//           "cars_id": "${widget.datumEvUpcoming!.carsId}",
//         });
//     print('${response.statusCode}');
//     print(response);
//     if (response.statusCode == 200) {
//       final responseString = response.body;
//       print("responseGetRateCar: ${responseString.toString()}");
//       loadingP = false;
//       setState(() {});
//       getRateCarsModel = getStatusRateCarsModelFromJson(responseString);
//       print("getRateCarApiMessage: ${getRateCarsModel.message}");
//     }
//     // } catch (e) {
//     //   print('Error in upcomingBookingCar: ${e.toString()}');
//     // }
//     loadingP = false;
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBarSingleImage(
//           backImage: "assets/car_bookings_images/back_arrow.png", title: "Bookings"),
//       backgroundColor: homeBgColor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 20),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.3,
//                   ),
//                 ),
//                 Positioned(
//                   top: 90,
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 9),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.23,
//                       width: 343,
//                       decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.1),
//                             spreadRadius: 5,
//                             blurRadius: 5,
//                             offset: Offset(3, 3),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.08,
//                             color: Colors.transparent,
//                             child: Padding(
//                               padding: EdgeInsets.only(top: 40, right: 20),
//                               child: Align(
//                                 alignment: Alignment.centerRight,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 15),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text("${widget.datumEvUpcoming!.carsDetails!.vehicalName} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 14, fontFamily: poppinBold)),
//                                         Text("${widget.datumEvUpcoming!.carsDetails!.carsColors!.name}",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
//                                       ],
//                                     ),
//                                     // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                     Row(
//                                       children: [
//
//                                         Text("${widget.datumEvUpcoming!.carsDetails!.carsModels} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                         Text("${widget.datumEvUpcoming!.carsDetails!.carsMakes} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
//                                         Text("${widget.datumEvUpcoming!.carsDetails!.year} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                       ],
//                                     ),
//                                     // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                     Row(
//                                       children: [
//
//                                         Padding(
//                                           padding: EdgeInsets.only(top: 06),
//                                           child: Text("RM", textAlign: TextAlign.left,
//                                               style: TextStyle(color: borderColor,
//                                                   fontSize: 7, fontFamily: poppinSemiBold)),
//                                         ),
//                                         Text("${widget.datumEvUpcoming!.carsPlans![0].pricePerMonth}",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
//                                         Text("/ Month", textAlign: TextAlign.left, style: TextStyle(
//                                             color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                                         SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                                         showRatingStars(double.parse("${widget.datumEvUpcoming!.carsDetails!.rating}")),
//                                         SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//
//                                         widget.datumEvUpcoming!.carsDetails!.rating == null?
//                                         Text("0.0", textAlign: TextAlign.left,
//                                             style: TextStyle(color: kBlack,
//                                                 fontSize: 12, fontFamily: poppinRegular)):
//                                         Text("${widget.datumEvUpcoming!.carsDetails!.rating}",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                       ],
//                                     ),
//                                     SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                     Row(
//                                       children: [
//                                         Image.asset("assets/car_bookings_images/promoted.png"),
//                                         SizedBox(width: 5,),
//                                         Text("Verified Dealer", textAlign: TextAlign.left,
//                                             style: TextStyle(color: textLabelColor,
//                                               fontSize: 10, fontFamily: poppinRegular,)),
//                                         SizedBox(width: 05,),
//                                         Container(
//                                           height: 15, width: 35,
//                                           decoration: BoxDecoration(color: kBlack,
//                                               borderRadius: BorderRadius.circular(10)),
//                                           child: Center(
//                                             child: Text("New", textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 40,
//                   child: CachedNetworkImage(
//                       imageUrl: "$baseUrlImage${widget.datumEvUpcoming!.carsDetails!.image1}",
//                       // placeholder: (context, url) => CircularProgressIndicator(),
//                       placeholder: (context, url) => Image.asset("assets/icon/fade_in_image.jpeg", height: 130,  width: 300),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                       height: 130,  width: 300
//                   ),
//
//                   // Image.network("$baseUrlImage${widget.datumPrevious!.carsDetails!.image1}",
//                   //     height: 130,  width: 300),
//                 ),
//                 Positioned(
//                     top: 10,
//                     left: 15,
//                     child: Container(
//                       height: MediaQuery.of(context).size.width * 0.07,
//                       width: MediaQuery.of(context).size.width * 0.16,
//                       decoration: BoxDecoration(
//                         color: kRed.withOpacity(0.8),
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(15),
//                             bottomLeft: Radius.circular(15)),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("${widget.datumEvUpcoming!.carsDetails!.discountPercentage}",
//                               style: TextStyle(color: kWhite, fontSize: 13,
//                                   fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
//                           Text(" OFF ", style: TextStyle(color: kWhite,
//                               fontSize: 8, fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
//                         ],
//                       ),
//                     )),
//
//                 Positioned(
//                   top: 10,
//                   right: 15,
//                   child: Image.asset("assets/car_bookings_images/heart.png"),
//                 ),
//               ],
//             ),
//             EvUpcomingTabsPages(
//               datumUpcoming: widget.datumEvUpcoming,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
