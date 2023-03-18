// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Widget/TextFields/address_text_field.dart';
// import 'package:auto_haus_rental_app/Widget/myTextWidget.dart';
// import 'package:country_picker/country_picker.dart';
// import 'package:flutter/material.dart';
// import '../../../../../../../Model/HomePageModels/HomeTopWidgetModels/driving_cars_model.dart';
// import 'billing_address_page_experience.dart';
//
// class AddressTabBarExperience extends StatefulWidget {
//   final String? startTime, endTime, selectedDate;
//   final double? totalPrice, selectedSlotPrice;
//   final DatumDrivingTopCard? myDatum;
//
//   const AddressTabBarExperience({Key? key, this.selectedDate,
//     this.totalPrice, this.selectedSlotPrice,
//     this.myDatum, this.startTime, this.endTime}): super(key: key);
//
//   @override
//   State<AddressTabBarExperience> createState() => _AddressTabBarExperienceState();
// }
//
// abstract class TickerProvider {}
//
// class _AddressTabBarExperienceState extends State<AddressTabBarExperience> with SingleTickerProviderStateMixin {
//
//   mySelectedData(){
//     print("carDayDate: ${widget.selectedDate}");
//     print("carTotalPrice: ${widget.totalPrice}");
//     print("carStartEndTime: ${widget.startTime} ${widget.endTime}");
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     tabController = TabController(length: 2, vsync: this);
//     mySelectedData();
//   }
//
//   TabController? tabController;
//   List<String> tabs = ["Home Address", "Billing Address",];
//   int selectedIndex = 0;
//
//   final GlobalKey<FormState> homeAddressFormKey = GlobalKey<FormState>();
//   var address1ControllerHome = TextEditingController();
//   var address2ControllerHome = TextEditingController();
//   var cityControllerHome = TextEditingController();
//   var postCodeControllerHome = TextEditingController();
//
//   String _country = 'United Kingdom';
//
//   // Initial Selected Value
//   String dropdownValue = 'Select state';
//
//   // List of items in our dropdown menu
//   var items = [
//     'Select state',
//     'Select state 1',
//     'Select state 2',
//     'Select state 3',
//     'Select state 4',
//     'Select state 5',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
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
//               /// HomeAddress
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//
//                     buildTextFields(),
//
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         textWidgetBlack("State"),
//                         SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                         Container(
//                           height: MediaQuery.of(context).size.height *0.06,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: kWhite,
//                               borderRadius: BorderRadius.circular(30)
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: DropdownButtonHideUnderline(
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: DropdownButton(
//                                 // Initial Value
//                                 value: dropdownValue,
//                                 // hint: Text("Select state", style: TextStyle(color: textLabelColor, fontFamily: poppinRegular,
//                                 // ),
//                                 // ),
//
//                                 // Down Arrow Icon
//                                 icon: const Icon(Icons.keyboard_arrow_down),
//
//                                 // Array list of items
//                                 items: items.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                                 // After selecting the desired option,it will
//                                 // change button value to selected value
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     dropdownValue = newValue!;
//                                     print("selectedState $dropdownValue");
//
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         textWidgetBlack("Country"),
//                         SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                         GestureDetector(
//                           onTap: () {
//                             showCountryPicker(
//                               context: context,
//                               exclude: <String>['KN', 'MF'],
//                               //Optional. Shows phone code before the country name.
//                               showPhoneCode: true,
//                               showWorldWide: false,
//                               onSelect: (Country country) {
//                                 print('Select country: ${country.displayName}');
//
//                                 setState(() {
//                                   _country = country.name;
//                                   print("selectedCountry $_country");
//                                 });
//                               },
//                               // Optional. Sets the theme for the country list picker.
//                               countryListTheme: CountryListThemeData(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(40.0),
//                                   topRight: Radius.circular(40.0),
//                                 ),
//                                 // Optional. Styles the search field.
//                                 inputDecoration: InputDecoration(
//                                   labelText: 'Search',
//                                   hintText: 'Start typing to search',
//                                   prefixIcon: const Icon(Icons.search),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: const Color(0xFF8C98A8).withOpacity(0.2),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                               padding: const EdgeInsets.only(left: 10),
//                               height: MediaQuery.of(context).size.height * 0.06,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                   color: kWhite,
//                                   borderRadius: BorderRadius.circular(30)
//                               ),
//                               margin: const EdgeInsets.only(left: 0, right: 0),
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         _country.toString(),
//                                         style: const TextStyle(fontSize: 16),
//                                       ),
//                                       Container(
//                                         //padding: EdgeInsets.only(right: 6),
//                                         alignment: Alignment.center,
//                                         height: MediaQuery.of(context).size.height,
//                                         width: MediaQuery.of(context).size.width * 0.07,
//                                         decoration: const BoxDecoration(
//                                           // color: Colors.black12,
//                                             borderRadius: BorderRadius.only(
//                                                 topRight: Radius.circular(4),
//                                                 bottomRight: Radius.circular(4))),
//                                         child: const Icon(Icons.keyboard_arrow_down_outlined),
//                                       ),
//                                     ]),
//                               )),
//                         ),
//
//                       ],
//                     ),
//
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//                     GestureDetector(
//                       onTap: (){
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => BillingAddress()));
//                       },
//
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.06,
//                         width: MediaQuery.of(context).size.width * 0.7,
//                         decoration: BoxDecoration(
//                           // color: borderColor,
//                             color: const Color(0xffD4DCE1),
//                             borderRadius: BorderRadius.circular(30)),
//                         child: const Center(
//                           child: Text("Save", style: TextStyle(
//                               color: Colors.white, fontFamily: 'Poppins',
//                               fontWeight: FontWeight.w400, fontSize: 18)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               BillingAddressPageExperience(
//                 selectedSlotPrice: widget.selectedSlotPrice,
//                 myDatum: widget.myDatum,
//                 startTime: widget.startTime,
//                 endTime: widget.endTime,
//                 selectedDate: widget.selectedDate,
//                 totalPrice: widget.totalPrice,
//
//                 homeStreetAddress1: address1ControllerHome.text,
//                 homeStreetAddress2: address2ControllerHome.text,
//                 homeCity: cityControllerHome.text,
//                 homePostCode: postCodeControllerHome.text,
//                 homeSelectedState: dropdownValue,
//                 homeSelectedCountry: _country,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildTextFields() {
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 0),
//         child: Container(
//           color: Colors.transparent,
//           child: Column(
//             children: [
//               Form(
//                 key: homeAddressFormKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         textWidgetBlack("Street address Line 1"),
//                         SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.06,
//                           decoration: BoxDecoration(
//                             color: kWhite,
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           child: AddressTextUtils().getCustomEditTextArea(
//                             hintValue: "Street address line 1",
//                             validation: true,
//                             // autoFocus: true,
//                             textController: address1ControllerHome,
//                             keyboardType: TextInputType.text,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         textWidgetBlack("Street address Line 2"),
//                         SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.06,
//                           decoration: BoxDecoration(
//                             color: kWhite,
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           child: AddressTextUtils().getCustomEditTextArea(
//                             hintValue: "Street address line 2",
//                             validation: true,
//                             // autoFocus: true,
//                             textController: address2ControllerHome,
//                             keyboardType: TextInputType.text,
//                           ),
//                         ),
//
//                       ],
//                     ),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               textWidgetBlack("City"),
//                               SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                               Container(
//                                 height: MediaQuery.of(context).size.height * 0.06,
//                                 decoration: BoxDecoration(
//                                   color: kWhite,
//                                   borderRadius: BorderRadius.circular(30.0),
//                                 ),
//                                 child: AddressTextUtils().getCustomEditTextArea(
//                                   hintValue: "City",
//                                   validation: true,
//                                   // autoFocus: true,
//                                   textController: cityControllerHome,
//                                   keyboardType: TextInputType.text,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               textWidgetBlack("Post Code"),
//
//                               SizedBox(height: MediaQuery.of(context).size.height * 0.005),
//                               Container(
//                                 height: MediaQuery.of(context).size.height * 0.06,
//                                 decoration: BoxDecoration(
//                                   color: kWhite,
//                                   borderRadius: BorderRadius.circular(30.0),
//                                 ),
//                                 child: AddressTextUtils().getCustomEditTextArea(
//                                   hintValue: "Post Code",
//                                   validation: true,
//                                   textController: postCodeControllerHome,
//                                   keyboardType: TextInputType.text,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
