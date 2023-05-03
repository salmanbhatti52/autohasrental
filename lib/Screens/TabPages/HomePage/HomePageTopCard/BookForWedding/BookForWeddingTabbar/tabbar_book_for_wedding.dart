// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:flutter/material.dart';
// import '../../../../../../Utils/colors.dart';
// import '../../EvSubscriptions/EvTaBBar/rating_page.dart/photo_rating_details.dart';
// import 'description_page/description.dart';
// import 'feature_page/features.dart';
// import 'rating_page.dart/photo_rating_details.dart';
//
// class TabbarBookForWedding extends StatefulWidget {
//   TabbarBookForWedding({super.key});
//
//   @override
//   State<TabbarBookForWedding> createState() => _TabbarBookForWeddingState();
// }
//
// abstract class TickerProvider {}
//
// class _TabbarBookForWeddingState extends State<TabbarBookForWedding>
//     with TickerProviderStateMixin {
//   List<String> tabs = ["Description", "Features", "Ratings"];
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: 3, vsync: this);
//
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: 20, right: 20),
//           child: Container(
//               width: 344,
//               height: 48,
//               decoration: BoxDecoration(
//                   color: Color(0xffd4dce1),
//                   borderRadius: BorderRadius.circular(30)),
//               child: Padding(
//                 padding: EdgeInsets.all(5),
//                 child: TabBar(
//                   controller: tabController,
//                   indicator: BoxDecoration(
//                     color: kWhite,
//                     borderRadius: BorderRadius.circular(30.0),
//                   ),
//                   indicatorColor: kWhite,
//                   // isScrollable: true,
//                   labelColor: kBlack,
//                   labelStyle: TextStyle(
//                       fontSize: 12, fontFamily: poppinRegular),
//                   unselectedLabelColor: kBlack,
//                   tabs: [
//                     Tab(
//                       text: "Description",
//                     ),
//                     Tab(
//                       text: "Features",
//                     ),
//                     Tab(
//                       text: "Ratings",
//                     ),
//                   ],
//                 ),
//               )),
//         ),
//         SizedBox(
//           width: double.maxFinite,
//           height: MediaQuery.of(context).size.height * 0.25,
//           child: TabBarView(
//             controller: tabController,
//             children: [
//               Description(),
//               Features(),
//               EvRating(
//                 carRating: widget.myRating,
//                 carComment: widget.myComment,
//               ),
//             ]
//           ),
//         ),
//       ],
//     );
//   }
// }
