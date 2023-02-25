// import 'dart:convert';
// import 'dart:io';
// import 'package:auto_haus_rental_app/Model/CheckOutModels/photography_checkout_model.dart';
// import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
// import 'package:auto_haus_rental_app/Utils/api_urls.dart';
// import 'package:auto_haus_rental_app/Utils/colors.dart';
// import 'package:auto_haus_rental_app/Utils/constants.dart';
// import 'package:auto_haus_rental_app/Utils/cookies_utils.dart';
// import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
// import 'package:auto_haus_rental_app/Widget/button.dart';
// import 'package:auto_haus_rental_app/Widget/toast_message.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:http/http.dart'as http;
// import '../../../../../../../Model/HomePageModels/top_rented_cars_model.dart';
// import '../../../../../MyAppBarHeader/app_bar_header.dart';
//
// class HomeEvCart extends StatefulWidget {
//   final DatumTopRented? myDatum;
//   final String? mySelectedTabMonth, mySelectedTabPrice;
//   final double? totalAmount;
//
//   const HomeEvCart({Key? key, this.myDatum, this.totalAmount,
//   this.mySelectedTabMonth, this.mySelectedTabPrice}) : super(key: key);
//
//   @override
//   State<HomeEvCart> createState() => _HomeEvCartState();
// }
//
// class _HomeEvCartState extends State<HomeEvCart> {
//   final GlobalKey<FormState> formKeyCheckOut = GlobalKey<FormState>();
//
//   var emailController = TextEditingController();
//
//   File? image;
//
//   Future pickCoverImage() async {
//     try {
//       final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (selectedImage == null) return;
//       final imageTemporary = File(selectedImage.path);
//       setState(() {
//         image = imageTemporary;
//         print("newImage $image");
//         // onUploadImage();
//       });
//     } on PlatformException catch (e) {
//       print('Failed to pick image: ${e.toString()}');
//     }
//   }
//   bool isInAsyncCall = false;
//
//   PhotographyCheckOutModel photographyCheckOutModelObject = PhotographyCheckOutModel();
//   bool loader = false;
//
//   checkOutWidget() async {
//     setState(() {
//       loader = true;
//     });
//     var request = http.MultipartRequest('POST', Uri.parse(checkOutDrivingApiUrl));
//
//     Map<String, String> headers = {
//       'Accept' : 'application/json',
//       'Cookie': cookieCheckOutDrivingApi,
//     };
//
//     print("apiRequest: $request");
//     request.fields['users_customers_id'] = '$userId';
//     request.fields['cars_id'] = '$carID';
//     request.fields['plan_start_date'] = evStartDate!;
//     request.fields['plan_end_date'] = evEndDate!;
//     request.fields['months'] = "$myMonth";
//     request.fields['price_per_month'] = "$myDiscountedAmount";
//     request.fields['discount_percentage'] = "${widget.myDatum!.discountPercentage}";
//     request.fields['total_cost'] = "$myTotalAmount";
//     request.files.add(
//       http.MultipartFile(
//         'driving_license',
//         image!.readAsBytes().asStream(),
//         image!.lengthSync(),
//         filename: image!.path.split('/').last,
//       ),
//     );
//
//     request.headers.addAll(headers);
//     print("request: $request");
//     print('usersId: $userId');
//     print('carsId: $carID');
//     print('plan_start_date: $evStartDate');
//     print('plan_end_date: $evEndDate');
//     print('months: $myMonth');
//     print('totalCost: $myTotalAmount');
//     print('pricePerHour: $myDiscountedAmount');
//     print('discountPercentage: ${widget.myDatum!.discountPercentage}');
//     print('licenseImage: ${image!.path.split('/').last}');
//
//     var res = await request.send();
//     http.Response response = await http.Response.fromStream(res);
//     final resJson = jsonDecode(response.body);
//     print("jsonResponseCheckOutApi $resJson");
//     setState(() {
//       loader = false;
//     });
//
//   }
//   String? myMonth, myDiscountedAmount;
//   double? myTotalAmount;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     myMonth = widget.mySelectedTabMonth;
//     myDiscountedAmount = widget.mySelectedTabPrice;
//     myTotalAmount = widget.totalAmount;
//     mySelectedData();
//   }
//   mySelectedData(){
//     print("userId carId: $userId $carID");
//     print("selectedTabMonth: $myMonth");
//     print("evTotalPrice: $myTotalAmount");
//     print('evStartEndDate: $evStartDate $evEndDate');
//     print("pricePerMonth: $myDiscountedAmount");
//     print("carDiscountPercentage: ${widget.myDatum!.discountPercentage}");
//   }
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
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: homeBgColor,
//       appBar: const MyAppBarSingleImage(
//         title: "Cart Details",
//         backImage: "assets/messages_images/Back.png",
//       ),
//       body: ModalProgressHUD(
//         inAsyncCall: isInAsyncCall,
//         opacity: 0.02,
//         blur: 0.5,
//         color: Colors.transparent,
//         progressIndicator: CircularProgressIndicator(
//           color: borderColor,
//         ),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.height * 0.015),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.9,
//                 color: Colors.transparent,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 70,
//                       left: 0,
//                       right: 0,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.8,
//                           width: MediaQuery.of(context).size.width * 0.47,
//                           decoration: BoxDecoration(
//                               color: kWhite,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 15),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.13),
//                                 Row(
//                                   children: [
//                                     Text("${widget.myDatum!.vehicalName} ", textAlign: TextAlign.left,
//                                       style: TextStyle(color: kBlack,
//                                         fontSize: 14, fontFamily: poppinBold)),
//
//                                     Text("${widget.myDatum!.carsColors!.name}", textAlign: TextAlign.left,
//                                         style: TextStyle(color: kBlack,
//                                             fontSize: 12, fontFamily: poppinRegular)),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//
//                                     Text("${widget.myDatum!.carsMakes!.name}, ", textAlign: TextAlign.left,
//                                       style: TextStyle(color: kBlack,
//                                         fontSize: 12, fontFamily: poppinRegular)),
//                                     Text("${widget.myDatum!.carsModels!.name}, ", textAlign: TextAlign.left,
//                                         style: TextStyle(color: kBlack,
//                                             fontSize: 12, fontFamily: poppinSemiBold)),
//                                     Text("${widget.myDatum!.year} ", textAlign: TextAlign.left,
//                                         style: TextStyle(color: kBlack,
//                                             fontSize: 12, fontFamily: poppinRegular)),
//
//                                   ],
//                                 ),
//                                 // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 04),
//                                       child: Text("RM ", textAlign: TextAlign.left,
//                                         style: TextStyle(color: kRed,
//                                             fontSize: 5, fontFamily: poppinLight)),
//                                     ),
//                                     Text("${widget.myDatum!.carsPlans![0].pricePerMonth}", textAlign: TextAlign.left,
//                                       style: TextStyle(color: kRed,
//                                           decoration: TextDecoration.lineThrough,
//                                           fontSize: 10, fontFamily: poppinLight),
//                                     ),
//                                     SizedBox(width: MediaQuery.of(context).size.width * 0.02),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 06),
//                                       child: Text("RM ", textAlign: TextAlign.left,
//                                         style: TextStyle(color: borderColor,
//                                             fontSize: 7, fontFamily: poppinSemiBold)),
//                                     ),
//                                     Text("${widget.myDatum!.carsPlans![0].discountedPricePerMonth}",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(color: borderColor,
//                                           fontSize: 20, fontFamily: poppinSemiBold)),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 4),
//                                       child: Text("/month", textAlign: TextAlign.left,
//                                         style: TextStyle(color: kBlack,
//                                             fontSize: 8, fontFamily: poppinRegular),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Row(
//                                   children: [
//                                     Image.asset("assets/home_page/Promoted.png"),
//                                     const SizedBox(width: 05),
//                                     Text("Verified Dealer", textAlign: TextAlign.left,
//                                       style: TextStyle(color: textLabelColor,
//                                         fontSize: 10, fontFamily: poppinRegular)),
//                                     const SizedBox(width: 05,),
//                                     Container(
//                                       height: 20, width: 40,
//                                       decoration: BoxDecoration(
//                                           color: kBlack,
//                                           borderRadius: BorderRadius.circular(20)),
//                                       child: Center(
//                                         child: Text("New", textAlign: TextAlign.left,
//                                           style: TextStyle(color: kWhite,
//                                               fontSize: 8, fontFamily: poppinRegular)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Row(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         SizedBox(width: MediaQuery.of(context).size.height * 0.01),
//                                         Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
//                                         SizedBox(
//                                           width: MediaQuery.of(context).size.height * 0.01),
//
//                                         widget.myDatum!.rating == null?
//                                         Text("0.0", textAlign: TextAlign.left,
//                                           style: TextStyle(color: kBlack,
//                                               fontSize: 12, fontFamily: poppinRegular)):
//                                         Text("${widget.myDatum!.rating}", textAlign: TextAlign.left,
//                                             style: TextStyle(color: kBlack,
//                                                 fontSize: 12, fontFamily: poppinRegular))
//                                       ],
//                                     ),
//                                     SizedBox(width: MediaQuery.of(context).size.height * 0.2),
//                                     Container(
//                                       height: 25, width: 80,
//                                       decoration: BoxDecoration(
//                                           color: kBlack,
//                                           borderRadius: BorderRadius.circular(20)),
//                                       child: Center(
//                                         child: Text("Pre book", textAlign: TextAlign.left,
//                                           style: TextStyle(color: kWhite,
//                                               fontSize: 12, fontFamily: poppinMedium)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 05),
//                                   child: Divider(),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("$myMonth month Plan", textAlign: TextAlign.left,
//                                       style: TextStyle(color: textLabelColor,
//                                           fontSize: 14, fontFamily: poppinRegular)),
//                                     Text("RM $myDiscountedAmount", textAlign: TextAlign.right,
//                                       style: TextStyle(color: textLabelColor,
//                                           fontSize: 14, fontFamily: poppinRegular)),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Service Fee (6%)",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(color: textLabelColor,
//                                           fontSize: 14, fontFamily: poppinRegular)),
//                                     Text("RM $serviceFee", textAlign: TextAlign.right,
//                                       style: TextStyle(color: textLabelColor,
//                                           fontSize: 14, fontFamily: poppinRegular)),
//                                   ],
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("Total Fee", textAlign: TextAlign.left,
//                                       style: TextStyle(color: kBlack,
//                                           fontSize: 16, fontFamily: poppinSemiBold)),
//                                     Text("RM $myTotalAmount", textAlign: TextAlign.right,
//                                       style: TextStyle(color: kBlack,
//                                           fontSize: 16, fontFamily: poppinSemiBold)),
//                                   ],
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                                 Text("Add your driving license image",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(color: textLabelColor,
//                                         fontSize: 14, fontFamily: poppinRegular)),
//
//                                 Form(
//                                   key: formKeyCheckOut,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           Container(
//                                             decoration: BoxDecoration(
//                                                 color: kWhite,
//                                                 shape: BoxShape.circle,
//                                                 border: Border.all(color: kWhite, width: 3)),
//                                             child: CircleAvatar(
//                                               radius: (screenWidth > 600) ? 90 : 70,
//                                               backgroundColor: Colors.transparent,
//                                               backgroundImage: image == null?
//                                               const AssetImage("assets/icon/fade_in_image.jpeg",)
//                                                   : Image.file(image!, height: 50, width: 50, fit: BoxFit.contain,).image,
//                                             ),
//                                           ),
//
//                                           Positioned(
//                                             right: 0,
//                                             bottom: 18,
//                                             child: GestureDetector(
//                                                 onTap: (){
//                                                   pickCoverImage();
//                                                 },
//                                                 child: Image.asset("assets/payment_card_images/edit_profile_icon.png")),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//
//                                 Center(
//                                   child: Text(
//                                     "*A security deposit may be applicable, depending on your eligibility assessment.",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(fontSize: 12,
//                                         fontFamily: poppinRegular, color: borderColor)),
//                                 ),
//                                 SizedBox(height: MediaQuery.of(context).size.height * 0.02),
//                                 Center(
//                                   child: GestureDetector(
//                                     onTap: (){
//                                       // Navigator.pushReplacement(context, MaterialPageRoute(
//                                       //     builder: (context) => BookForWeddingBookingDetails(
//                                       //       carName: widget.carName,
//                                       //       carYear: widget.carYear,
//                                       //       selectedStartTime: widget.selectedStartTime,
//                                       //       selectedEndTime: widget.selectedEndTime,
//                                       //       selectedHours: widget.selectedHours,
//                                       //       hours: widget.totalHoursInNumber,
//                                       //       selectedDate: widget.myDate,
//                                       //       selectedDay: widget.myDay,)));
//                                     },
//                                     child: Container(
//                                       height: MediaQuery.of(context).size.height*0.03,
//                                       width: MediaQuery.of(context).size.width *0.3,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(20),
//                                           border: Border.all(color: borderColor)),
//                                       child: Center(
//                                           child: Text("Edit", textAlign: TextAlign.center,
//                                               style: TextStyle(fontSize: 12,
//                                                   fontFamily: poppinRegular, color: borderColor))),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 30, right: 20, top: 30,
//                       child: Image.network("$baseUrlImage${widget.myDatum!.image1}",
//                           width: 400, height: 140),
//                     ),
//                     Positioned(
//                         top: 0, left: 20,
//                         child: Container(
//                           height: MediaQuery.of(context).size.width * 0.07,
//                           width: MediaQuery.of(context).size.width * 0.2,
//                           decoration: const BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(15),
//                                 bottomLeft: Radius.circular(15)),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("${widget.myDatum!.discountPercentage}% ", textAlign: TextAlign.left,
//                                 style: TextStyle(color: kWhite,
//                                     fontSize: 12, fontFamily: poppinSemiBold)),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 03),
//                                 child: Text("OFF ", textAlign: TextAlign.left,
//                                     style: TextStyle(color: kWhite,
//                                         fontSize: 8, fontFamily: poppinRegular)),
//                               ),
//                             ],
//                           ),
//                         )),
//                     Positioned(
//                         top: 0, right: 20,
//                         child: Image.asset("assets/home_page/heart_transparent.png", color: kBlack),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                   onTap: () async {
//                     // bottomSheetWidget(context);
//
//                     if(formKeyCheckOut.currentState!.validate()){
//                       setState(() {
//                         isInAsyncCall = true;
//                       });
//                       if(image == null){
//                         toastFailedMessage("image error", kRed);
//                         setState(() {
//                           isInAsyncCall = false;
//                         });
//                       }
//                       await checkOutWidget();
//                         Future.delayed(const Duration(seconds: 3), () {
//                           toastSuccessMessage("CheckOut Successful ", Colors.green);
//
//                           Navigator.push(context, MaterialPageRoute(
//                               builder: (context) => const TabBarPage()));
//                           setState(() {
//                             isInAsyncCall = false;
//                           });
//                           print("false: $isInAsyncCall");
//                         });
//                     }
//
//                   },
//                   child: loginButton("Check out", context)),
//               const SizedBox(height: 20,),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
