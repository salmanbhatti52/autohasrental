//
// import 'package:auto_haus_rental_app/Model/HomePageModels/HomePageTopWidgetModels/ev_cars_model.dart';
// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart'as http;
//
// class ThirtySixMonthsPlan extends StatefulWidget {
//   const ThirtySixMonthsPlan({super.key});
//
//   @override
//   State<ThirtySixMonthsPlan> createState() => _ThirtySixMonthsPlanState();
// }
//
// class _ThirtySixMonthsPlanState extends State<ThirtySixMonthsPlan> {
//   EvSubscriptionCarsModel evSubscriptionCarsModelObject = EvSubscriptionCarsModel();
//   bool loadingP = true;
//
//   double? totalAmount = 0.0;
//   double serviceFee = 50.0;
//
//   myTotal(){
//     totalAmount = double.parse(evSubscriptionCarsModelObject.data![0].carsPlans![2].discountedPricePerMonth.toString()) + serviceFee;
//     print("my36MonthsTotal: $totalAmount");
//   }
//
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
//         myTotal();
//       }
//     } catch (e) {
//       print('Error in evSubscription: ${e.toString()}');
//     }
//     loadingP = false;
//     setState(() {});
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getEvSubscriptionCarsWidget();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return loadingP ? Center(child: CircularProgressIndicator(color: borderColor))
//           : evSubscriptionCarsModelObject.status != "success" ?
//       const Center(child: Text('no data found...',
//           style: TextStyle(fontWeight: FontWeight.bold))) :
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("36 Months Plan", textAlign: TextAlign.left, style: TextStyle(
//                 fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//             Text("RM ${evSubscriptionCarsModelObject.data![0].carsPlans![2].discountedPricePerMonth}", textAlign: TextAlign.right, style: TextStyle(
//                 fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//           ],
//         ),
//         SizedBox(height: screenHeight * 0.015),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Service Fee (6%)", textAlign: TextAlign.left, style: TextStyle(
//                 fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//             Text("RM $serviceFee", textAlign: TextAlign.right, style: TextStyle(
//                 fontSize: 14, fontFamily: poppinRegular, color: detailsTextColor)),
//           ],
//         ),
//         SizedBox(height: screenHeight * 0.02),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Monthly Total Fee", textAlign: TextAlign.left, style: TextStyle(
//                 fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
//             Text("RM $totalAmount", textAlign: TextAlign.left, style: TextStyle(
//                 fontSize: 16, fontFamily: poppinSemiBold, color: kBlack)),
//           ],
//         ),
//       ],
//     );
//   }
// }
