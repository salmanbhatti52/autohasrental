// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:flutter/material.dart';
// import '../Screens/TabPages/HomePage/Filter/filter_screen.dart';
// import '../Screens/TabPages/HomePage/Search/search_screen.dart';
//
// Widget searchWidget(BuildContext context){
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//     child: Row(
//       children: [
//         Expanded(
//           child: GestureDetector(
//             onTap: (){
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const SearchScreen()));
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: kWhite,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               height: MediaQuery.of(context).size.height * 0.06,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Text('Search for Cars',
//                         style: TextStyle(color: Color(0xffD4DCE1))),
//                     Icon(Icons.search, size: 18.0, color: Color(0xffD4DCE1),),
//                   ],
//                 ),
//               ),
//               // TextField(
//               //   keyboardType: TextInputType.text,
//               //   decoration: InputDecoration(
//               //     border: InputBorder.none,
//               //     contentPadding:
//               //     const EdgeInsets.fromLTRB(20, 12, 10, 0),
//               //     hintText: 'Search for Cars',
//               //     hintStyle: TextStyle(color: const Color(0xffD4DCE1),
//               //         fontSize: 14, fontFamily: poppinLight),
//               //     focusColor: borderColor,
//               //     suffixIcon: const Icon(Icons.search_outlined, color: Color(0xffD4DCE1)),
//               //   ),
//               //   style: TextStyle(color: borderColor, fontSize: 14),
//               // ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 15),
//         GestureDetector(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context) => const FilterScreen()));
//           },
//           child: Container(
//               height: 50, width: 50,
//               decoration: BoxDecoration(
//                   color: kWhite,
//                   borderRadius: BorderRadius.circular(30)
//               ),
//               child: Image.asset("assets/home_page/filter.png")),
//         ),
//       ],
//     ),
//   );
// }