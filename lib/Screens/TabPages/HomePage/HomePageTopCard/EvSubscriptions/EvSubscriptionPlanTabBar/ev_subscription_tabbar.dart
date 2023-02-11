// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:auto_haus_rental_app/Widget/toast_message.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../../../Model/HomePageModels/HomeTopWidgetModels/ev_cars_model.dart';
// import '../../../../../../Model/custom_subscription_model.dart';
// import '12MonthsPlan/12_months_plan.dart';
// import 'package:http/http.dart'as http;
//
// class EvSubscriptionTabbarPage extends StatefulWidget {
//   const EvSubscriptionTabbarPage({super.key});
//
//   @override
//   State<EvSubscriptionTabbarPage> createState() => _EvSubscriptionTabbarPageState();
// }
//
// abstract class TickerProvider {}
//
// class _EvSubscriptionTabbarPageState extends State<EvSubscriptionTabbarPage> with TickerProviderStateMixin {
//   EvCarsModel evSubscriptionCarsModelObject = EvCarsModel();
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
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getEvSubscriptionCarsWidget();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TabController tabController = TabController(length: monthNumber.length, vsync: this);
//     return loadingP ? Center(child: CircularProgressIndicator(color: borderColor)):
//       Column(
//       children: [
//         Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.055,
//             decoration: BoxDecoration(
//                 color: homeBgColor,
//                 borderRadius: BorderRadius.circular(30)),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 00),
//               child: TabBar(
//                 controller: tabController,
//                 indicator: BoxDecoration(
//                   color: borderColor,
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 tabs: List<Widget>.generate(
//                   monthNumber.length, (int index) {
//                     print("monthsTabBarLength ${monthNumber.length}");
//                     return Container(
//                       color: Colors.transparent,
//                       child: Tab(
//                         child: monthNumber[index].months == "1" ? Text("${monthNumber[index].months} Month", style: TextStyle(
//                           color: kBlack, fontSize: 14, fontFamily: poppinMedium)):
//                         Text("${monthNumber[index].months} Months", style: TextStyle(color: kBlack, fontSize: 14)),
//                       ),
//                     );
//                   },
//                 ),
//                 onTap: (index){
//                   print('selectedTabMonth: $evSelectedMonth');
//                 },
//                 indicatorColor: kWhite,
//                 isScrollable: true,
//                 labelColor: kWhite,
//                 labelStyle: TextStyle(fontSize: 12, fontFamily: poppinRegular),
//                 unselectedLabelColor: kBlack,
//               ),
//             )),
//
//         // Row(
//         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //   children: [
//         //     InkWell(
//         //         onTap: () {
//         //           selectStartDateWidget(context);
//         //         },
//         //         child:
//         //         evStartDate == null?
//         //         Container(
//         //           height: 30,
//         //           width: 100,
//         //           decoration: BoxDecoration(
//         //               color:  kWhite,
//         //               borderRadius: BorderRadius.circular(10)
//         //           ),
//         //           child: Center(
//         //             child: Text("Start Date",
//         //               style: TextStyle(color:  kBlack, fontSize: 16 ),
//         //             ),
//         //           ),
//         //         ):
//         //         Container(
//         //           height: 30,
//         //           width: 100,
//         //           decoration: BoxDecoration(
//         //               color:  borderColor,
//         //               borderRadius: BorderRadius.circular(10)
//         //           ),
//         //           child: Center(
//         //             child: Text(
//         //               evStartDate.toString(),
//         //               style: TextStyle(color:  kWhite, fontSize: 16 ),
//         //             ),
//         //           ),
//         //         ),
//         //     ),
//         //     InkWell(
//         //         onTap: () {
//         //           selectEndDateWidget(context);
//         //         },
//         //         child: Container(
//         //           height: 30,
//         //           width: 100,
//         //           decoration: BoxDecoration(
//         //               color: evEndDate == "End Date" ? kWhite : borderColor,
//         //               borderRadius: BorderRadius.circular(10)
//         //           ),
//         //           child: Center(
//         //             child: Text(
//         //               evEndDate.toString(),
//         //               style: TextStyle(color: evEndDate == "End Date" ? kBlack : kWhite, fontSize: 16 ),
//         //             ),
//         //           ),
//         //         )),
//         //   ],
//         // ),
//
//         Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                 onTap: () {
//                   selectStartDateWidget(context);
//                 },
//                 child: evStartDate == null?
//                 Container(
//                   height: 40,
//                   width: 120,
//                   decoration: BoxDecoration(
//                       color: kWhite,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Center(
//                     child: Text("Start Date", style: TextStyle(color: kBlack , fontSize: 16),
//                     ),
//                   ),
//                 ): Container(
//                   height: 40,
//                   width: 120,
//                   decoration: BoxDecoration(
//                       color:  borderColor,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Center(
//                     child: Text(evStartDate!, style: TextStyle(color: kWhite, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//
//               InkWell(
//                   onTap: () {
//                     selectEndDateWidget(context);
//                   },
//                   child: evEndDate == null?
//                   Container(
//                     height: 40,
//                     width: 120,
//                     decoration: BoxDecoration(
//                       color: kWhite,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text("End Date",
//                           style: TextStyle(color: kBlack, fontSize: 16)),
//                     ),
//                   ):
//                   Container(
//                     height: 40,
//                     width: 120,
//                     decoration: BoxDecoration(
//                       color: borderColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text(evEndDate!,
//                         style: TextStyle(
//                             color: kWhite, fontSize: 16),
//                       ),
//                     ),
//                   )
//               ),
//             ]
//         ),
//
//         SizedBox(
//           width: double.maxFinite,
//           height: MediaQuery.of(context).size.height * 0.14,
//           child: TabBarView(
//             controller: tabController,
//             children: monthNumber.isEmpty ? <Widget>[] :
//             monthNumber.map((bodyData) {
//               print('bodyDataMonths ${bodyData.months}');
//               return TwelveMonthsPlan(
//                 months: bodyData.months,
//                 pricePerMonths: bodyData.price_per_months,
//                 discountPricePerMonths: bodyData.dis_price_per_months);
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   DateTime? startPicked, endPicked;
//   selectStartDateWidget(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != pickDate) {
//       evStartDate = DateFormat('yyyy-MM-dd').format(picked);
//       startPicked = picked;
//
//       setState(() {
//         print("selectedStartDate is $evStartDate");
//         print("startPickedDate is $picked");
//         print("startPickedDate is $startPicked");
//       });
//     }
//   }
//
//   selectEndDateWidget(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null && picked != pickDate) {
//       evEndDate = DateFormat('yyyy-MM-dd').format(picked);
//       startPicked = picked;
//       setState(() {
//         print("SelectedEndDate is $evEndDate");
//         print("endPickedDate is $picked");
//         print("endPickedDate is $endPicked");
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
//     print("dateDifferenceInDays $evSelectedMonth");
//     totalDays = int.parse(evSelectedMonth.toString()) * 30;
//     print("totalDays $totalDays");
//     if(differenceInDays! <= totalDays!){
//       toastSuccessMessage("success", colorGreen);
//     } else{
//       toastFailedMessage("failed", kRed);
//     }
//   }
//
// }
