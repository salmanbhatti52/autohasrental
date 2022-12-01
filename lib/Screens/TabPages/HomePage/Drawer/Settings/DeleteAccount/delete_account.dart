// import 'package:flutter/material.dart';
// import '../../../../../../Widget/colors.dart';
// import '../settings_screen.dart';
//
// class DeleteAccountPage extends StatefulWidget {
//   const DeleteAccountPage({Key? key}) : super(key: key);
//
//   @override
//   State<DeleteAccountPage> createState() => _DeleteAccountPageState();
// }
//
// class _DeleteAccountPageState extends State<DeleteAccountPage> {
//
//
//   @override
//   void initState() {
//     super.initState();
//     _showDialog();
//   }
//
//   _showDialog() async {
//     await Future.delayed(const Duration(milliseconds: 50));
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0)), //this right here
//             child: Container(
//               // height: 300,
//               // color: homeBgColor,
//               // color: Colors.green,
//               decoration: BoxDecoration(
//                   color: homeBgColor,
//                   borderRadius: BorderRadius.circular(20)
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
//                           },
//                           child: Image.asset("assets/payment_card_images/cancle.png",),),
//                       ],
//                     ),
//
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
//                     Text("Delete Account", textAlign: TextAlign.center, style: TextStyle(color: kRed,
//                       fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Urbanist',),),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                     Text("Are you sure you want to delete your account?",
//                       textAlign: TextAlign.center, style: TextStyle(color: kBlack,
//                       fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Urbanist',),),
//                     // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     GestureDetector(
//                         onTap: (){
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
//                         },
//                         child: yesButton()),
//                     GestureDetector(
//                         onTap: (){
//                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
//                         },
//                         child: noButton()),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget yesButton(){
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.05,
//         width: MediaQuery.of(context).size.width* 0.6,
//         decoration: BoxDecoration(
//           color: kRed,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: const Center(
//           child: Text("Yes",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.white,
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w400, fontSize: 16)
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget noButton(){
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 60, ),
//     child: Container(
//     height: MediaQuery.of(context).size.height * 0.05,
//     width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(color: borderColor, width: 2)
//       ),
//       child: Center(
//         child: Text("No", textAlign: TextAlign.center,
//             style: TextStyle(color: borderColor,
//                 fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16)
//         ),
//       ),
//     ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: homeBgColor,
//     );
//   }
//
//   onBackPressed() {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
//     // Get.back(result: () => const DeleteAccountPage());
//     // Get.back();
//
//   }
// }
