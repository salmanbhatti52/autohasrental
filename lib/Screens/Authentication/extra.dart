// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../Widget/colors.dart';
// import '../TabPages/BookingPage/booking_page.dart';
// import '../TabPages/FavouritePage/favourite_page.dart';
// import '../TabPages/HomePage/home_page.dart';
// import '../TabPages/MessagePage/message_page.dart';
//
// class ExtraPage extends StatefulWidget {
//   const ExtraPage({super.key});
//
//   @override
//   _ExtraPageState createState() => _ExtraPageState();
// }
//
// class _ExtraPageState extends State<ExtraPage> {
//   int? currentIndex;
//   List<Widget>? _children;
//
//   @override
//   void initState() {
//     currentIndex = 0;
//     _children = [
//       const HomePage(),
//       const MessagePage(),
//       const BookingPage(),
//       const FavoritePage(),
//     ];
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       resizeToAvoidBottomInset: true,
//         tabBar: CupertinoTabBar(
//           backgroundColor: const Color(0xff0F172A),
//           currentIndex: currentIndex!,
//           onTap: onTabTapped,
//           items: [
//             BottomNavigationBarItem(
//               icon: Image.asset('assets/tab_images/home_image.png',
//                 color: currentIndex == 0 ? borderColor : unSelectedTabColor,
//                 width: 30,
//               ),
//               label:  'Home',
//             ),
//             BottomNavigationBarItem(
//                 icon: Image.asset(
//                   'assets/tab_images/messages_image.png',
//                   color: currentIndex == 1 ? borderColor : unSelectedTabColor,
//                   width: 25,
//                 ),
//                 label: 'Messages'),
//             BottomNavigationBarItem(
//                 icon: Image.asset('assets/tab_images/calendar_image.png',
//                   color: currentIndex == 2 ? borderColor : unSelectedTabColor,
//                   width: 30,
//                 ),
//                 label: 'Booking'),
//             BottomNavigationBarItem(
//                 icon: Image.asset('assets/tab_images/heart_image.png',
//                     color: currentIndex == 3 ? borderColor : unSelectedTabColor,
//                     width: 30),
//                 label: 'Favorities'),
//           ],
//
//         ),
//         tabBuilder: (BuildContext context, int index) {
//           return CupertinoTabView(
//             builder: (BuildContext context) {
//               return SafeArea(
//                 top: false,
//                 bottom: true,
//                 child: MaterialApp(
//                   debugShowCheckedModeBanner: false,
//                   home: CupertinoPageScaffold(
//                     backgroundColor: Colors.red,
//                     resizeToAvoidBottomInset: false,
//                     child: _children![currentIndex!],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//     );
//   }
//
//   void onTabTapped(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }
// }
// //
// // class Screen3 extends StatefulWidget {
// //   @override
// //   _Screen3State createState() => _Screen3State();
// // }
// //
// // class _Screen3State extends State<Screen3> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Colors.black,
// //       child: Center(
// //         child: RaisedButton(
// //           child: Text("Click me"),
// //           onPressed: () {
// //             Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
// //                 builder: (context) => Screen4(), maintainState: false));
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// // }