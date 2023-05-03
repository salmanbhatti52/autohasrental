// import 'package:flutter/material.dart';
//
// import '../../../../../../Widget/colors.dart';
//
// class ApplePayScreen extends StatefulWidget {
//   ApplePayScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ApplePayScreen> createState() => _ApplePayScreenState();
// }
//
// class _ApplePayScreenState extends State<ApplePayScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     // showModalSheet();
//   }
//
//   showModalSheet(){
//     showModalBottomSheet(
//         context: context,
//         builder: (builder){
//           return Container(
//             height: 800.0,
//             decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20),
//                   topLeft: Radius.circular(20),
//                 )
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.06,
//                   width: MediaQuery.of(context).size.width ,
//                   decoration: BoxDecoration(
//                       color: borderColor, borderRadius: BorderRadius.circular(30)),
//                   child: Row(
//                     children: [
//                       Image.asset("assets/messages_images/apple_image.png", color: kWhite,),
//                       Text("Pay", textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white,
//                               fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400, fontSize: 18)),
//                     ],
//                   ),
//                 ),
//                 Text(" Modal BottomSheet",textScaleFactor: 2,
//                     style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
//               ],
//             ),
//           );
//         }
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: appBgColor,
//       body: Column(
//         children: [
//
//           showModalSheet(),
//
//         ],
//       ),
//     );
//   }
//
// }
