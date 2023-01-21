import 'dart:convert';
import 'dart:io';
import 'package:auto_haus_rental_app/Model/CheckOutModels/photography_checkout_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/cookies_utils.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart'as http;
import '../../../../../../../../Model/HomePageModels/HomePageTopWidgetModels/driving_experience_cars_model.dart';
import '../../../../../../MyAppBarHeader/app_bar_header.dart';

class CartDetailsPageExperience extends StatefulWidget {
  final String? startTime, endTime, selectedDate;
  final ExperienceDatumList? myDatum;
  final double? totalPrice;

  const CartDetailsPageExperience({Key? key, this.selectedDate,
    this.totalPrice, this.myDatum, this.startTime, this.endTime}) : super(key: key);

  @override
  State<CartDetailsPageExperience> createState() => _CartDetailsPageExperienceState();
}

class _CartDetailsPageExperienceState extends State<CartDetailsPageExperience> {
  final GlobalKey<FormState> formKeyCheckOut = GlobalKey<FormState>();

  var emailController = TextEditingController();

  File? image;

  Future pickCoverImage() async {
    try {
      final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) return;
      final imageTemporary = File(selectedImage.path);
      setState(() {
        image = imageTemporary;
        print("newImage $image");
        // onUploadImage();
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: ${e.toString()}');
    }
  }
  bool isInAsyncCall = false;

  PhotographyCheckOutModel photographyCheckOutModelObject = PhotographyCheckOutModel();
  bool loader = false;

  mySelectedData(){
    print("userId: $userId");
    print("carId: $carID");
    print("planDate: ${widget.selectedDate}");
    print("carStartEndTime: $myStartTime $myeEndTime");
    print("pricePerSlot: ${widget.myDatum!.carsPlans![0].discountedPricePerSlot}");
    print("carDiscountPercentage: ${widget.myDatum!.discountPercentage}");
    print("totalCost: ${widget.totalPrice}");
  }

  checkOutWidget() async {
    setState(() {
      loader = true;
    });
    var request = http.MultipartRequest('POST', Uri.parse(checkOutDrivingApiUrl));

    Map<String, String> headers = {
      'Accept' : 'application/json',
      // 'Cookie': cookieCheckOutApi,
      'Cookie': cookieCheckOutDrivingApi,
    };

    print("apiRequest: $request");
    request.fields['users_customers_id'] = '$userId';
    request.fields['cars_id'] = '$carID';
    request.fields['plan_date'] = "${widget.selectedDate}";
    request.fields['start_time'] = "$myStartTime";
    request.fields['end_time'] = "$myeEndTime";
    request.fields['price_per_slot'] = "${widget.myDatum!.carsPlans![0].discountedPricePerSlot}";
    request.fields['discount_percentage'] = "${widget.myDatum!.discountPercentage}";
    request.fields['total_cost'] = "${widget.totalPrice}";
    request.files.add(
      http.MultipartFile(
        'driving_license',
        image!.readAsBytes().asStream(),
        image!.lengthSync(),
        filename: image!.path.split('/').last,
      ),
    );

    request.headers.addAll(headers);
    print("request: $request");

    print('usersId: $userId');
    print('carsId: $carID');
    print('planDate: ${widget.selectedDate}');
    print('startTime: $myStartTime');
    print('endTime: $myeEndTime');
    print('totalCost: ${widget.totalPrice}');
    print('pricePerHour: ${widget.myDatum!.carsPlans![0].discountedPricePerSlot}');
    print('discountPercentage: ${widget.myDatum!.discountPercentage}');
    print('licenseImage: ${image!.path.split('/').last}');

    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    final resJson = jsonDecode(response.body);
    print("jsonResponseCheckOutApi $resJson");
    setState(() {
      loader = false;
    });

  }

  String? myStartTime, myeEndTime;
  myData(){
    myStartTime = widget.startTime!.substring(0, 5);
    myeEndTime = widget.endTime!.substring(0, 5);
    print("splitTime $myStartTime $myeEndTime");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myData();
    mySelectedData();
  }

  // Initial Selected Value
  String dropdownValue = 'Select state';

  // List of items in our dropdown menu
  var items = [
    'Select state',
    'Select state 1',
    'Select state 2',
    'Select state 3',
    'Select state 4',
    'Select state 5',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: const MyAppBarSingleImage(
        title: "Cart Details",
        backImage: "assets/messages_images/Back.png",
      ),
      body: ModalProgressHUD(
        inAsyncCall: isInAsyncCall,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: borderColor,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.72,
                          width: MediaQuery.of(context).size.width * 0.47,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                                Row(
                                  children: [
                                    Text("${widget.myDatum!.vehicalName} | ", textAlign: TextAlign.left,
                                      style: TextStyle(color: kBlack,
                                        fontSize: 14, fontFamily: poppinBold)),
                                    Text("${widget.myDatum!.carsMakes!.name} ", textAlign: TextAlign.left,
                                      style: TextStyle(color: kBlack,
                                        fontSize: 12, fontFamily: poppinRegular)),
                                    Text("${widget.myDatum!.carsModels!.name} ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack,
                                            fontSize: 14, fontFamily: poppinMedium)),
                                    Text("${widget.myDatum!.year}", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack,
                                            fontSize: 10, fontFamily: poppinRegular)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 04),
                                      child: Text("RM ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kRed,
                                            fontSize: 5, fontFamily: poppinLight)),
                                    ),
                                    Text("${widget.myDatum!.carsPlans![0].pricePerSlot}", textAlign: TextAlign.left,
                                      style: TextStyle(color: kRed,
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 10, fontFamily: poppinLight),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 06),
                                      child: Text("RM ", textAlign: TextAlign.left,
                                        style: TextStyle(color: borderColor,
                                            fontSize: 7, fontFamily: poppinSemiBold)),
                                    ),
                                    Text("${widget.myDatum!.carsPlans![0].discountedPricePerSlot}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: borderColor,
                                          fontSize: 20, fontFamily: poppinSemiBold)),
                                    Text("/ hour", textAlign: TextAlign.left,
                                      style: TextStyle(color: kBlack,
                                          fontSize: 8, fontFamily: poppinRegular),
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    Image.asset("assets/home_page/Promoted.png"),
                                    const SizedBox(width: 05),
                                    Text("Verified Dealer", textAlign: TextAlign.left,
                                      style: TextStyle(color: textLabelColor,
                                        fontSize: 10, fontFamily: poppinRegular)),
                                    const SizedBox(width: 05,),
                                    Container(
                                      height: 20, width: 40,
                                      decoration: BoxDecoration(
                                          color: kBlack,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text("New", textAlign: TextAlign.left,
                                          style: TextStyle(color: kWhite,
                                              fontSize: 8, fontFamily: poppinRegular)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                        Image.asset("assets/home_page/9004787_star_favorite_award_like_icon.png"),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.height * 0.01),

                                        widget.myDatum!.rating == null?
                                        Text("0.0", textAlign: TextAlign.left,
                                          style: TextStyle(color: kBlack,
                                              fontSize: 12, fontFamily: poppinRegular)):
                                        Text("${widget.myDatum!.rating}", textAlign: TextAlign.left,
                                            style: TextStyle(color: kBlack,
                                                fontSize: 12, fontFamily: poppinRegular))
                                      ],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.height * 0.2),
                                    Container(
                                      height: 25, width: 80,
                                      decoration: BoxDecoration(
                                          color: kBlack,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text("Pre book", textAlign: TextAlign.left,
                                          style: TextStyle(color: kWhite,
                                              fontSize: 12, fontFamily: poppinMedium)),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 05),
                                  child: Divider(),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("$myStartTime -- $myeEndTime Plan", textAlign: TextAlign.left,
                                      style: TextStyle(color: textLabelColor,
                                          fontSize: 14, fontFamily: poppinRegular)),
                                    Text("RM ${widget.myDatum!.carsPlans![0].discountedPricePerSlot}", textAlign: TextAlign.right,
                                      style: TextStyle(color: textLabelColor,
                                          fontSize: 14, fontFamily: poppinRegular)),
                                  ],
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Service Fee (6%)",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: textLabelColor,
                                          fontSize: 14, fontFamily: poppinRegular)),
                                    Text("RM $serviceFee", textAlign: TextAlign.right,
                                      style: TextStyle(color: textLabelColor,
                                          fontSize: 14, fontFamily: poppinRegular)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Fee", textAlign: TextAlign.left,
                                      style: TextStyle(color: kBlack,
                                          fontSize: 16, fontFamily: poppinSemiBold)),
                                    Text("RM ${widget.totalPrice}", textAlign: TextAlign.right,
                                      style: TextStyle(color: kBlack,
                                          fontSize: 16, fontFamily: poppinSemiBold)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                Form(
                                  key: formKeyCheckOut,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: kWhite,
                                                shape: BoxShape.circle,
                                                border: Border.all(color: kWhite, width: 3)),
                                            child: CircleAvatar(
                                              radius: (screenWidth > 600) ? 90 : 70,
                                              backgroundColor: Colors.transparent,
                                              backgroundImage: image == null?
                                              const AssetImage("assets/icon/fade_in_image.jpeg",)
                                                  : Image.file(image!, height: 50, width: 50, fit: BoxFit.contain,).image,
                                            ),
                                          ),

                                          Positioned(
                                            right: 0,
                                            bottom: 18,
                                            child: GestureDetector(
                                                onTap: (){
                                                  pickCoverImage();
                                                },
                                                child: Image.asset("assets/payment_card_images/edit_profile_icon.png")),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                Center(
                                  child: Text(
                                    "*A security deposit may be applicable, depending on your eligibility assessment.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 12,
                                        fontFamily: poppinRegular, color: borderColor)),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                Center(
                                  child: GestureDetector(
                                    onTap: (){
                                      // Navigator.pushReplacement(context, MaterialPageRoute(
                                      //     builder: (context) => BookForWeddingBookingDetails(
                                      //       carName: widget.carName,
                                      //       carYear: widget.carYear,
                                      //       selectedStartTime: widget.selectedStartTime,
                                      //       selectedEndTime: widget.selectedEndTime,
                                      //       selectedHours: widget.selectedHours,
                                      //       hours: widget.totalHoursInNumber,
                                      //       selectedDate: widget.myDate,
                                      //       selectedDay: widget.myDay,)));
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.03,
                                      width: MediaQuery.of(context).size.width *0.3,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: borderColor)),
                                      child: Center(
                                          child: Text("Edit", textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12,
                                                  fontFamily: poppinRegular, color: borderColor))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Image.network("$baseUrlImage${widget.myDatum!.image1}", width: 400, height: 150),
                    ),
                    Positioned(
                        top: 0, left: 20,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.07,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.myDatum!.discountPercentage}% ", textAlign: TextAlign.left,
                                style: TextStyle(color: kWhite,
                                    fontSize: 12, fontFamily: poppinSemiBold)),
                              Padding(
                                padding: const EdgeInsets.only(top: 03),
                                child: Text("OFF ", textAlign: TextAlign.left,
                                    style: TextStyle(color: kWhite,
                                        fontSize: 8, fontFamily: poppinRegular)),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 0, right: 20,
                        child: Image.asset("assets/home_page/heart_transparent.png", color: kBlack),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () async {
                  // bottomSheetWidget();

                    if(formKeyCheckOut.currentState!.validate()){
                      setState(() {
                        isInAsyncCall = true;
                      });
                      if(image == null){
                        toastFailedMessage("image error", kRed);
                        setState(() {
                          isInAsyncCall = false;
                        });
                      }
                      await checkOutWidget();
                        Future.delayed(const Duration(seconds: 3), () {
                          toastSuccessMessage("CheckOut Successful ", Colors.green);

                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const TabBarPage()));
                          setState(() {
                            isInAsyncCall = false;
                          });
                          print("false: $isInAsyncCall");
                        });
                    }

                  },
                  child: loginButton("Check out", context)),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
  // bottomSheetWidget(){
  //   return showMaterialModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     context: context,
  //     builder: (context) => SingleChildScrollView(
  //       controller: ModalScrollController.of(context),
  //       child: Container(
  //         decoration: BoxDecoration(
  //             color: homeBgColor,
  //             borderRadius: const BorderRadius.only(
  //               topRight: Radius.circular(30),
  //               topLeft: Radius.circular(30),
  //             )),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 20),
  //           child: Column(
  //             children: [
  //               const SizedBox(height: 20),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
  //                 child: Container(
  //                   height: MediaQuery.of(context).size.height * 0.05,
  //                   width: MediaQuery.of(context).size.width,
  //                   decoration: BoxDecoration(
  //                       color: kBlack,
  //                       borderRadius: BorderRadius.circular(30)),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Image.asset("assets/payment_card_images/apple_image.png",
  //                           color: kWhite),
  //                       const SizedBox(width: 10),
  //                       Text("Pay", textAlign: TextAlign.center,
  //                           style: TextStyle(color: kWhite,
  //                               fontFamily: poppinRegular, fontSize: 18)),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Text("Or pay with card",
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(color: detailsTextColor,
  //                       fontFamily: poppinSemiBold, fontSize: 16)),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   textWidgetBlack("Email"),
  //                   SizedBox(height: MediaQuery.of(context).size.height * 0.005),
  //                   EditTextUtils().getCustomEditTextArea(
  //                     hintValue: "rose.matthews@mail.com",
  //                     validation: true,
  //                     // autoFocus: true,
  //                     // textController: firstNameController,
  //                     keyboardType: TextInputType.text,
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   textWidgetBlack("Card Information"),
  //                   SizedBox(height: MediaQuery.of(context).size.height * 0.005),
  //                   Container(
  //                     height: MediaQuery.of(context).size.height * 0.06,
  //                     decoration: BoxDecoration(
  //                       color: kWhite,
  //                       borderRadius: BorderRadius.circular(30.0),
  //                     ),
  //                     child: TextField(
  //                       keyboardType: TextInputType.number,
  //                       decoration: InputDecoration(
  //                         border: InputBorder.none,
  //                         contentPadding: const EdgeInsets.all(20),
  //                         focusedBorder: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(30.0),
  //                             borderSide: BorderSide(color: borderColor)),
  //                         hintText: 'xxxx xxxx xxxx xxxx',
  //                         hintStyle: TextStyle(color: textLabelColor),
  //                         focusColor: borderColor,
  //                         fillColor: kWhite,
  //                         prefixIcon: Image.asset("assets/payment_card_images/card_prefix.png"),
  //                         suffixIcon: Image.asset("assets/payment_card_images/visa_icon.png",),
  //                       ),
  //                       style: TextStyle(
  //                           color: borderColor, fontSize: 14),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         textWidgetBlack("Expire date"),
  //                         SizedBox(height: MediaQuery.of(context).size.height * 0.005),
  //                         Container(
  //                           height: MediaQuery.of(context).size.height * 0.06,
  //                           decoration: BoxDecoration(
  //                               color: kWhite,
  //                               borderRadius: BorderRadius.circular(30.0)),
  //                           child: TextField(
  //                             keyboardType: TextInputType.emailAddress,
  //                             decoration: InputDecoration(
  //                               border: InputBorder.none,
  //                               contentPadding: const EdgeInsets.all(20),
  //                               focusedBorder: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(30.0),
  //                                   borderSide: BorderSide(color: borderColor)),
  //                               hintText: 'MM/YY',
  //                               hintStyle: TextStyle(color: textLabelColor),
  //                               focusColor: borderColor,
  //                               prefixIcon: Image.asset("assets/payment_card_images/calendar.png",),
  //                             ),
  //                             style: TextStyle(color: borderColor, fontSize: 14),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: MediaQuery.of(context).size.width * 0.02),
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         textWidgetBlack("CVC"),
  //                         SizedBox(height: MediaQuery.of(context).size.height * 0.005),
  //                         Container(
  //                           height: MediaQuery.of(context).size.height * 0.06,
  //                           decoration: BoxDecoration(
  //                             color: kWhite,
  //                             borderRadius: BorderRadius.circular(30.0),
  //                           ),
  //                           child: TextField(
  //                             keyboardType: TextInputType.emailAddress,
  //                             decoration: InputDecoration(
  //                               border: InputBorder.none,
  //                               contentPadding: const EdgeInsets.all(20),
  //                               focusedBorder: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(30.0),
  //                                   borderSide: BorderSide(color: borderColor)),
  //                               hintText: 'CVC',
  //                               hintStyle: TextStyle(color: textLabelColor),
  //                               focusColor: borderColor,
  //                               prefixIcon: Image.asset("assets/payment_card_images/cvc.png"),
  //                             ),
  //                             style: TextStyle(color: borderColor, fontSize: 14),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   textWidgetBlack("Country or Region"),
  //                   SizedBox(height: MediaQuery.of(context).size.height * 0.005),
  //                   Container(
  //                     height: MediaQuery.of(context).size.height * 0.06,
  //                     width: MediaQuery.of(context).size.width,
  //                     decoration: BoxDecoration(
  //                         color: kWhite,
  //                         borderRadius: BorderRadius.circular(30)),
  //                     padding: const EdgeInsets.symmetric(horizontal: 10),
  //                     child: DropdownButtonHideUnderline(
  //                       child: DropdownButton(
  //                         // Initial Value
  //                         value: dropdownValue,
  //                         icon: const Icon(Icons.keyboard_arrow_down),
  //                         // Array list of items
  //                         items: items.map((String items) {
  //                           return DropdownMenuItem(
  //                             value: items,
  //                             child: Text(items),
  //                           );
  //                         }).toList(),
  //                         // After selecting the desired option,it will
  //                         // change button value to selected value
  //                         onChanged: (String? newValue) {
  //                           setState(() {
  //                             dropdownValue = newValue!;
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   textWidgetBlack("Zip"),
  //                   SizedBox(height: MediaQuery.of(context).size.height * 0.005),
  //                   Container(
  //                     height: MediaQuery.of(context).size.height * 0.06,
  //                     decoration: BoxDecoration(
  //                       color: kWhite,
  //                       borderRadius: BorderRadius.circular(30.0),
  //                     ),
  //                     child: AddressTextUtils().getCustomEditTextArea(
  //                       hintValue: "Select state",
  //                       validation: true,
  //                       // autoFocus: true,
  //                       // textController: resetEmailController,
  //                       keyboardType: TextInputType.text,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //               GestureDetector(
  //                 onTap: () {
  //                   showDialog(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return Container(
  //                           color: const Color(0xffb0b0b0),
  //                           child: Container(
  //                             color: const Color(0xffb0b0b0),
  //                             child: Container(
  //                               color: const Color(0xff0f172a).withOpacity(0.5),
  //                               child: Dialog(
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(20.0),
  //                                 ),
  //                                 child: Container(
  //                                   decoration: BoxDecoration(
  //                                       color: homeBgColor,
  //                                       borderRadius: BorderRadius.circular(20)),
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(12.0),
  //                                     child: Column(
  //                                       mainAxisAlignment: MainAxisAlignment.center,
  //                                       crossAxisAlignment: CrossAxisAlignment.center,
  //                                       mainAxisSize: MainAxisSize.min,
  //                                       children: [
  //                                         Row(
  //                                           mainAxisAlignment: MainAxisAlignment.end,
  //                                           crossAxisAlignment: CrossAxisAlignment.end,
  //                                           children: [
  //                                             GestureDetector(
  //                                               onTap: () {
  //                                                 Navigator.pop(context);
  //                                               },
  //                                               child:
  //                                               Image.asset("assets/payment_card_images/cancle.png"),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                         Image.asset("assets/payment_card_images/alert_dialog_image.png"),
  //                                         SizedBox(height: MediaQuery.of(context).size.height * 0.01),
  //                                         Text("Congratulation!", textAlign: TextAlign.center,
  //                                             style: TextStyle(color: borderColor,
  //                                                 fontSize: 24, fontFamily: poppinSemiBold)),
  //                                         SizedBox(height: MediaQuery.of(context).size.height * 0.01),
  //                                         Text("Your Ride is Booked.", textAlign: TextAlign.center,
  //                                             style: TextStyle(color: textLabelColor,
  //                                                 fontSize: 20, fontFamily: poppinMedium)),
  //                                         SizedBox(height: MediaQuery.of(context).size.height * 0.02),
  //                                         GestureDetector(
  //                                             onTap: () {
  //                                               Navigator.pop(context);
  //                                             },
  //                                             child: loginButton("Okay", context)),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         );
  //                       });
  //                 },
  //                 child: loginButton("Pay", context),
  //               ),
  //               SizedBox(height: MediaQuery.of(context).size.height * 0.03),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
