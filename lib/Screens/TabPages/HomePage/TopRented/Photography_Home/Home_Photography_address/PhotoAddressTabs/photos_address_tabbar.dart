// import 'package:auto_haus_rental_app/Model/HomePageModels/top_rented_cars_model.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:flutter/material.dart';
//
// import 'photos_billing_address.dart';
// import 'photos_home_address.dart';
//
// class PhotosAddressTabBar extends StatefulWidget {
//   final DatumTopRented? datumPhotography;
//   final String? amount, myDate, myDay, selectedHours, selectedStartTime, selectedEndTime;
//   final int? totalHoursInNumber;
//   final double? hoursAmount, totalAmount;
//
//   const PhotosAddressTabBar({Key? key,     this.datumPhotography,
//     this.selectedHours, this.myDate, this.myDay, this.totalHoursInNumber,
//     this.hoursAmount, this.totalAmount, this.selectedStartTime, this.selectedEndTime,
//     this.amount}): super(key: key);
//
//   @override
//   State<PhotosAddressTabBar> createState() => _PhotosAddressTabBarState();
// }
//
// abstract class TickerProvider {}
//
// class _PhotosAddressTabBarState extends State<PhotosAddressTabBar> with TickerProviderStateMixin {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // mySelectedData();
//   }
//
//
//   List<String> tabs = ["Home Address", "Billing Address",];
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: 2, vsync: this);
//
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 48,
//               decoration: BoxDecoration(
//                   color: const Color(0xffd4dce1),
//                   borderRadius: BorderRadius.circular(30)),
//               child: Padding(
//                 padding: const EdgeInsets.all(05),
//                 child: TabBar(
//                   controller: tabController,
//                   indicator: BoxDecoration(
//                     color: kWhite,
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   indicatorColor: kWhite,
//                   labelColor: kBlack,
//                   labelStyle: const TextStyle(fontSize: 12),
//                   unselectedLabelColor: kBlack,
//                   tabs: const [
//                     Tab(
//                       text: "Home Address",
//                     ),
//                     Tab(
//                       text: "Billing Address",
//                     ),
//
//                   ],
//                 ),
//               )),
//         ),
//         SizedBox(
//           width: double.maxFinite,
//           height: MediaQuery.of(context).size.height*0.8,
//           child: TabBarView(
//             controller: tabController,
//             children: [
//               const PhotosHomeAddress(),
//               PhotosBillingAddress(
//                 datumPhotography: widget.datumPhotography,
//                 amount: widget.amount,
//                 selectedHours: widget.selectedHours,
//                 hoursAmount: widget.hoursAmount,
//                 totalAmount: widget.totalAmount,
//                 selectedStartTime: widget.selectedStartTime,
//                 selectedEndTime: widget.selectedEndTime,
//                 myDate: widget.myDate,
//                 myDay: widget.myDay,
//                 totalHoursInNumber: widget.totalHoursInNumber,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
