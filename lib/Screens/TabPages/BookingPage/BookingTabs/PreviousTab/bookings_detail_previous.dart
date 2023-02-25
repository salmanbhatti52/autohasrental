// import 'package:auto_haus_rental_app/Screens/TabPages/HomePage/HomePageTopCard/EvSubscriptions/ev_description_details_page.dart';
// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import '../../../../../Model/HomePageModels/BookingModels/Previous/booking_previous_model.dart';
// import '../../../../../Utils/colors.dart';
// import '../../../../../Utils/fontFamily.dart';
//
// class BookingsDetailsPrevious extends StatefulWidget {
//   final String? carName, carModel, carPrice, carRating, carColors,
//       carId, carYear, carMakes, carImage, discountPercentage;
//   const BookingsDetailsPrevious({super.key, this.carName, this.carModel, this.carId,
//     this.carYear, this.carImage, this.carMakes, this.discountPercentage, this.carColors,
//     this.carPrice, this.carRating});
//
//   @override
//   State<BookingsDetailsPrevious> createState() => _BookingsDetailsPreviousState();
// }
//
// class _BookingsDetailsPreviousState extends State<BookingsDetailsPrevious> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Container(
//             height: MediaQuery.of(context).size.height * 0.3,
//           ),
//         ),
//         Positioned(
//           top: 90,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 9),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.23,
//               width: 343,
//               decoration: BoxDecoration(
//                 color: kWhite,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 5,
//                     blurRadius: 5,
//                     offset: const Offset(3, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 0.08,
//                     color: Colors.transparent,
//                     child: const Padding(
//                       padding: EdgeInsets.only(top: 40, right: 20),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text("${widget.carName} ",
//                                     textAlign: TextAlign.left, style: TextStyle(
//                                         color: kBlack, fontSize: 14, fontFamily: poppinBold)),
//                                 Text("${widget.carColors}",
//                                     textAlign: TextAlign.left, style: TextStyle(
//                                         color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
//                               ],
//                             ),
//                             SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                             Row(
//                               children: [
//
//                                 Text("${widget.carModel} ",
//                                     textAlign: TextAlign.left, style: TextStyle(
//                                         color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                 Text("${widget.carMakes} ",
//                                     textAlign: TextAlign.left, style: TextStyle(
//                                         color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
//                                 Text("${widget.carYear} ",
//                                     textAlign: TextAlign.left, style: TextStyle(
//                                         color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                               ],
//                             ),
//                             SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                             Row(
//                               children: [
//                                 // Padding(
//                                 //   padding: const EdgeInsets.only(top: 04),
//                                 //   child: Text("RM", textAlign: TextAlign.left,
//                                 //       style: TextStyle(color: kRed, fontSize: 5, fontFamily: poppinRegular)),
//                                 // ),
//                                 // Text(previousItemsList[index].oldPrice,
//                                 //     textAlign: TextAlign.left, style: TextStyle(
//                                 //         color: kRed, fontSize: 10,
//                                 //         decoration: TextDecoration.lineThrough,
//                                 //         decorationColor: kRed,
//                                 //         decorationThickness: 3,
//                                 //         fontFamily: poppinLight,
//                                 //         height: 2)),
//                                 // const SizedBox(width: 5),
//                                 Padding(
//                                   padding: const EdgeInsets.only(top: 06),
//                                   child: Text("RM", textAlign: TextAlign.left,
//                                       style: TextStyle(color: borderColor,
//                                           fontSize: 7, fontFamily: poppinSemiBold)),
//                                 ),
//                                 Text("${widget.carPrice}",
//                                     textAlign: TextAlign.left, style: TextStyle(
//                                         color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
//                                 Text("/ Month", textAlign: TextAlign.left, style: TextStyle(
//                                     color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                                 SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                                 Image.asset("assets/car_bookings_images/rating_stars.png"),
//                                 SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//
//                                 widget.carRating == null?
//                                 Text("0.0", textAlign: TextAlign.left,
//                                     style: TextStyle(color: kBlack,
//                                         fontSize: 12, fontFamily: poppinRegular)):
//                                 Text("${widget.carRating}",
//                                     textAlign: TextAlign.left, style: TextStyle(
//                                         color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                               ],
//                             ),
//                             SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                             Row(
//                               children: [
//                                 Image.asset("assets/car_bookings_images/promoted.png"),
//                                 const SizedBox(width: 5,),
//                                 Text("Verified Dealer", textAlign: TextAlign.left,
//                                     style: TextStyle(color: textLabelColor,
//                                       fontSize: 10, fontFamily: poppinRegular,)),
//                                 const SizedBox(width: 05,),
//                                 Container(
//                                   height: 15, width: 35,
//                                   decoration: BoxDecoration(color: kBlack,
//                                       borderRadius: BorderRadius.circular(10)),
//                                   child: Center(
//                                     child: Text("New", textAlign: TextAlign.left, style: TextStyle(
//                                         color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 40,
//           child: CachedNetworkImage(
//             imageUrl: "$baseUrlImage${widget.carImage}",
//             // placeholder: (context, url) => CircularProgressIndicator(),
//             placeholder: (context, url) => Image.asset("assets/icon/fade_in_image.jpeg", height: 130,  width: 300),
//             errorWidget: (context, url, error) => const Icon(Icons.error),
//               height: 130,  width: 300
//           ),
//
//           // Image.network("$baseUrlImage${widget.datumPrevious!.carsDetails!.image1}",
//           //     height: 130,  width: 300),
//         ),
//         Positioned(
//             top: 10,
//             left: 15,
//             child: Container(
//               height: MediaQuery.of(context).size.width * 0.07,
//               width: MediaQuery.of(context).size.width * 0.16,
//               decoration: BoxDecoration(
//                 color: kRed.withOpacity(0.8),
//                 borderRadius: const BorderRadius.only(
//                     topRight: Radius.circular(15),
//                     bottomLeft: Radius.circular(15)),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("${widget.discountPercentage}",
//                       style: TextStyle(color: kWhite, fontSize: 13,
//                           fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
//                   Text(" OFF ", style: TextStyle(color: kWhite,
//                       fontSize: 8, fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
//                 ],
//               ),
//             )),
//
//         Positioned(
//           top: 10,
//           right: 15,
//           child: Image.asset("assets/car_bookings_images/heart.png",),
//         ),
//         Positioned(
//           top: 135,
//           right: 15,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => const EvDescriptionDetailsPage()));
//             },
//             child: Container(
//               width: 102,
//               height: 25,
//               decoration: BoxDecoration(
//                 color: borderColor,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Center(
//                 child: Text('Rebook', textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// List previousItemsList = [
//   PreviousItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
//       'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
// ];
//
// class PreviousItemsClass {
//   final String carImage;
//   final String discountText;
//   final String carCompanyName;
//   final String textModel;
//   final String range;
//   final String carModelYear;
//   final String oldPrice;
//   final String newPrice;
//
//   PreviousItemsClass(
//       this.carImage,
//       this.discountText,
//       this.carCompanyName,
//       this.textModel,
//       this.carModelYear,
//       this.range,
//       this.oldPrice,
//       this.newPrice);
// }
