// import 'package:auto_haus_rental_app/Model/car_ratings_model.dart';
// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
// import 'package:auto_haus_rental_app/Widget/toast_message.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../../../Model/BookingModels/Upcoming/DrivingUpComing/driving_upcoming_model.dart';
// import '../../../../../../../Model/BookingModels/booking_cancel_dialogbox_model.dart';
// import '../../../../../MyAppBarHeader/app_bar_header.dart';
// import 'package:http/http.dart'as http;
// import 'DrivingTabs/driving_upcoming_tabbar.dart';
//
// class DrivingUpcomingDetailsPage extends StatefulWidget {
//   final DrivingDatum? drivingDatum;
//
//   DrivingUpcomingDetailsPage({super.key, this.drivingDatum});
//
//   @override
//   State<DrivingUpcomingDetailsPage> createState() => _DrivingUpcomingDetailsPageState();
// }
//
// class _DrivingUpcomingDetailsPageState extends State<DrivingUpcomingDetailsPage> {
//
//   double? ratingValue;
//   var carRatingController = TextEditingController();
//   final GlobalKey<FormState> ratingsFormKey = GlobalKey<FormState>();
//   RateCarModel rateCarModelObject = RateCarModel();
//   bool loadingP = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // print("carImage ${widget.carImage}}");
//     // print("carImage1 ${widget.userComment}}");
//     // print("carImage2 ${widget.userRating}}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBarSingleImage(
//           backImage: "assets/car_bookings_images/back_arrow.png",
//           title: "Bookings"),
//       backgroundColor: homeBgColor,
//       body: SingleChildScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.35,
//               color: Colors.transparent,
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 20),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.3,
//                     ),
//                   ),
//                   Positioned(
//                     top: 90,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 9),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.23,
//                         width: 343,
//                         decoration: BoxDecoration(
//                           color: kWhite,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.1),
//                               spreadRadius: 5,
//                               blurRadius: 5,
//                               offset: Offset(3, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: MediaQuery.of(context).size.height * 0.08,
//                               color: Colors.transparent,
//                               child: Padding(
//                                 padding: EdgeInsets.only(top: 40, right: 20),
//                                 child: Align(
//                                   alignment: Alignment.centerRight,
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: 15),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text("${widget.drivingDatum!.carsDetails!.vehicalName} ",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 14, fontFamily: poppinBold)),
//                                           Text("${widget.drivingDatum!.carsDetails!.carsColors!.name}",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
//                                         ],
//                                       ),
//                                       // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                       Row(
//                                         children: [
//
//                                           Text("${widget.drivingDatum!.carsDetails!.carsModels} ",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                           Text("${widget.drivingDatum!.carsDetails!.carsMakes} ",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
//                                           Text("${widget.drivingDatum!.carsDetails!.year} ",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                         ],
//                                       ),
//                                       // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                       Row(
//                                         children: [
//
//                                           Padding(
//                                             padding: EdgeInsets.only(top: 06),
//                                             child: Text("RM", textAlign: TextAlign.left,
//                                                 style: TextStyle(color: borderColor,
//                                                     fontSize: 7, fontFamily: poppinSemiBold)),
//                                           ),
//                                           Text("${widget.drivingDatum!.carsPlans![0].pricePerSlot}",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
//                                           Text("/Slot", textAlign: TextAlign.left, style: TextStyle(
//                                               color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                                           SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                                           showRatingStars(double.parse("${widget.drivingDatum!.carsDetails!.rating}")),
//                                           SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//
//                                           widget.drivingDatum!.carsDetails!.rating == null?
//                                           Text("0.0", textAlign: TextAlign.left,
//                                               style: TextStyle(color: kBlack,
//                                                   fontSize: 12, fontFamily: poppinRegular)):
//                                           Text("${widget.drivingDatum!.carsDetails!.rating}",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                         ],
//                                       ),
//                                       SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                       Row(
//                                         children: [
//                                           Image.asset("assets/car_bookings_images/promoted.png"),
//                                           SizedBox(width: 5,),
//                                           Text("Verified Dealer", textAlign: TextAlign.left,
//                                               style: TextStyle(color: textLabelColor,
//                                                 fontSize: 10, fontFamily: poppinRegular,)),
//                                           SizedBox(width: 05,),
//                                           Container(
//                                             height: 15, width: 35,
//                                             decoration: BoxDecoration(color: kBlack,
//                                                 borderRadius: BorderRadius.circular(10)),
//                                             child: Center(
//                                               child: Text("New", textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 40,
//                     child: CachedNetworkImage(
//                         imageUrl: "$baseUrlImage${widget.drivingDatum!.carsDetails!.image1}",
//                         // placeholder: (context, url) => CircularProgressIndicator(),
//                         placeholder: (context, url) => Image.asset("assets/icon/fade_in_image.jpeg", height: 130,  width: 300),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                         height: 130,  width: 300
//                     ),
//                   ),
//                   Positioned(
//                       top: 10,
//                       left: 15,
//                       child: Container(
//                         height: MediaQuery.of(context).size.width * 0.07,
//                         width: MediaQuery.of(context).size.width * 0.16,
//                         decoration: BoxDecoration(
//                           color: kRed.withOpacity(0.8),
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(15),
//                               bottomLeft: Radius.circular(15)),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("${widget.drivingDatum!.carsDetails!.discountPercentage}",
//                                 style: TextStyle(color: kWhite, fontSize: 13,
//                                     fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
//                             Text(" OFF ", style: TextStyle(color: kWhite,
//                                 fontSize: 8, fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
//                           ],
//                         ),
//                       )),
//
//                   Positioned(
//                     top: 10,
//                     right: 15,
//                     child: Image.asset("assets/car_bookings_images/heart.png"),
//                   ),
//                 ],
//               ),
//             ),
//             DrivingUpcomingTabBar(
//               drivingDatum: widget.drivingDatum,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool progress = false;
//   void cancelDialogBox(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ModalProgressHUD(
//             inAsyncCall: progress,
//             opacity: 0.02,
//             blur: 0.5,
//             color: Colors.transparent,
//             progressIndicator: CircularProgressIndicator(
//               color: borderColor,
//             ),
//             child: Container(
//               color: Color(0xffb0b0b0),
//               child: Container(
//                 color: Color(0xff0f172a).withOpacity(0.5),
//                 child: AlertDialog(
//                   scrollable: true,
//                   backgroundColor: homeBgColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Image.asset(
//                               'assets/car_bookings_images/close.png'),
//                         ),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.01),
//                       Text(
//                         "Cancel?",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: borderColor),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02),
//                       Text(
//                         "Are you sure you want \n to cancel your booking?",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400,
//                           color: kBlack,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02),
//                       Text(
//                         "* Cancelling booking will result in \n 10% cut of your payment.",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xffff6666),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02),
//                       Text(
//                         "* Booking can not be cancelled if \n 24 hours are remaining in starting.",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xffff6666),
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.015),
//                       Padding(
//                         padding: EdgeInsets.only(top: 15),
//                         child: GestureDetector(
//                           onTap: () async {
//                             await cancelBookingDialogBoxModelWidget();
//                             if (bookingCancelDialogModelObject.status == "success") {
//                               toastSuccessMessage(bookingCancelDialogModelObject.message, colorGreen);
//                               Navigator.pop(context);
//                             }
//                             if (bookingCancelDialogModelObject.status != "success") {
//                               toastFailedMessage("booking not updated or its its already in cancelled status", kRed);
//                               Navigator.pop(context);
//                             }
//                             // Navigator.pop(context);
//                           },
//                           child: Container(
//                             width: 186,
//                             height: 44,
//                             decoration: BoxDecoration(
//                                 color: borderColor,
//                                 borderRadius: BorderRadius.circular(30)),
//                             child: Center(
//                               child: Text('Okay',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'Poppins',
//                                       fontSize: 16)),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 15),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             width: 186,
//                             height: 44,
//                             decoration: BoxDecoration(
//                                 color: Colors.transparent,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                     color: Color(0xffff6666), width: 1)),
//                             child: Center(
//                               child: Text('No',
//                                   style: TextStyle(
//                                       color: Color(0xffff6666),
//                                       fontFamily: 'Poppins',
//                                       fontSize: 16)),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//   BookingCancelDialogModel bookingCancelDialogModelObject = BookingCancelDialogModel();
//   cancelBookingDialogBoxModelWidget() async {
//     loadingP = true;
//     setState(() {});
//
//     prefs = await SharedPreferences.getInstance();
//     userId = (prefs!.getString('userid'));
//     print('in cancelBookingDialogModelApi');
//
//     try {
//       String apiUrl = cancelBookingDialogBoxApiUrl;
//       print("cancelBookingDialogModelModelApi: $apiUrl");
//       final response = await http.post(Uri.parse(apiUrl), headers: {
//         'Accept': 'application/json'
//       }, body: {
//         // "users_customers_id": "1",
//         "users_customers_id": userId,
//         "bookings_id": "1",
//         "status": "Cancelled",
//       });
//       print('statusCode ${response.statusCode}');
//       if (response.statusCode == 200) {
//         final responseString = response.body;
//         print("responseCancelBookingDialogModel: ${responseString.toString()}");
//         bookingCancelDialogModelObject =
//             bookingCancelDialogModelFromJson(responseString);
//         print(
//             "cancelBookingDialogModelStatus: ${bookingCancelDialogModelObject.status}");
//       }
//     } catch (e) {
//       print('Error in cancelBookingDialogModel: ${e.toString()}');
//     }
//     loadingP = false;
//     setState(() {});
//   }
// }
