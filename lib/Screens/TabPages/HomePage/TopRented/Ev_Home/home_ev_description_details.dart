// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
// import '../../../../../Model/HomePageModels/top_rented_cars_model.dart';
// import '../../../../../Model/custom_subscription_model.dart';
// import '../../../../../Widget/button.dart';
// import '../../../../../Utils/colors.dart';
// import '../../../../../Utils/fontFamily.dart';
// import '../../../../../Widget/toast_message.dart';
// import '../../../MyAppBarHeader/app_bar_header.dart';
// import 'package:http/http.dart'as http;
//
// import 'Ev_Home_Address/Ev_Address_Tab/ev_delivery_address.dart';
//
// class HomeEvDescriptionDetails extends StatefulWidget {
//   final DatumTopRented? evDatum;
//   final String? mySelectedTabMonth, mySelectedTabPrice;
//
//   const HomeEvDescriptionDetails({Key? key, this.evDatum,
//     this.mySelectedTabMonth, this.mySelectedTabPrice}) : super(key: key);
//
//   @override
//   State<HomeEvDescriptionDetails> createState() => _HomeEvDescriptionDetailsState();
// }
//
// // abstract class TickerProvider {}
// class _HomeEvDescriptionDetailsState extends State<HomeEvDescriptionDetails> with TickerProviderStateMixin {
//   EvCarsModel evSubscriptionCarsModelObject = EvCarsModel();
//   int selectedIndex = 0;
//   bool loadingP = true;
//   getEvSubscriptionCarsWidget() async {
//     loadingP = true;
//     setState(() {});
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     print('in LoginPage shared prefs');
//     prefs = await SharedPreferences.getInstance();
//     userId = prefs.getString('userid');
//     print("userId in Prefs is = $userId");
//     try {
//       String apiUrl = carsEvSubscriptionApiUrl;
//       print("evSubscriptionApi: $apiUrl");
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         body: {
//           "users_customers_id" : userId
//         },
//         headers: {'Accept': 'application/json'},
//       );
//       print('${response.statusCode}');
//       print(response);
//       if (response.statusCode == 200) {
//         final responseString = response.body;
//         print("evSubscriptionResponse: ${responseString.toString()}");
//         evSubscriptionCarsModelObject = evSubscriptionCarsModelFromJson(responseString);
//         print("evSubscriptionObjectLength: ${evSubscriptionCarsModelObject.data!.length}");
//         monthList();
//       }
//     } catch (e) {
//       print('Error in evSubscription: ${e.toString()}');
//     }
//     loadingP = false;
//     setState(() {});
//   }
//   String? tabMonth, tabPrice;
//
//   List<CustomSubscriptionModel> monthNumber = [];
//
//   monthList(){
//     for (int i = 0; i< evSubscriptionCarsModelObject.data!.length; i++) {
//       print("OuterLoop:$i");
//       for (int j = 0; j < evSubscriptionCarsModelObject.data![i].carsPlans!.length; j++) {
//         if(evSubscriptionCarsModelObject.data![i].carsPlans![j].carsId == carID) {
//           monthNumber.add(CustomSubscriptionModel(
//               months: evSubscriptionCarsModelObject.data![i].carsPlans![j].months!.toString(),
//               price_per_months: evSubscriptionCarsModelObject.data![i].carsPlans![j].pricePerMonth!,
//               dis_price_per_months: evSubscriptionCarsModelObject.data![i].carsPlans![j].discountedPricePerMonth!.toString()));
//           print("monthNumber123 ${monthNumber[0].months}");
//           print("InnerLoop:$j");
//         }
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getEvSubscriptionCarsWidget();
//     tabMonth = widget.mySelectedTabMonth;
//     tabPrice = widget.mySelectedTabPrice;
//     print("evCarID $carID");
//     print("tabMonthAndPrice $tabMonth $tabPrice");
//     myTotalAmount();
//   }
//   double totalAmount = 0.0;
//   myTotalAmount(){
//     print("tabMonthAndPrice22 $tabMonth $tabPrice");
//     totalAmount = double.parse("$tabPrice") + serviceFee;
//     print("selectedMonthTotal: $totalAmount");
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: homeBgColor,
//       appBar: MyAppBarSingleImageWithText(
//         title: "${widget.evDatum!.vehicalName}, ", subtitle: "${widget.evDatum!.year}",
//         backImage: "assets/messages_images/Back.png",
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   homePageDetailsCard(),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Select Start and End Date Plan", textAlign: TextAlign.left,
//                           style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinSemiBold)),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Container(
//                                 height: 30.0,
//                                 decoration: BoxDecoration(
//                                   color: borderColor,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Center(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10),
//                                     child: tabMonth == "1"?
//                                     Text("$tabMonth Month Plan", textAlign: TextAlign.left, style: TextStyle(
//                                         fontSize: 14, fontFamily: poppinRegular, color: kWhite)):
//                                     Text("$tabMonth Months Plan", textAlign: TextAlign.left, style: TextStyle(
//                                         fontSize: 14, fontFamily: poppinRegular, color: kWhite)),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: MediaQuery.of(context).size.width * 0.01),
//                               GestureDetector(
//                                   onTap: () {
//                                     showMyBottomSheet(context);
//                                   },
//                                   child: SvgPicture.asset('assets/icon/edit_booking_icoon.svg')),
//                             ],
//                           ),
//                         ),
//                         // evSubscriptionTabbarWidget(),
//                         choosedPlan(),
//                         // const EvSubscriptionTabbarPage(),
//                         SizedBox(height: screenHeight * 0.0),
//
//                         Text("*A security deposit may be applicable, depending on your eligibility assessment.",
//                           maxLines: 2, textAlign: TextAlign.left, style: TextStyle(
//                               fontSize: 12, fontFamily: poppinRegular, color: borderColor)),
//                         SizedBox(height: screenHeight * 0.02),
//                         Container(
//                           height: screenHeight * 0.1,
//                           width: screenWidth,
//                           decoration: BoxDecoration(
//                               color: kBlack,
//                               borderRadius: BorderRadius.circular(25)),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Row(
//                               children: [
//                                 Image.asset("assets/home_page/business-investment.png"),
//                                 SizedBox(width: screenWidth * 0.02),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text("Save RM 37,538", textAlign: TextAlign.left, style: TextStyle(
//                                               fontSize: 16, fontFamily: poppinSemiBold, color: kWhite)),
//                                         SizedBox(width: screenWidth * 0.03),
//                                         Container(
//                                           height: 25,
//                                           width: screenWidth * 0.24,
//                                           decoration: BoxDecoration(
//                                               color: borderColor,
//                                               borderRadius: BorderRadius.circular(20)),
//                                           child: Center(
//                                             child: Text("Learn more", textAlign: TextAlign.left, style: TextStyle(
//                                                   fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: screenHeight * 0.02),
//                                     Row(
//                                       children: [
//                                         Text("in your first year with ", textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kWhite, fontSize: 10, fontFamily: poppinRegular)),
//                                         Text("AutoHaus Rental", textAlign: TextAlign.left, style: TextStyle(
//                                                 color: borderColor, fontSize: 10, fontFamily: poppinSemiBold)),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.02),
//                         Text("What's Included", textAlign: TextAlign.left, style: TextStyle(
//                               fontSize: 14, fontFamily: poppinSemiBold,color: kBlack)),
//                         SizedBox(height: screenHeight * 0.02),
//                         myList("assets/home_page/Path 2582.png", "Periodic maintenance package (including pick up and delivery)"),
//                         myList("assets/home_page/Path 2582.png", "Wear & tear (including tyres, wipers, and brake pads replacement)"),
//                         myList("assets/home_page/Path 2582.png", "Comprehensive insurance coverage"),
//                         myList("assets/home_page/Path 2582.png", "Personal accident coverage for driver and passengers"),
//                         myList("assets/home_page/Path 2582.png", "24-hour roadside assistance (with unlimited towing and minor roadside repairs)"),
//                         myList("assets/home_page/Path 2582.png", "Road tax"),
//                         myList("assets/home_page/Path 2582.png", "Flux Concierge Service"),
//                         myList("assets/home_page/Path 2582.png", "Theft recovery services"),
//                         myList("assets/home_page/Path 2582.png", "Emergency dispatch services"),
//                         SizedBox(height: screenHeight * 0.02),
//                         GestureDetector(
//                             onTap: () {
//                               if(formKeyEvTabbar.currentState!.validate()){
//                                 if(evStartDate == null ||  evEndDate == null){
//                                   toastFailedMessage("Please select Date", kRed);
//                                 }
//                                 else if(differenceInDays! != totalDays!){
//                                   toastFailedMessage("date didn't matched", kRed);
//                                 }
//                                 else{
//                                   print('selectedMonth: $tabMonth');
//                                   print('evStartEndDate: $evStartDate $evEndDate');
//                                   print('selectedMonthPrice $tabPrice');
//                                   print('selectedMonthTotalPrice $totalAmount');
//                                   Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) => EvDeliveryAddress(
//                                           evDatum: widget.evDatum,
//                                         mySelectedTabMonth: tabMonth,
//                                         mySelectedTabPrice: tabPrice,
//                                         totalAmount: totalAmount,
//                                       )));
//                                 }
//
//                               }
//                             },
//                             child: loginButton("Next", context)),
//                         SizedBox(height: screenHeight * 0.03),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   myList(myImage, myText) {
//     return Row(
//       children: [
//         Image.asset(myImage),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 05),
//           width: MediaQuery.of(context).size.width * 0.8,
//           color: Colors.transparent,
//           child: Text(myText, textAlign: TextAlign.left,
//               maxLines: 2, style: TextStyle(fontSize: 10,
//                   fontFamily: poppinRegular, color: detailsTextColor)),
//         )
//       ],
//     );
//   }
//
//   Widget homePageDetailsCard() {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Container(
//             height: screenHeight * 0.45,
//             decoration: BoxDecoration(
//                 color: kWhite, borderRadius: BorderRadius.circular(20)),
//           ),
//         ),
//         Positioned(
//           top: 90, left: 10,
//           child: Container(
//             color: Colors.transparent,
//             width: screenWidth,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(height: screenHeight * 0.1,),
//                   Row(
//                     children: [
//                       Text("${widget.evDatum!.vehicalName} ",
//                           textAlign: TextAlign.left, style: TextStyle(
//                               color: kBlack, fontSize: 14, fontFamily: poppinBold)),
//
//                       Text("${widget.evDatum!.carsColors!.name} ", textAlign: TextAlign.left, style: TextStyle(
//                           color: kBlack, fontSize: 12, fontFamily: poppinSemiBold)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text("${widget.evDatum!.carsMakes!.name}, ",
//                           textAlign: TextAlign.left, style: TextStyle(
//                               color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                       Text("${widget.evDatum!.carsModels!.name}, ",
//                           textAlign: TextAlign.left, style: TextStyle(
//                               color: kBlack, fontSize: 12, fontFamily: poppinSemiBold)),
//                       Text("${widget.evDatum!.year} ",
//                           textAlign: TextAlign.left, style: TextStyle(
//                               color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 04),
//                         child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
//                             color: kRed, fontSize: 5, fontFamily: poppinLight)),
//                       ),
//                       Text("${widget.evDatum!.carsPlans![0].pricePerMonth}",
//                         textAlign: TextAlign.left, style: TextStyle(color: kRed,
//                             fontFamily: poppinLight, fontSize: 10, decoration: TextDecoration.lineThrough),
//                       ),
//                       SizedBox(width: screenWidth * 0.01),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 06),
//                         child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
//                             color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
//                       ),
//                       Text("${widget.evDatum!.carsPlans![0].discountedPricePerMonth}",
//                           textAlign: TextAlign.left, style: TextStyle(
//                               color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
//                       Text("/Month", textAlign: TextAlign.left, style: TextStyle(
//                           color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   Row(
//                     children: [
//                       Image.asset("assets/home_page/Promoted.png"),
//                       const SizedBox(width: 05),
//                       Text("Verified Dealer", textAlign: TextAlign.left, style: TextStyle(
//                           color: textLabelColor, fontSize: 10, fontFamily: poppinRegular)),
//                       const SizedBox(width: 05),
//                       Container(
//                         height: 15, width: 35,
//                         decoration: BoxDecoration(
//                             color: kBlack,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Center(
//                           child: Text("New", textAlign: TextAlign.left, style: TextStyle(
//                               color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   Row(
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
//                           SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                           widget.evDatum!.rating == null ?
//                           Text("0.0", textAlign: TextAlign.left, style: TextStyle(
//                               color: kBlack, fontSize: 14, fontFamily: poppinRegular)):
//                           Text("${widget.evDatum!.rating}",
//                               textAlign: TextAlign.left, style: TextStyle(
//                                   color: kBlack, fontSize: 14, fontFamily: poppinRegular)),
//                         ],
//                       ),
//                       SizedBox(width: screenWidth * 0.45),
//                       Container(
//                         height: 25, width: 70,
//                         decoration: BoxDecoration(color: kBlack,
//                             borderRadius: BorderRadius.circular(20)),
//                         child: Center(
//                           child: Text("Pre book", textAlign: TextAlign.left,
//                               style: TextStyle(color: kWhite, fontSize: 12, fontFamily: poppinMedium)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.01),
//                   Text("PRE-BOOK LISTING ", textAlign: TextAlign.left, style: TextStyle(
//                       color: kBlack, fontSize: 14, fontFamily: poppinSemiBold)),
//                   SizedBox(height: screenHeight * 0.01),
//                   Text("This vehicle may take more than 7 days to deliver, based on vehicle’s availability",
//                       textAlign: TextAlign.left, style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           left: 25, right: 20,
//           top: 20,
//           child: widget.evDatum!.image1 == null ?
//           ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.asset('assets/icon/fade_in_image.jpeg')) :
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: FadeInImage(
//               placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
//               width: 350,
//               height: 130,
//               image: NetworkImage("$baseUrlImage${widget.evDatum!.image1}"),
//             ),
//           ),
//         ),
//         Positioned(
//             top: 28, left: 25,
//             child: Container(
//               height: screenHeight * 0.035,
//               width: screenWidth * 0.18,
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(15),
//                     bottomLeft: Radius.circular(15)),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("${widget.evDatum!.discountPercentage}% ",
//                       textAlign: TextAlign.left, style: TextStyle(
//                           color: kWhite, fontSize: 13, fontFamily: poppinSemiBold)),
//                   Text("OFF", textAlign: TextAlign.left, style: TextStyle(
//                       color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
//                 ],
//               ),
//             )),
//         Positioned(
//             top: 28, right: 27,
//             child: Image.asset("assets/home_page/heart_transparent.png", color: kBlack,)),
//       ],
//     );
//   }
//
//   DateTime? startPicked, endPicked;
//   selectStartDateWidget(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       // firstDate: DateTime(2000),
//       firstDate: DateTime.now().subtract(const Duration(days: 0)),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != pickDate) {
//       evStartDate = DateFormat('yyyy-MM-dd').format(picked);
//       startPicked = picked;
//
//       setState(() {
//         print("selectedStartDate is $evStartDate");
//         print("evMonth $evSelectedMonth");
//         print("tabNewValueStart $tabNewValue");
//       });
//     }
//   }
//
//   selectEndDateWidget(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       // firstDate: DateTime(2000),
//       firstDate: DateTime.now().subtract(const Duration(days: 0)),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != pickDate) {
//       evEndDate = DateFormat('yyyy-MM-dd').format(picked);
//       startPicked = picked;
//       setState(() {
//         print("SelectedEndDate is $evEndDate");
//         print("evMonth $evSelectedMonth");
//         print("tabNewValueEnd $tabNewValue");
//         calculateDateInterval();
//       });
//     }
//   }
//
//   int? differenceInDays, totalDays;
//   calculateDateInterval(){
//     var format = DateFormat("yyyy-MM-dd");
//     print(evStartDate);
//     print(evEndDate);
//     var start = format.parse(evStartDate!);
//     var end = format.parse(evEndDate!);
//
//     print("startDate $start");
//     print("endDate $end");
//
//     Duration difference = end.difference(start).abs();
//     differenceInDays = difference.inDays;
//     print("dateDifferenceInDays $differenceInDays");
//     print("totalMonth $tabMonth");
//     totalDays = int.parse(tabMonth.toString()) * 30;
//     print("totalDays $totalDays");
//     if(differenceInDays! == totalDays!){
//       toastSuccessMessage("date matched", colorGreen);
//     } else{
//       toastFailedMessage("date didn't matched", kRed);
//     }
//   }
//
//   final GlobalKey<FormState> formKeyEvTabbar = GlobalKey<FormState>();
//   evSubscriptionTabbarWidget(){
//     TabController tabController = TabController(length: monthNumber.length, vsync: this);
//     return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
//     Form(
//       key: formKeyEvTabbar,
//       child: Column(
//         children: [
//           Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.065,
//               decoration: BoxDecoration(
//                   color: homeBgColor,
//                   borderRadius: BorderRadius.circular(10)),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10, horizontal:0),
//                 child: TabBar(
//                   controller: tabController,
//                   indicator: BoxDecoration(
//                     color: borderColor,
//                     borderRadius: BorderRadius.circular(10.0)),
//                   // onTap: (index){
//                   //   selectedIndex = index;
//                   //   // print('selectedIndex: $selectedIndex');
//                   //   print('selectedTabMonth123: $evSelectedMonth');
//                   //
//                   // },
//                   tabs: List<Widget>.generate(
//                     monthNumber.length, (int index) {
//                     print("monthsTabBarLength ${monthNumber.length}");
//                     // print("monthsTabBarLength123 $tabNewValue");
//                     //  monthNumber[selectedIndex].months = tabNewValue.toString();
//                     // print('selectedTabMonthIndex: ${monthNumber[selectedIndex].months}');
//                     return Container(
//                       color: Colors.transparent,
//                       height: 40,
//                       width: 80,
//                       child: Tab(
//                         child:
//                         monthNumber[index].months == "1" ? Text("${monthNumber[index].months} Month", style: TextStyle(
//                             color: kBlack, fontSize: 14, fontFamily: poppinMedium)):
//                         Text("${monthNumber[index].months} Months", style: TextStyle(color: kBlack, fontSize: 14)),
//                       ),
//                     );
//                   },
//                   ),
//
//                   indicatorColor: kWhite,
//                   isScrollable: true,
//                   labelColor: kWhite,
//                   labelStyle: TextStyle(fontSize: 12, color: kWhite, fontFamily: poppinRegular),
//                   unselectedLabelColor: kBlack,
//                 ),
//               )),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     selectStartDateWidget(context);
//                   },
//                   child: evStartDate == null?
//                   Container(
//                     height: 40,
//                     width: 120,
//                     decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Center(
//                       child: Text("Start Date", style: TextStyle(color: kBlack , fontSize: 16),
//                       ),
//                     ),
//                   ): Container(
//                     height: 40,
//                     width: 120,
//                     decoration: BoxDecoration(
//                         color:  borderColor,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Center(
//                       child: Text(evStartDate!, style: TextStyle(color: kWhite, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 InkWell(
//                     onTap: () {
//                       selectEndDateWidget(context);
//                     },
//                     child: evEndDate == null?
//                     Container(
//                       height: 40,
//                       width: 120,
//                       decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text("End Date",
//                             style: TextStyle(color: kBlack, fontSize: 16)),
//                       ),
//                     ):
//                     Container(
//                       height: 40,
//                       width: 120,
//                       decoration: BoxDecoration(
//                         color: borderColor,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text(evEndDate!,
//                           style: TextStyle(
//                               color: kWhite, fontSize: 16),
//                         ),
//                       ),
//                     )
//                 ),
//               ]
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height *0.01),
//
//           // SizedBox(
//           //   width: double.maxFinite,
//           //   height: MediaQuery.of(context).size.height * 0.15,
//           //   child: TabBarView(
//           //     controller: tabController,
//           //     children: monthNumber.isEmpty ? <Widget>[] :
//           //     monthNumber.map((bodyData) {
//           //       print('bodyDataMonths ${bodyData.months}');
//           //       return TwelveMonthsPlan(
//           //           months: bodyData.months,
//           //           pricePerMonths: bodyData.price_per_months,
//           //           discountPricePerMonths: bodyData.dis_price_per_months);
//           //     }).toList(),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget choosedPlan(){
//     return Form(
//       key: formKeyEvTabbar,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 10),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     selectStartDateWidget(context);
//                   },
//                   child: evStartDate == null?
//                   Container(
//                     height: 40,
//                     width: 120,
//                     decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Center(
//                       child: Text("Start Date", style: TextStyle(color: kBlack , fontSize: 16),
//                       ),
//                     ),
//                   ): Container(
//                     height: 40,
//                     width: 120,
//                     decoration: BoxDecoration(
//                         color:  borderColor,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Center(
//                       child: Text(evStartDate!, style: TextStyle(color: kWhite, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 InkWell(
//                     onTap: () {
//                       selectEndDateWidget(context);
//                     },
//                     child: evEndDate == null?
//                     Container(
//                       height: 40,
//                       width: 120,
//                       decoration: BoxDecoration(
//                         color: kWhite,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text("End Date",
//                             style: TextStyle(color: kBlack, fontSize: 16)),
//                       ),
//                     ):
//                     Container(
//                       height: 40,
//                       width: 120,
//                       decoration: BoxDecoration(
//                         color: borderColor,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text(evEndDate!,
//                           style: TextStyle(
//                               color: kWhite, fontSize: 16),
//                         ),
//                       ),
//                     )
//                 ),
//               ]
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height *0.01),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               tabMonth == "1"?
//               Text("$tabMonth Month Plan", textAlign: TextAlign.left, style: TextStyle(
//                   fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)):
//               Text("$tabMonth Months Plan", textAlign: TextAlign.left, style: TextStyle(
//                   fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//               Text("RM $tabPrice",
//                   textAlign: TextAlign.right, style: TextStyle(
//                       fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Service Fee (6%)", textAlign: TextAlign.left, style: TextStyle(
//                   fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//               Text("RM $serviceFee", textAlign: TextAlign.right, style: TextStyle(
//                   fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Total Amount", textAlign: TextAlign.left, style: TextStyle(
//                   fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
//               Text("RM $totalAmount", textAlign: TextAlign.left, style: TextStyle(
//                   fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   showMyBottomSheet(context) {
//     TabController tabController = TabController(length: monthNumber.length, vsync: this);
//     return showMaterialModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(
//               builder: (BuildContext context, StateSetter stateSetterObject) {
//                 return Container(
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: homeBgColor,
//                     borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(20),
//                         topLeft: Radius.circular(20)),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.03),
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 16),
//                           child: Text('Change Available Month Slot',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: poppinBold,
//                                   color: appBgColor)),
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height * 0.1,
//                             decoration: BoxDecoration(
//                                 color: homeBgColor,
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
//                               child: TabBar(
//                                 controller: tabController,
//                                 indicator: BoxDecoration(
//                                   // color: selectedIndex == ? borderColor: kWhite,
//                                   color: borderColor,
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                                 onTap: (index){
//                                   selectedIndex = index;
//                                   tabMonth = monthNumber[selectedIndex].months;
//                                   tabPrice = monthNumber[selectedIndex].dis_price_per_months;
//                                   stateSetterObject(() {
//                                     print('selectedIndex: $selectedIndex');
//                                     print('selectedTabMonth123: $tabMonth');
//                                     print('selectedTabMonthPrice: $tabPrice');
//                                   });
//
//                                 },
//                                 tabs: List<Widget>.generate(
//                                     monthNumber.length, (int index) {
//                                   print("monthsTabBarLength ${monthNumber.length}");
//                                   print("monthsTabBarClicked ");
//                                   return Container(
//                                     color: Colors.transparent,
//                                     height: MediaQuery.of(context).size.height * 0.12,
//                                     child: Tab(
//                                       child: SizedBox(
//                                         width: MediaQuery.of(context).size.width * 0.3,
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             monthNumber[index].months == "1" ? Text("${monthNumber[index].months} month", style: TextStyle(
//                                               color: kBlack, fontSize: 17, fontFamily: poppinMedium,)):
//                                             Text("${monthNumber[index].months} months", style: TextStyle(
//                                                 color: kBlack, fontSize: 17, fontFamily: poppinMedium)),
//
//                                             Text("RM ${monthNumber[index].dis_price_per_months}",
//                                                 textAlign: TextAlign.right, style: TextStyle(
//                                                   fontSize: 14, fontFamily: poppinRegular, color: kBlack,)),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                                 indicatorColor: kWhite,
//                                 isScrollable: true,
//                                 labelColor: kWhite,
//                                 labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
//                                 unselectedLabelColor: kBlack,
//                               ),
//                             )),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                       GestureDetector(
//                           onTap: () {
//                             myTotalAmount();
//                             Navigator.pop(context
//                             );
//                           },
//                           child: loginButton('Update', context)),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                           child: Center(
//                             child: Container(
//                               height: MediaQuery.of(context).size.height * 0.06,
//                               width: MediaQuery.of(context).size.width * 0.7,
//                               decoration: BoxDecoration(
//                                 color: Colors.transparent,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(width: 1, color: borderColor),
//                               ),
//                               child: Center(
//                                 child: Text('Cancel', textAlign: TextAlign.center,
//                                     style: TextStyle(color: borderColor,
//                                         fontFamily: poppinRegular, fontSize: 18)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               });
//         });
//   }
// }
