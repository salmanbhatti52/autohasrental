// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sizer/sizer.dart';
//
// class MyDropDownDateButton extends StatefulWidget {
//   const MyDropDownDateButton({
//     Key? key,
//     required this.width,
//     required this.selection,
//   }) : super(key: key);
//
//   final double width;
//   final String selection;
//
//   @override
//   State<MyDropDownDateButton> createState() => _MyDropDownDateButtonState();
// }
//
// class _MyDropDownDateButtonState extends State<MyDropDownDateButton> {
//   String dropdownValue = 'Select Time';
//   var items = [
//     'Select Time',
//     '01am - 02am',
//     '02am - 03am',
//     '03am - 04am',
//     '04am - 05am',
//     '05am - 06am',
//     '06am - 07am',
//     '07am - 08am',
//     '08am - 09am',
//     '09am - 10am',
//     '10am - 11am',
//     '11am - 12ppm',
//     '12pm - 01pm',
//     '01pm - 02pm',
//     '02pm - 03pm',
//     '03pm - 04pm',
//     '04pm - 05pm',
//     '05pm - 06pm',
//     '06pm - 07pm',
//     '07pm - 08pm',
//     '08pm - 09pm',
//     '09pm - 10pm',
//     '10pm - 11pm',
//     '11pm - 12am',
//     '12pm - 01am',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height * 0.055,
//       width: widget.width * 01.3,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: const Color(0xFFBDC6D1))),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10, right: 10),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             hint: Text(
//               'Select Time',
//               style: GoogleFonts.inter(
//                 textStyle: const TextStyle(
//                   fontSize: 12,
//                   color: Color(0xFF9CA3AF),
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 30,),
//             items: items.map(
//                   (item) => DropdownMenuItem<String>(
//                     value: item,
//                     child: Text(item, style: GoogleFonts.inter(
//                         textStyle: const TextStyle(fontSize: 14,
//                           color: Color(0xFF9CA3AF), fontWeight: FontWeight.w400))),
//                   ),
//                 )
//                 .toList(),
//             value: dropdownValue,
//             onChanged: (String? newValue) {
//               setState(() {
//                 dropdownValue = newValue!;
//                 print("selectedTime: $dropdownValue");
//               });
//             },
//             buttonWidth: 30.h,
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             dropdownMaxHeight: 30.h,
//             scrollbarThickness: 0,
//             itemHeight: 30,
//           ),
//         ),
//       ),
//     );
//   }
// }
