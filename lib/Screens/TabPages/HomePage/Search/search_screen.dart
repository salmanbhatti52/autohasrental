// import 'package:auto_haus_rental_app/Model/search_model.dart';
// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:auto_haus_rental_app/Widget/cars_home_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import '../HomePageTopCard/BookForWedding/book_for_wedding_car_description.dart';
// import '../HomePageTopCard/EvSubscriptions/ev_car_description.dart';
// import 'DrivingCarsSearch/search_driving_booking.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   var searchController = TextEditingController();
//   bool loading = true;
//   SearchModel searchModelObject = SearchModel();
//
//   searchProducts() async {
//     loading = true;
//     setState(() {});
//     print('in fetch search page');
//     // try {
//       String apiUrl = getCarFilterByNameApiUrl;
//       print("searchApiUrl $apiUrl");
//       print("userId $userId");
//       print("searchController ${searchController.text}");
//       // print("vehicalName ${searchModelObject.data![0].vehicalName}");
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         body: {
//           "users_customers_id": userId,
//           "keyword": searchController.text
//         },
//           headers: {
//             'Accept': 'application/json'
//           });
//
//       print(response);
//       if (response.statusCode == 200) {
//         final responseString = response.body;
//         print("responseString $responseString");
//         searchModelObject = searchModelFromJson(responseString);
//         print("searchItemsLength: ${searchModelObject.data?.length}");
//       }
//     // } catch (e) {
//     //   print('Error: ${e.toString()}');
//     // }
//     loading = false;
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     // searchProducts();
//     print("userId123 $userId");
//     print("searchController123 ${searchController.text}");
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           onChanged: (k) {
//             searchProducts();
//           },
//           controller: searchController,
//           autofocus: true,
//           style: TextStyle(color: borderColor),
//           decoration: const InputDecoration(
//             contentPadding: EdgeInsets.only(
//               left: 10.0, right: 10.0, top: 14.0,
//             ),
//             hintText: 'Search for Cars',
//             border: InputBorder.none,
//             suffixIcon: Icon(Icons.search, size: 18.0, color: Color(0xffD4DCE1)),
//           ),
//         ),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         elevation: 0.5,
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: borderColor),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(
//             FontAwesomeIcons.chevronLeft, size: 20.0),
//         ),
//       ),
//
//       body: loading ? Center(child: CircularProgressIndicator(backgroundColor: borderColor),) :
//
//       allSearchItemsList(),
//     );
//   }
//
//   Widget allSearchItemsList() {
//     return SingleChildScrollView(
//       child: Container(
//         color: Colors.transparent,
//         height: MediaQuery.of(context).size.height * 0.85,
//         child: ListView.builder(
//             shrinkWrap: true,
//             physics: const BouncingScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             itemCount: searchModelObject.data?.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     child: Container(
//                       height: MediaQuery.of(context).size.height * 0.33),
//                   ),
//                   Positioned(
//                     top: 90,
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 9),
//                       child: Container(
//                         height: MediaQuery.of(context).size.height * 0.26,
//                         width: 343,
//                         decoration: BoxDecoration(
//                           color: kWhite,
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.1),
//                               spreadRadius: 5,
//                               blurRadius: 5,
//                               offset: const Offset(3, 3),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Container(height: MediaQuery.of(context).size.height * 0.1),
//                             Row(
//                               children: [
//                                 const SizedBox(height: 93.6),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text("${searchModelObject.data?[index].vehicalName}, ",
//                                               style: TextStyle(color: kBlack, fontSize: 14,
//                                                   fontFamily: poppinBold), textAlign: TextAlign.left),
//                                           Text("${searchModelObject.data?[index].carsColors?.name} ",
//                                             textAlign: TextAlign.left, style: TextStyle(
//                                                 color: kBlack, fontSize: 14, fontFamily: poppinRegular),),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text("${searchModelObject.data?[index].carsMakes!.name}, ",
//                                               style: TextStyle(color: kBlack, fontSize: 12,
//                                                   fontFamily: poppinRegular), textAlign: TextAlign.left),
//                                           Text("${searchModelObject.data?[index].carsModels!.name}, ",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 12, fontFamily: poppinSemiBold)),
//                                           Text("${searchModelObject.data?[index].year}",
//                                               textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 04),
//                                             child: Text("RM",  textAlign: TextAlign.left,
//                                               style: TextStyle(color: kRed, fontSize: 5, fontFamily: poppinRegular)),
//                                           ),
//                                           searchModelObject.data![index].carsUsageType == "EV Subscriptions" ?
//                                           originalPriceWidget("${searchModelObject.data![index].carsPlans![0].pricePerMonth}") :
//                                           searchModelObject.data![index].carsUsageType == "Photography" ?
//                                           originalPriceWidget("${searchModelObject.data![index].carsPlans![0].pricePerHour}") :
//                                           originalPriceWidget("${searchModelObject.data![index].carsPlans![0].pricePerSlot}"),
//                                           // Text("${searchModelObject.data?[index].carsPlans![0].pricePerHour}",
//                                           //     style: TextStyle(
//                                           //         color: kRed,
//                                           //         decoration: TextDecoration.lineThrough,
//                                           //         decorationColor: kRed,
//                                           //         decorationThickness: 3,
//                                           //         fontSize: 10,
//                                           //         fontFamily: poppinLight,
//                                           //         height: 2),
//                                           //     textAlign: TextAlign.left):
//                                           // searchModelObject.data?[index].carsUsageType == "Driving Experience"?
//                                           //
//                                           // Text("${searchModelObject.data?[index].carsPlans![0].pricePerSlot}",
//                                           //     style: TextStyle(
//                                           //         color: kRed,
//                                           //         decoration: TextDecoration.lineThrough,
//                                           //         decorationColor: kRed,
//                                           //         decorationThickness: 3,
//                                           //         fontSize: 10,
//                                           //         fontFamily: poppinLight,
//                                           //         height: 2),
//                                           //     textAlign: TextAlign.left):
//                                           // Text("${searchModelObject.data?[index].carsPlans![0].pricePerMonth}",
//                                           //     style: TextStyle(
//                                           //         color: kRed,
//                                           //         decoration: TextDecoration.lineThrough,
//                                           //         decorationColor: kRed,
//                                           //         decorationThickness: 3,
//                                           //         fontSize: 10,
//                                           //         fontFamily: poppinLight,
//                                           //         height: 2),
//                                           //     textAlign: TextAlign.left),
//                                           const SizedBox(width: 5),
//                                           Padding(
//                                             padding: const EdgeInsets.only(top: 06),
//                                             child: Text("RM",  textAlign: TextAlign.left,
//                                                 style: TextStyle(color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
//                                           ),
//
//                                           searchModelObject.data?[index].carsUsageType == "Photography"?
//                                           Row(
//                                             children: [
//                                               Text("${searchModelObject.data?[index].carsPlans![0].discountedPricePerHour}",
//                                                   textAlign: TextAlign.left, style: TextStyle(
//                                                       color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
//                                               Text("/Hour", textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                                             ],
//                                           ):
//                                           searchModelObject.data?[index].carsUsageType == "Driving Experience"?
//                                           Row(
//                                             children: [
//                                               Text("${searchModelObject.data?[index].carsPlans![0].discountedPricePerSlot}",
//                                                   textAlign: TextAlign.left, style: TextStyle(
//                                                       color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
//                                               Text("/Slot", textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                                             ],
//                                           ):
//                                           Row(
//                                             children: [
//                                               Text("${searchModelObject.data?[index].carsPlans![0].discountedPricePerMonth}",
//                                                   textAlign: TextAlign.left, style: TextStyle(
//                                                       color: borderColor, fontSize: 16, fontFamily: poppinSemiBold)),
//                                               Text("/Month", textAlign: TextAlign.left, style: TextStyle(
//                                                   color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
//                                             ],
//                                           ),
//
//
//                                           SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                                           // showRatingStars(double.parse("${searchModelObject.data?[index].rating}")),
//                                           SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                                           searchModelObject.data?[index].rating == null
//                                               ? Text("0.0", style: TextStyle(color: kBlack, fontSize: 12,
//                                               fontFamily: poppinRegular), textAlign: TextAlign.left) :
//                                           Text("${searchModelObject.data?[index].rating}",
//                                               style: TextStyle(color: kBlack, fontSize: 12,
//                                                   fontFamily: poppinRegular), textAlign: TextAlign.left),
//                                         ],
//                                       ),
//                                       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                       Row(
//                                         children: [
//                                           Image.asset("assets/car_bookings_images/promoted.png"),
//                                           const SizedBox(width: 5),
//                                           Text("Verified Dealer", textAlign: TextAlign.left,
//                                               style: TextStyle(color: textLabelColor,
//                                                   fontSize: 10, fontFamily: poppinRegular)),
//                                           const SizedBox(width: 05),
//                                           Container(
//                                             height: 15, width: 35,
//                                             decoration: BoxDecoration(
//                                                 color: kBlack,
//                                                 borderRadius: BorderRadius.circular(10)),
//                                             child: Center(
//                                               child: Text("New",  textAlign: TextAlign.left,
//                                                   style: TextStyle(color: kWhite,
//                                                       fontSize: 8, fontFamily: poppinRegular)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 30, bottom: 35,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             carID = searchModelObject.data![index].carsId;
//                             print("cardId $carID");
//                             print("carsUsageType ${searchModelObject.data![index].carsUsageType}");
//
//                             if(searchModelObject.data![index].carsUsageType == "EV Subscriptions"){
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => EVCarDescription(
//                                     carName: searchModelObject.data![index].vehicalName,
//                                     carPrice: searchModelObject.data![index].carsPlans![0].pricePerMonth,
//                                     carImage: "$baseUrlImage${searchModelObject.data![index].image1}",
//                                     carYear: "${searchModelObject.data![index].year}",
//                                     carId: searchModelObject.data![index].carsId,
//                                     carRating: searchModelObject.data![index].rating,
//                                     carColorName: searchModelObject.data![index].carsColors!.name,
//                                     carMakesName: searchModelObject.data![index].carsMakes!.name,
//                                     carModelName: searchModelObject.data![index].carsModels!.name,
//                                     carMakesImage: "$baseUrlImage${searchModelObject.data![index].carsMakes!.image}",
//                                     carStatus: searchModelObject.data![index].favouriteStatus,
//                                     discountPercentage: searchModelObject.data![index].discountPercentage,
//                                     carDiscountPrice: double.parse("${searchModelObject.data![index].carsPlans![0].discountedPricePerMonth}"),
//                                     carOwnerImage: "$baseUrlImage${searchModelObject.data![index].usersCompanies!.companyLogo}",
//                                     carOwnerName: "${searchModelObject.data![index].usersCompanies!.companyName}",
//                                     carOwnerId: searchModelObject.data![index].usersCompanies!.usersCompaniesId,
//                                     myCarDescription: searchModelObject.data![index].description,
//                                     myCarRating: searchModelObject.data![index].carsRatings![0].rateStars,
//                                     myCarComment: searchModelObject.data![index].carsRatings![0].comments,
//                                   )));
//                             }
//                             else if(searchModelObject.data![index].carsUsageType == "Photography"){
//                               Navigator.push(context, MaterialPageRoute(
//                                   builder: (context) => BookForWeddingCarDescription(
//                                     carName: searchModelObject.data![index].vehicalName,
//                                     carYear: "${searchModelObject.data![index].year}",
//                                     carId: searchModelObject.data![index].carsId,
//                                     carRating: searchModelObject.data![index].rating,
//                                     carColorName: searchModelObject.data![index].carsColors!.name,
//                                     carMakesName: searchModelObject.data![index].carsMakes!.name,
//                                     carModelName: searchModelObject.data![index].carsModels!.name,
//                                     carImage: "$baseUrlImage${searchModelObject.data![index].image1}",
//                                     carMakesImage: "$baseUrlImage${searchModelObject.data![index].carsMakes!.image}",
//                                     favouriteStatus: searchModelObject.data![index].favouriteStatus,
//                                     discountPercentage: searchModelObject.data![index].discountPercentage,
//                                     carDiscountPrice: searchModelObject.data![index].carsPlans![0].discountedPricePerHour.toString(),
//                                     carPrice: searchModelObject.data![index].carsPlans![0].pricePerHour,
//                                     carOwnerImage: "$baseUrlImage${searchModelObject.data![index].usersCompanies!.companyLogo}",
//                                     carOwnerName: "${searchModelObject.data![index].usersCompanies!.companyName}",
//                                     carOwnerId: searchModelObject.data![index].usersCompanies!.usersCompaniesId,
//                                     myCarDescription: searchModelObject.data![index].description,
//                                     myCarRating: searchModelObject.data![index].carsRatings![0].rateStars,
//                                     myCarComment: searchModelObject.data![index].carsRatings![0].comments,
//                                   )));
//                             }
//                             else if(searchModelObject.data![index].carsUsageType == "Driving Experience"){
//                               Navigator.push(context,
//                                   MaterialPageRoute(builder: (context) => SearchDrivingBooking(
//                                     searchDatum: searchModelObject.data![index],
//                                   )));
//                             }
//
//                             // print("evCarName ${searchModelObject.data![index].vehicalName}");
//                             // print("evCarYear ${searchModelObject.data![index].year}");
//                             // print("evCarImage $baseUrlImage${searchModelObject.data![index].image1}");
//                             // print("ownerImage $baseUrlImage${searchModelObject.data![index].usersCompanies!.companyLogo}");
//                             // print("ownerName ${searchModelObject.data![index].usersCompanies!.companyName}");
//                             // print("ownerId ${searchModelObject.data![index].usersCompanies!.usersCompaniesId}");
//
//                           },
//                           child: Image.asset("assets/car_bookings_images/more_button.png"),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   Positioned(
//                     top: 10,
//                     left: 10, right: 10,
//                     child: searchModelObject.data?[index].image1 == null ?
//                     ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset('assets/icon/fade_in_image.jpeg')) :
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: FadeInImage(
//                         placeholder: const AssetImage("assets/icon/fade_in_image.jpeg"),
//                         height: 130, width: 350,
//                         image: NetworkImage("$baseUrlImage${searchModelObject.data?[index].image1}"),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                       top: 10,
//                       left: 10,
//                       child: Container(
//                         height: MediaQuery.of(context).size.width * 0.07,
//                         width: MediaQuery.of(context).size.width * 0.18,
//                         decoration: BoxDecoration(
//                           color: kRed.withOpacity(0.8),
//                           borderRadius: const BorderRadius.only(
//                               topRight: Radius.circular(15),
//                               bottomLeft: Radius.circular(15)),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("${searchModelObject.data?[index].discountPercentage}",
//                                 textAlign: TextAlign.left, style: TextStyle(color: kWhite,
//                                     fontSize: 13, fontFamily: poppinSemiBold)),
//                             Text(" OFF ", textAlign: TextAlign.left, style: TextStyle(
//                                 color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
//                           ],
//                         ),
//                       )),
//                   Positioned(
//                     top: 15,
//                     right: 15,
//                     child: searchModelObject.data?[index].favouriteStatus == "like"?
//                     Image.asset("assets/home_page/heart.png") :
//                     Image.asset("assets/car_bookings_images/heart.png"),
//                   ),
//                 ],
//               );
//             }),
//       ),
//     );
//   }
// }
