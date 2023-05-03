// import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import '../Utils/colors.dart';
// import '../Utils/fontFamily.dart';
// import 'TextFields/address_text_field.dart';
// import 'TextFields/text_form_field.dart';
// import 'button.dart';
// import 'myTextWidget.dart';
//
// // Initial Selected Value
// String dropdownValue = 'Select state';
//
// // List of items in our dropdown menu
// var items = [
//   'Select state',
//   'Select state 1',
//   'Select state 2',
//   'Select state 3',
//   'Select state 4',
//   'Select state 5',
// ];
//
// Future bottomSheetWidget(BuildContext context){
//   return showMaterialModalBottomSheet(
//     backgroundColor: Colors.transparent,
//     context: context,
//     builder: (context) => SingleChildScrollView(
//       controller: ModalScrollController.of(context),
//       child: StatefulBuilder(
//       builder: (BuildContext context, StateSetter stateSetterObject) {
//         return Container(
//           decoration: BoxDecoration(
//               color: homeBgColor,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               )),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height * 0.05,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         color: kBlack,
//                         borderRadius: BorderRadius.circular(30)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                             "assets/payment_card_images/apple_image.png",
//                             color: kWhite),
//                         SizedBox(width: 10),
//                         Text("Pay", textAlign: TextAlign.center,
//                             style: TextStyle(color: kWhite,
//                                 fontFamily: poppinRegular, fontSize: 18)),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text("Or pay with card",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: detailsTextColor,
//                         fontFamily: poppinSemiBold, fontSize: 16)),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     textWidgetBlack("Email"),
//                     SizedBox(height: MediaQuery
//                         .of(context)
//                         .size
//                         .height * 0.005),
//                     EditTextUtils().getCustomEditTextArea(
//                       hintValue: "rose.matthews@mail.com",
//                       validation: true,
//                       // autoFocus: true,
//                       // textController: firstNameController,
//                       keyboardType: TextInputType.text,
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     textWidgetBlack("Card Information"),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.06,
//                       decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: TextField(
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           contentPadding: EdgeInsets.all(20),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                               borderSide: BorderSide(color: borderColor)),
//                           hintText: 'xxxx xxxx xxxx xxxx',
//                           hintStyle: TextStyle(color: textLabelColor),
//                           focusColor: borderColor,
//                           fillColor: kWhite,
//                           prefixIcon: Image.asset(
//                               "assets/payment_card_images/card_prefix.png"),
//                           suffixIcon: Image.asset(
//                             "assets/payment_card_images/visa_icon.png",),
//                         ),
//                         style: TextStyle(
//                             color: borderColor, fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           textWidgetBlack("Expire date"),
//                           SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                           Container(
//                             height: MediaQuery.of(context).size.height * 0.06,
//                             decoration: BoxDecoration(
//                                 color: kWhite,
//                                 borderRadius: BorderRadius.circular(30.0)),
//                             child: TextField(
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.all(20),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                     borderSide: BorderSide(color: borderColor)),
//                                 hintText: 'MM/YY',
//                                 hintStyle: TextStyle(color: textLabelColor),
//                                 focusColor: borderColor,
//                                 prefixIcon: Image.asset(
//                                   "assets/payment_card_images/calendar.png",),
//                               ),
//                               style: TextStyle(
//                                   color: borderColor, fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           textWidgetBlack("CVC"),
//                           SizedBox(height: MediaQuery
//                               .of(context)
//                               .size
//                               .height * 0.005),
//                           Container(
//                             height: MediaQuery
//                                 .of(context)
//                                 .size
//                                 .height * 0.06,
//                             decoration: BoxDecoration(
//                               color: kWhite,
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             child: TextField(
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 contentPadding: EdgeInsets.all(20),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                     borderSide: BorderSide(color: borderColor)),
//                                 hintText: 'CVC',
//                                 hintStyle: TextStyle(color: textLabelColor),
//                                 focusColor: borderColor,
//                                 prefixIcon: Image.asset(
//                                     "assets/payment_card_images/cvc.png"),
//                               ),
//                               style: TextStyle(
//                                   color: borderColor, fontSize: 14),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height * 0.02),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     textWidgetBlack("Country or Region"),
//                     SizedBox(height: MediaQuery
//                         .of(context)
//                         .size
//                         .height * 0.005),
//                     Container(
//                       height: MediaQuery
//                           .of(context)
//                           .size
//                           .height * 0.06,
//                       width: MediaQuery
//                           .of(context)
//                           .size
//                           .width,
//                       decoration: BoxDecoration(
//                           color: kWhite,
//                           borderRadius: BorderRadius.circular(30)),
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton(
//                           // Initial Value
//                           value: dropdownValue,
//                           icon: Icon(Icons.keyboard_arrow_down),
//                           // Array list of items
//                           items: items.map((String items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: Text(items),
//                             );
//                           }).toList(),
//                           // After selecting the desired option,it will
//                           // change button value to selected value
//                           onChanged: (String? newValue) {
//                             stateSetterObject(() {
//                               dropdownValue = newValue!;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height * 0.02),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     textWidgetBlack("Zip"),
//                     SizedBox(height: MediaQuery
//                         .of(context)
//                         .size
//                         .height * 0.005),
//                     Container(
//                       height: MediaQuery
//                           .of(context)
//                           .size
//                           .height * 0.06,
//                       decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                       child: AddressTextUtils().getCustomEditTextArea(
//                         hintValue: "Select state",
//                         validation: true,
//                         // autoFocus: true,
//                         // textController: resetEmailController,
//                         keyboardType: TextInputType.text,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height * 0.03),
//                 GestureDetector(
//                   onTap: () {
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return Container(
//                             color: Color(0xffb0b0b0),
//                             child: Container(
//                               color: Color(0xffb0b0b0),
//                               child: Container(
//                                 color: Color(0xff0f172a).withOpacity(0.5),
//                                 child: Dialog(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         color: homeBgColor,
//                                         borderRadius: BorderRadius.circular(
//                                             20)),
//                                     child: Padding(
//                                       padding: EdgeInsets.all(12.0),
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment
//                                             .center,
//                                         crossAxisAlignment: CrossAxisAlignment
//                                             .center,
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment
//                                                 .end,
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .end,
//                                             children: [
//                                               GestureDetector(
//                                                 onTap: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child:
//                                                 Image.asset(
//                                                     "assets/payment_card_images/cancle.png"),
//                                               ),
//                                             ],
//                                           ),
//                                           Image.asset(
//                                               "assets/payment_card_images/alert_dialog_image.png"),
//                                           SizedBox(height: MediaQuery
//                                               .of(context)
//                                               .size
//                                               .height * 0.01),
//                                           Text("Congratulation!",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: borderColor,
//                                                   fontSize: 24,
//                                                   fontFamily: poppinSemiBold)),
//                                           SizedBox(height: MediaQuery
//                                               .of(context)
//                                               .size
//                                               .height * 0.01),
//                                           Text("Your Ride is Booked.",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: textLabelColor,
//                                                   fontSize: 20,
//                                                   fontFamily: poppinMedium)),
//                                           SizedBox(height: MediaQuery
//                                               .of(context)
//                                               .size
//                                               .height * 0.02),
//                                           GestureDetector(
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: loginButton(
//                                                   "Okay", context)),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                   },
//                   child: loginButton("Pay", context),
//                 ),
//                 SizedBox(height: MediaQuery
//                     .of(context)
//                     .size
//                     .height * 0.03),
//               ],
//             ),
//           ),
//         );
//       }),
//     ),
//   );
// }