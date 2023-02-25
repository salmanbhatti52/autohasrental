// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:auto_haus_rental_app/Widget/button.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import '../../../../../Utils/colors.dart';
// import '../../../../../Utils/constants.dart';
//
// class DEChooseSubscriptionPlan extends StatefulWidget {
//   const DEChooseSubscriptionPlan({Key? key}) : super(key: key);
//
//   @override
//   State<DEChooseSubscriptionPlan> createState() => _DEChooseSubscriptionPlanState();
// }
//
// class _DEChooseSubscriptionPlanState extends State<DEChooseSubscriptionPlan> {
//
//   DateTime? pickDate;
//   String valueDate = "Select Date";
//   String? valueDay;
//
//   selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       // firstDate: DateTime(1980),
//       firstDate: DateTime.now().subtract(const Duration(days: 0)),
//       lastDate: DateTime(2050),
//     );
//     if (picked != null && picked != pickDate) {
//       valueDate = DateFormat('MMMM yyyy').format(picked);
//       valueDay = DateFormat('EE, d').format(picked);
//       setState(() {
//         print("Selected Date is : $valueDate");
//         print("Selected Day is : $valueDay");
//       });
//     }
//   }
//
//   getToday() {
//     currentDay = DateFormat('EEEE d').format(DateTime.now());
//     print('currentDay = $currentDay');
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getToday();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             height: 30.0,
//             decoration: BoxDecoration(
//               color: borderColor,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Text('26 Dec 2022, Monday - 09:00 to 10:00',
//                     textAlign: TextAlign.left,
//                     style: TextStyle(fontSize: 12.0,
//                         fontFamily: poppinRegular, color: kWhite)),
//               ),
//             ),
//           ),
//           SizedBox(width: MediaQuery.of(context).size.width * 0.01),
//           GestureDetector(
//               onTap: () {
//                 showMaterialModalBottomSheet(
//                   backgroundColor: Colors.transparent,
//                   context: context,
//                   builder: (context) {
//                     return Container(
//                       height: MediaQuery.of(context).size.height * 0.55,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         color: homeBgColor,
//                         borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(20),
//                           topLeft: Radius.circular(20),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 16),
//                               child: Text('Change Available Time Slot',
//                                 style: TextStyle(fontSize: 14,
//                                     fontFamily: poppinBold, color: appBgColor),
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                           Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   selectDate(context);
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Icon(Icons.keyboard_arrow_left, color: Color(0xffa5a5a5)),
//                                     Text(valueDate,  textAlign: TextAlign.left,
//                                       style: TextStyle(fontSize: 14,
//                                           fontFamily: poppinSemiBold, color: borderColor),
//                                     ),
//                                     const Icon(
//                                       Icons.keyboard_arrow_right,
//                                       color: Color(0xffa5a5a5),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: MediaQuery.of(context).size.height* 0.02),
//
//                               valueDay == null?
//                               Container(
//                                 width: 120,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: kWhite,
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Center(
//                                   child: Text("$currentDay",
//                                     style: TextStyle(fontSize: 14,
//                                         fontFamily: poppinMedium, color: kBlack),
//                                   ),
//                                 ),
//                               ):
//                               Container(
//                                 width: 120,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color:  borderColor,
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Center(
//                                   child: Text("$valueDay",
//                                     style: TextStyle(fontSize: 14, fontFamily: poppinMedium, color: kWhite ),
//                                   ),
//                                 ),
//                               ),
//
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                                 child: timeWidget(),
//                               ),
//                             ],
//                           ),
//
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(
//                           //       horizontal: 20, vertical: 10),
//                           //   child: SizedBox(
//                           //       width: MediaQuery.of(context).size.width,
//                           //       height: MediaQuery.of(context).size.height * 0.06,
//                           //       child: const DaySlotContainer()),
//                           // ),
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(horizontal: 20),
//                           //   child: SizedBox(
//                           //       width: MediaQuery.of(context).size.width,
//                           //       height: MediaQuery.of(context).size.height * 0.17,
//                           //       child: const TimeSlotContainer()),
//                           // ),
//                           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                           GestureDetector(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: loginButton('Update', context)),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                               child: Center(
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height * 0.06,
//                                   width: MediaQuery.of(context).size.width * 0.7,
//                                   decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(
//                                         width: 1, color: borderColor),
//                                   ),
//                                   child: Center(
//                                     child: Text('Cancel',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: borderColor,
//                                             fontFamily: poppinRegular,
//                                             fontSize: 18)),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: SvgPicture.asset('assets/icon/edit_booking_icoon.svg')),
//         ],
//       ),
//     );
//   }
//
//   // String dropdownValueTime = 'Select Time';
//   Widget timeWidget(){
//     var size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.055,
//       width: MediaQuery.of(context).size.width * 01.3,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: const Color(0xFFBDC6D1))),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10, right: 10),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             hint: Text(
//               'Select Time',
//               style: GoogleFonts.poppins(
//                 textStyle: const TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF9CA3AF),
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30,),
//             items: timeHoursList.map((item) => DropdownMenuItem<String>(
//               value: item,
//               child: Text(item, style: GoogleFonts.poppins(
//                   textStyle: const TextStyle(fontSize: 14,
//                       color: Color(0xFF9CA3AF), fontWeight: FontWeight.w400))),
//             ),
//             ).toList(),
//             value: dropdownValueTime,
//             onChanged: (String? newValue) {
//               setState(() {
//                 dropdownValueTime = newValue!;
//                 print("selectedTime: $dropdownValueTime");
//               });
//             },
//             buttonWidth: MediaQuery.of(context).size.width*0.4,
//             dropdownDecoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10)),
//             dropdownMaxHeight: MediaQuery.of(context).size.height * 0.25,
//             scrollbarThickness: 0,
//             itemHeight: 30,
//           ),
//         ),
//       ),
//     );
//   }
// }
