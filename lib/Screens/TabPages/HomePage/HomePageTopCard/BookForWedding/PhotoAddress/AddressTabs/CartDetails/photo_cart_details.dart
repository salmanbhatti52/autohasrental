import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Utils/cookies_utils.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Model/CheckOutModels/photography_checkout_model.dart';

class PhotoCartDetailsPage extends StatefulWidget {
  final String? amount, myDate, myDay, selectedStartTime, selectedEndTime, selectedHours;
  final int? totalHoursInNumber;
  final double? hoursAmount, totalAmount;

  final String? carName, carImage, carYear, carPrice, favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage,
      carRating, carOwnerImage, carOwnerName, discountPercentage, carDiscountPrice;
  final int? carId, carOwnerId;
  final String? homeAddress1, homeAddress2, homeCity, homePostCode, homeState, homeCountry,
      billingAddress1, billingAddress2, billingCity, billingPostCode, billingState, billingCountry;

  PhotoCartDetailsPage({Key? key, this.selectedHours, this.hoursAmount,
    this.totalAmount, this.selectedStartTime, this.myDate, this.myDay,
    this.selectedEndTime, this.totalHoursInNumber, this.amount,
    this.carName, this.carColorName, this.carModelName, this.discountPercentage,
    this.carDiscountPrice, this.carImage, this.carYear, this.carMakesImage,
    this.favouriteStatus, this.carMakesName, this.carId, this.carPrice, this.carRating,
    this.carOwnerId, this.carOwnerImage, this.carOwnerName,
    this.homeAddress1, this.homeAddress2, this.homeCity, this.homePostCode, this.homeState,
    this.homeCountry, this.billingAddress1, this.billingAddress2, this.billingCity,
    this.billingPostCode, this.billingState, this.billingCountry}) : super(key: key);

  @override
  State<PhotoCartDetailsPage> createState() => _PhotoCartDetailsPageState();
}

class _PhotoCartDetailsPageState extends State<PhotoCartDetailsPage> {
  final GlobalKey<FormState> formKeyCheckOut = GlobalKey<FormState>();

  var emailController = TextEditingController();

  mySelectedData() {
    print("carId3 $carID $userId");
    print('planDate3: ${widget.myDate}');
    print('startTime3: ${widget.selectedStartTime}');
    print('endTime3: ${widget.selectedEndTime}');
    print('totalCost3: ${widget.totalAmount}');
    print('totalHours3: ${widget.totalHoursInNumber}');
    print('pricePerHour3: ${widget.carDiscountPrice}');
    print('discountPercentage3: ${widget.discountPercentage}');
    print("homeState: ${widget.homeState} ${widget.homeCountry}");
    print("billingAddress: ${widget.billingAddress1} ${widget.billingAddress2}");
    print("billingPostCity: ${widget.billingCity} ${widget.billingPostCode}");
    print("billingState: ${widget.billingState} ${widget.billingCountry}");
    if(widget.homeAddress1!.isEmpty || widget.homeAddress2!.isEmpty || widget.homeCity!.isEmpty){
      addressAvailableStatus = "No";
      print("addressAvailableStatus $addressAvailableStatus");
    }
    else{
      addressAvailableStatus = "Yes";
      print("addressAvailableStatus $addressAvailableStatus");

    }
  }

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

  PhotographyCheckOutModel photoCheckOutModelObject = PhotographyCheckOutModel();
  bool loader = false;

  String? addressAvailableStatus;
  checkOutWidget() async {
    setState(() {
      loader = true;
    });
    var request = http.MultipartRequest('POST', Uri.parse(checkOutApiUrl));

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Cookie': cookieCheckOutApi,
    };

    print("apiRequest: $request");
    request.fields['users_customers_id'] = '$userId';
    request.fields['cars_id'] = '$carID';
    request.fields['plan_date'] = "${widget.myDate}";
    request.fields['start_time'] = "${widget.selectedStartTime}";
    request.fields['end_time'] = "${widget.selectedEndTime}";
    request.fields['total_hours'] = "${widget.totalHoursInNumber}";
    request.fields['price_per_hour'] = "${widget.carDiscountPrice}";
    request.fields['discount_percentage'] = "${widget.discountPercentage}";
    request.fields['total_cost'] = "${widget.totalAmount}";
    request.fields['addresses'] = "$addressAvailableStatus";
    request.fields['home_street_address_line1'] = "${widget.homeAddress1}";
    request.fields['home_street_address_line2'] = "${widget.homeAddress2}";
    request.fields['home_city'] = "${widget.homeCity}";
    request.fields['home_post_code'] = "${widget.homePostCode}";
    request.fields['home_state'] = "${widget.homeState}";
    request.fields['home_country'] = "${widget.homeCountry}";
    request.fields['billing_street_address_line1']= "${widget.billingAddress1}";
    request.fields['billing_street_address_line2']= "${widget.billingAddress2}";
    request.fields['billing_city'] = "${widget.billingCity}";
    request.fields['billing_post_code'] = "${widget.billingPostCode}";
    request.fields['billing_state'] = "${widget.billingState}";
    request.fields['billing_country'] = "${widget.billingCountry}";

    print('usersId: $userId');
    print('carsId: $carID');
    print('planDate: ${widget.myDate}');
    print('startTime: ${widget.selectedStartTime}');
    print('endTime: ${widget.selectedEndTime}');
    print('totalCost: ${widget.totalAmount}');
    print('totalHours: ${widget.totalHoursInNumber}');
    print('pricePerHour: ${widget.carDiscountPrice}');
    print('discountPercentage: ${widget.discountPercentage}');
    print("homeAddress: ${widget.homeAddress1} ${widget.homeAddress2}");
    print("addressAvailableStatus $addressAvailableStatus");
    print("homePostCity: ${widget.homeCity} ${widget.homePostCode}");
    print("homeState: ${widget.homeState} ${widget.homeCountry}");
    print("billingAddress: ${widget.billingAddress1} ${widget.billingAddress2}");
    print("billingPostCity: ${widget.billingCity} ${widget.billingPostCode}");
    print("billingState: ${widget.billingState} ${widget.billingCountry}");
    print('licenseImage: ${image!.path.split('/').last}');

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
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    final resJson = jsonDecode(response.body);
    print("jsonResponseCheckOutApi $resJson");
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySelectedData();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: homeBgColor,
      appBar: MyAppBarSingleImage(
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
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Container(
                height: MediaQuery.of(context).size.height * 0.84,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(
                      top: 70, left: 0, right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.72,
                          width: MediaQuery.of(context).size.width * 0.47,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                                Row(
                                  children: [
                                    Text("${widget.carName} ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                                    Text("${widget.carColorName}", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${widget.carMakesName} ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                    Text("${widget.carModelName} ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack, fontSize: 14, fontFamily: poppinRegular)),
                                    Text("${widget.carYear} ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 04),
                                      child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                              color: kRed, fontSize: 5, fontFamily: poppinLight)),
                                    ),
                                    Text("${widget.carPrice}",
                                      textAlign: TextAlign.left, style: TextStyle(
                                          color: kRed, decoration: TextDecoration.lineThrough,
                                          fontSize: 10, fontFamily: poppinLight)),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Padding(
                                      padding: EdgeInsets.only(top: 06),
                                      child: Text("RM ", textAlign: TextAlign.left, style: TextStyle(
                                              color: borderColor, fontSize: 7, fontFamily: poppinSemiBold)),
                                    ),
                                    Text("${widget.carDiscountPrice}",
                                        textAlign: TextAlign.left, style: TextStyle(
                                            color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
                                    Text("/hour", textAlign: TextAlign.left, style: TextStyle(
                                          color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                        showRatingStars(double.parse("${widget.carRating}")),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                        widget.carRating == null
                                            ? Text("0.0", textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 12, fontFamily: poppinRegular))
                                            : Text("${widget.carRating}", textAlign: TextAlign.left,
                                            style: TextStyle(color: kBlack, fontSize: 12, fontFamily: poppinRegular))
                                      ],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.height * 0.1),
                                    Container(
                                      height: 25, width: 80,
                                      decoration: BoxDecoration(
                                          color: kBlack,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text("Pre book", textAlign: TextAlign.left, style: TextStyle(
                                                color: kWhite, fontSize: 12, fontFamily: poppinMedium)),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 05),
                                  child: Divider(),
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${widget.selectedHours} Plan",
                                        textAlign: TextAlign.left, style: TextStyle(
                                            color: textLabelColor, fontSize: 14, fontFamily: poppinRegular)),
                                    Text("RM ${widget.hoursAmount}", textAlign: TextAlign.right, style: TextStyle(
                                            color: textLabelColor, fontSize: 14, fontFamily: poppinRegular)),
                                  ],
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Service Fee (6%)", textAlign: TextAlign.left, style: TextStyle(
                                           color: textLabelColor, fontSize: 14, fontFamily: poppinRegular)),
                                    Text("RM ${myServiceFee!.toStringAsFixed(2)}", textAlign: TextAlign.right, style: TextStyle(
                                            color: textLabelColor, fontSize: 14, fontFamily: poppinRegular)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Fee", textAlign: TextAlign.left, style: TextStyle(
                                        color: kBlack, fontSize: 16, fontFamily: poppinSemiBold)),
                                    Text("RM ${widget.totalAmount}", textAlign: TextAlign.right, style: TextStyle(
                                            color: kBlack, fontSize: 16, fontFamily: poppinSemiBold)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Text("Add your license image", textAlign: TextAlign.right, style: TextStyle(
                                        color: textLabelColor, fontSize: 14, fontFamily: poppinRegular)),
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
                                                border: Border.all(
                                                    color: kWhite, width: 3)),
                                            child: CircleAvatar(
                                              radius: (screenWidth > 600) ? 90 : 70,
                                              backgroundColor: Colors.transparent,
                                              backgroundImage: image == null
                                                  ? AssetImage("assets/icon/fade_in_image.jpeg",)
                                                  : Image.file(image!, height: 50, width: 50,
                                                      fit: BoxFit.contain).image)),
                                          Positioned(
                                            right: 0,
                                            bottom: 18,
                                            child: GestureDetector(
                                                onTap: () {
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
                                  child: Text("*A security deposit may be applicable, depending on your eligibility assessment.",
                                      textAlign: TextAlign.left, style: TextStyle(
                                          fontSize: 12, fontFamily: poppinRegular, color: borderColor)),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                // Center(
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       // Navigator.pushReplacement(
                                //       //     context,
                                //       //     MaterialPageRoute(
                                //       //         builder: (context) =>
                                //       //             BookForWeddingBookingDetails(
                                //       //               // carName: widget.carName,
                                //       //               // carYear: widget.carYear,
                                //       //               selectedStartTime: widget
                                //       //                   .selectedStartTime,
                                //       //               selectedEndTime:
                                //       //                   widget.selectedEndTime,
                                //       //               selectedHours:
                                //       //                   widget.selectedHours,
                                //       //               hoursInNumber: widget
                                //       //                   .totalHoursInNumber,
                                //       //               selectedDate: widget.myDate,
                                //       //               selectedDay: widget.myDay,
                                //       //             )));
                                //     },
                                //     child: Container(
                                //       height: MediaQuery.of(context).size.height * 0.03,
                                //       width: MediaQuery.of(context).size.width * 0.3,
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(20),
                                //           border: Border.all(color: borderColor)),
                                //       child: Center(
                                //           child: Text("Edit", textAlign: TextAlign.center, style: TextStyle(
                                //                   fontSize: 12, fontFamily: poppinRegular, color: borderColor))),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40, left: 40, right: 20,
                      child: Image.network("${widget.carImage}",
                        height: 130,width: 350,),
                    ),
                    Positioned(
                        top: 0, left: 20,
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.07,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.discountPercentage}% ", textAlign: TextAlign.left,
                                  style: TextStyle(color: kWhite, fontSize: 12, fontFamily: poppinSemiBold)),
                              Padding(
                                padding: EdgeInsets.only(top: 03),
                                child: Text("OFF ", textAlign: TextAlign.left, style: TextStyle(
                                        color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
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
                    // bottomSheetWidget(context);

                    if (formKeyCheckOut.currentState!.validate()) {
                      setState(() {
                        isInAsyncCall = true;
                      });

                      if (image == null) {
                        toastFailedMessage("image error", kRed);
                        setState(() {
                          isInAsyncCall = false;
                        });
                      }
                      await checkOutWidget();
                      Future.delayed(Duration(seconds: 3), () {
                        // toastSuccessMessage("successfully", Colors.green);

                        Navigator.push(context, MaterialPageRoute(
                                builder: (context) => TabBarPage()));
                        setState(() {
                          isInAsyncCall = false;
                        });
                        print("false: $isInAsyncCall");
                      });
                    }
                  },
                  child: loginButton("Check out", context)),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
