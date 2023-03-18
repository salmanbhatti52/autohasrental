// import 'package:auto_haus_rental_app/Model/get_rate_cars_model.dart';
// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
// import 'package:auto_haus_rental_app/Widget/button.dart';
// import 'package:auto_haus_rental_app/Widget/cars_home_widget.dart';
// import 'package:auto_haus_rental_app/Widget/toast_message.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../../../Model/BookingModels/Previous/EvPrevious/ev_previous_model.dart';
// import '../../../../../../../Model/car_ratings_model.dart';
// import '../../../../../MyAppBarHeader/app_bar_header.dart';
// import 'package:http/http.dart'as http;
//
// import 'EvTabs/ev_booking_tabbar.dart';
//
// class EvBookingDetailPage extends StatefulWidget {
//   // final String? carDesc, carMonths;
//   final DatumPreviousEv? datumPreviousEv;
//
//   EvBookingDetailPage({super.key, this.datumPreviousEv, /*this.carDesc, this.carMonths*/});
//
//   @override
//   State<EvBookingDetailPage> createState() => _EvBookingDetailPageState();
// }
//
// class _EvBookingDetailPageState extends State<EvBookingDetailPage> {
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
//     print('userId in getRateCarApi $userId ${widget.datumPreviousEv!.carsId}');
//
//     // try {
//     String apiUrl = getRateCarApiUrl;
//     print("getRateCarApi: $apiUrl");
//     final response = await http.post(Uri.parse(apiUrl), headers: {
//       'Accept': 'application/json'
//     },
//         body: {
//           "users_customers_id": userId,
//           "cars_id": "${widget.datumPreviousEv!.carsId}",
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
//                                         Text("${widget.datumPreviousEv!.carsDetails!.vehicalName} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 14, fontFamily: poppinBold)),
//                                         Text("${widget.datumPreviousEv!.carsDetails!.carsColors!.name}",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
//                                       ],
//                                     ),
//                                     // SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                     Row(
//                                       children: [
//
//                                         Text("${widget.datumPreviousEv!.carsDetails!.carsModels} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                         Text("${widget.datumPreviousEv!.carsDetails!.carsMakes} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
//                                         Text("${widget.datumPreviousEv!.carsDetails!.year} ",
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
//                                         Text("${widget.datumPreviousEv!.carsPlans![0].pricePerMonth}",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
//                                         Text("/ Month", textAlign: TextAlign.left, style: TextStyle(
//                                             color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                                         SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                                         showRatingStars(double.parse("${widget.datumPreviousEv!.carsDetails!.rating}")),
//                                         SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//
//                                         widget.datumPreviousEv!.carsDetails!.rating == null?
//                                         Text("0.0", textAlign: TextAlign.left,
//                                             style: TextStyle(color: kBlack,
//                                                 fontSize: 12, fontFamily: poppinRegular)):
//                                         Text("${widget.datumPreviousEv!.carsDetails!.rating}",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                       ],
//                                     ),
//                                     SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                                     verifiedDealerText(),
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
//                       imageUrl: "$baseUrlImage${widget.datumPreviousEv!.carsDetails!.image1}",
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
//                           Text("${widget.datumPreviousEv!.carsDetails!.discountPercentage}",
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
//                   child: Image.asset("assets/car_bookings_images/heart.png",),
//                 ),
//                 // Positioned(
//                 //   top: 135,
//                 //   right: 15,
//                 //   child: GestureDetector(
//                 //     onTap: () {
//                 //       Navigator.push(context, MaterialPageRoute(
//                 //           builder: (context) => EvSubscriptionPage()));
//                 //     },
//                 //     child: Container(
//                 //       width: 80,
//                 //       height: 35,
//                 //       decoration: BoxDecoration(
//                 //         color: borderColor,
//                 //         borderRadius: BorderRadius.circular(30),
//                 //       ),
//                 //       child: Center(
//                 //         child: Text('Rebook', textAlign: TextAlign.center,
//                 //             style: TextStyle(
//                 //                 fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//             EvBookingTabbar(
//               datumP: widget.datumPreviousEv,
//             ),
//             GestureDetector(
//                 onTap: () {
//                   if(getRateCarsModel.message == "Rating already given"){
//                     toastSuccessMessage("${getRateCarsModel.message}", kRed);
//                   }
//                   else{
//                     ratingsDialogBox(context);
//                   }
//                 },
//                 child: loginButton('Give Ratings', context)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   carRatingsWidget() async {
//     loadingP = true;
//     setState(() {});
//
//     prefs = await SharedPreferences.getInstance();
//     userId = (prefs!.getString('userid'));
//     print('in rateCarApi');
//
//     // try {
//     String apiUrl = carsRatingApiUrl;
//     print("rateCarModelApi: $apiUrl");
//     print("userId carId: $userId ${widget.datumPreviousEv!.carsId}");
//     print("rateCarMControllerApi: ${carRatingController.text}");
//     print("ratingValue: $ratingValue");
//     final response = await http.post(Uri.parse(apiUrl), headers: {
//       'Accept': 'application/json'
//     }, body: {
//       "users_customers_id": userId,
//       "cars_id" : "${widget.datumPreviousEv!.carsId}",
//       "comments": carRatingController.text,
//       "rate_stars": "$ratingValue"
//
//     });
//     print('${response.statusCode}');
//     print(response);
//     if (response.statusCode == 200) {
//       final responseString = response.body;
//       print("responseCarRatings: ${responseString.toString()}");
//       loadingP = false;
//       setState(() {});
//       rateCarModelObject = rateCarModelFromJson(responseString);
//       print("rateCarMessage: ${rateCarModelObject.message}");
//       Navigator.pop(context);
//     }
//     // } catch (e) {
//     //   print('Error in upcomingBookingCar: ${e.toString()}');
//     // }
//     loadingP = false;
//     setState(() {});
//   }
//
//   void ratingsDialogBox(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return Container(
//             color: Color(0xffb0b0b0),
//             child: Container(
//               color: Color(0xff0f172a).withOpacity(0.5),
//               child: AlertDialog(
//                 backgroundColor: homeBgColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 content: SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Image.asset('assets/car_bookings_images/close.png'),
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                       Text("Ratings",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: borderColor),
//                       ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02),
//                       Text(
//                         "Give your Ratings \n   and Feedback",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xffb0b0b0),
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                       RatingBar(
//                           initialRating: 0,
//                           direction: Axis.horizontal,
//                           allowHalfRating: true,
//                           itemCount: 5,
//                           minRating: 1,
//                           itemSize: 30.0,
//                           ratingWidget: RatingWidget(
//                               full: Icon(Icons.star, color: borderColor),
//                               half: Icon(
//                                 Icons.star_half,
//                                 color: borderColor,
//                               ),
//                               empty: Icon(
//                                 Icons.star_outline,
//                                 color: borderColor,
//                               )),
//                           onRatingUpdate: (value) {
//                             setState(() {
//                               ratingValue = value;
//                               print("ratingValue $ratingValue");
//                             });
//                           }),
//
//                       // Image.asset(
//                       //   "assets/car_bookings_images/rating.png",
//                       //   height: 30,
//                       // ),
//                       SizedBox(
//                           height: MediaQuery.of(context).size.height * 0.02),
//                       Form(
//                         key: ratingsFormKey,
//                         child: TextField(
//                           cursorColor: borderColor,
//                           controller: carRatingController,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: 4,
//                           decoration: InputDecoration(
//                             hintText: "Add your feedback",
//                             hintStyle: TextStyle(
//                                 fontSize: 16, color: Color(0xffb0b0b0)),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: BorderSide(
//                                 color: Color(0xffd4dce1),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10, left: 90),
//                         child: Text(
//                           "*Maximum 150 characters",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: borderColor,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 25),
//                         child: GestureDetector(
//                           onTap: () async {
//
//                             print("ratingValue $ratingValue");
//                             if(ratingsFormKey.currentState!.validate()){
//                               if(carRatingController.text.isEmpty){
//                                 toastFailedMessage("Please add your feedback", kRed);
//                               } else {
//                                 await carRatingsWidget();
//
//                                 if(rateCarModelObject.status == "Success"){
//                                   // Navigator.pop(context);
//                                   toastSuccessMessage("${rateCarModelObject.message}", colorGreen);
//                                 }
//                                 if(rateCarModelObject.status == "error"){
//                                   toastFailedMessage("${rateCarModelObject.message}", kRed);
//                                 }
//                               }
//                             }
//                           },
//                           child: Center(
//                             child: Container(
//                               height: 44,
//                               width: 202,
//                               decoration: BoxDecoration(
//                                   color: borderColor,
//                                   borderRadius: BorderRadius.circular(30)),
//                               child: Center(
//                                 child: Text('Okay',
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: 'Poppins',
//                                         fontSize: 16)),
//                               ),
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
// }