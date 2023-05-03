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
import 'package:auto_haus_rental_app/Model/CheckOutModels/ev_checkout_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';

class EvCartDetailsPage extends StatefulWidget {
  final String? mySelectedTabMonth, mySelectedTabPrice;
  final double? totalAmount;
  final String? carName, carImage, carYear, carPrice, carStatus,favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage, carRating, carOwnerImage,
      carOwnerName, discountPercentage, evStartDate, evEndDate;

 final String? homeAddress1, homeAddress2, homeCity, homePostCode, homeState, homeCountry,
  billingAddress1, billingAddress2, billingCity, billingPostCode, billingState, billingCountry;
  final int? carId, carOwnerId;
  final double? carDiscountPrice;

  EvCartDetailsPage({Key? key, this.totalAmount, this.carName, this.evStartDate, this.evEndDate,
    this.carColorName, this.carModelName, this.discountPercentage, this.carDiscountPrice,
    this.carImage, this.carYear, this.carMakesImage, this.carStatus, this.carMakesName,
    this.carId, this.carPrice, this.carRating, this.carOwnerId, this.carOwnerImage, this.carOwnerName,
    this.mySelectedTabMonth, this.mySelectedTabPrice, this.favouriteStatus,
  this.homeAddress1, this.homeAddress2, this.homeCity, this.homePostCode, this.homeState,
    this.homeCountry, this.billingAddress1, this.billingAddress2, this.billingCity,
    this.billingPostCode, this.billingState, this.billingCountry}) : super(key: key);

  @override
  State<EvCartDetailsPage> createState() => _EvCartDetailsPageState();
}

class _EvCartDetailsPageState extends State<EvCartDetailsPage> {
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

  String? addressAvailableStatus;

  EvCheckOutModel evCheckOutModelObject = EvCheckOutModel();
  bool loader = false;

  checkOutWidget() async {
    setState(() {
      loader = true;
    });
    var request = http.MultipartRequest('POST', Uri.parse(checkOutDrivingApiUrl));

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Cookie': cookieCheckOutDrivingApi,
    };
    print("apiRequest: $request");
    request.fields['users_customers_id'] = '$userId';
    request.fields['cars_id'] = '$carID';
    request.fields['plan_start_date'] = widget.evStartDate!;
    request.fields['plan_end_date'] = widget.evEndDate!;
    request.fields['months'] = "$myMonth";
    request.fields['price_per_month'] = "$myDiscountedAmount";
    request.fields['discount_percentage'] = "${widget.discountPercentage}";
    request.fields['total_cost'] = "$myTotalAmount";
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
    print('plan_start_date: ${widget.evStartDate}');
    print('plan_end_date: ${widget.evEndDate}');
    print('months: $myMonth');
    print('totalCost: $myTotalAmount');
    print('pricePerHour: $myDiscountedAmount');
    print('discountPercentage: ${widget.discountPercentage}');
    print("homeAddress: ${widget.homeAddress1} ${widget.homeAddress2}");
    print("addressAvailableStatus $addressAvailableStatus");
    print("homePostCity: ${widget.homeCity} ${widget.homePostCode}");
    print("homeState: ${widget.homeState} ${widget.homeCountry}");
    print("billingAddress: ${widget.billingAddress1} ${widget.billingAddress2}");
    print("billingPostCity: ${widget.billingCity} ${widget.billingPostCode}");
    print("billingState: ${widget.billingState} ${widget.billingCountry}");
    print('licenseImage: ${image!.path.split('/').last}');

    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    final resJson = jsonDecode(response.body);
    print("jsonResponseCheckOutApi $resJson");
    setState(() {
      loader = false;
    });

  }
  String? myMonth, myDiscountedAmount;
  double? myTotalAmount;
  String? myHomeAddress1, myHomeAddress2, myHomeCity, myHomePostCode, myHomeState, myHomeCountry;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMonth = widget.mySelectedTabMonth;
    myDiscountedAmount = widget.mySelectedTabPrice;
    myTotalAmount = widget.totalAmount;
    mySelectedData();
  }
  mySelectedData(){
    print("userId carId: $userId $carID");
    print("selectedTabMonth123: $myMonth");
    print("evTotalPrice: $myTotalAmount");
    print('evStartEndDate: ${widget.evStartDate} ${widget.evEndDate}');
    print("pricePerMonth: $myDiscountedAmount");
    print("carDiscountPercentage: ${widget.discountPercentage}");
    print("homeAddress: ${widget.homeAddress1} ${widget.homeAddress2}");
    print("homePostCity: ${widget.homeCity} ${widget.homePostCode}");
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
                height: MediaQuery.of(context).size.height * 0.85,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.74,
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
                                      style: TextStyle(color: kBlack,
                                        fontSize: 14, fontFamily: poppinBold)),

                                    Text("${widget.carColorName}", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack,
                                            fontSize: 12, fontFamily: poppinRegular)),
                                  ],
                                ),
                                Row(
                                  children: [

                                    Text("${widget.carMakesName}, ", textAlign: TextAlign.left,
                                      style: TextStyle(color: kBlack,
                                        fontSize: 12, fontFamily: poppinRegular)),
                                    Text("${widget.carModelName}, ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack,
                                            fontSize: 12, fontFamily: poppinSemiBold)),
                                    Text("${widget.carYear} ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack,
                                            fontSize: 12, fontFamily: poppinRegular)),

                                  ],
                                ),
                                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 04),
                                      child: Text("RM ", textAlign: TextAlign.left,
                                        style: TextStyle(color: kRed,
                                            fontSize: 5, fontFamily: poppinLight)),
                                    ),
                                    Text("${widget.carPrice}", textAlign: TextAlign.left,
                                      style: TextStyle(color: kRed,
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 10, fontFamily: poppinLight),
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                                    Padding(
                                      padding: EdgeInsets.only(top: 06),
                                      child: Text("RM ", textAlign: TextAlign.left,
                                        style: TextStyle(color: borderColor,
                                            fontSize: 7, fontFamily: poppinSemiBold)),
                                    ),
                                    Text("${widget.carDiscountPrice}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: borderColor,
                                          fontSize: 20, fontFamily: poppinSemiBold)),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text("/month", textAlign: TextAlign.left,
                                        style: TextStyle(color: kBlack,
                                            fontSize: 8, fontFamily: poppinRegular),
                                      ),
                                    ),
                                  ],
                                ),

                                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                        showRatingStars(double.parse("${widget.carRating}")),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.height * 0.01),

                                        widget.carRating == null?
                                        Text("0.0", textAlign: TextAlign.left,
                                          style: TextStyle(color: kBlack,
                                              fontSize: 12, fontFamily: poppinRegular)):
                                        Text("${widget.carRating}", textAlign: TextAlign.left,
                                            style: TextStyle(color: kBlack,
                                                fontSize: 12, fontFamily: poppinRegular))
                                      ],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.height * 0.1),
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
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 05),
                                  child: Divider(),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("$myMonth month Plan", textAlign: TextAlign.left,
                                      style: TextStyle(color: textLabelColor,
                                          fontSize: 14, fontFamily: poppinRegular)),
                                    Text("RM $myDiscountedAmount", textAlign: TextAlign.right,
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
                                    Text("RM $myTotalAmount", textAlign: TextAlign.right,
                                      style: TextStyle(color: kBlack,
                                          fontSize: 16, fontFamily: poppinSemiBold)),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Text("Add your driving license image",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: textLabelColor,
                                        fontSize: 14, fontFamily: poppinRegular)),

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
                                              AssetImage("assets/icon/fade_in_image.jpeg",)
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
                      left: 30, right: 20, top: 30,
                      child: Image.network("${widget.carImage}",
                        width: 350,
                        height: 130,),
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
                                style: TextStyle(color: kWhite,
                                    fontSize: 12, fontFamily: poppinSemiBold)),
                              Padding(
                                padding: EdgeInsets.only(top: 03),
                                child: Text("OFF ", textAlign: TextAlign.left,
                                    style: TextStyle(color: kWhite,
                                        fontSize: 8, fontFamily: poppinRegular)),
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                        top: 0, right: 20,
                        child: widget.favouriteStatus == 'like'?
                        Image.asset("assets/home_page/heart.png") :
                        Image.asset("assets/car_bookings_images/heart.png"),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () async {
                    // bottomSheetWidget(context);

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

                      // if (evCheckOutModelObject.status == "success") {
                      //   print("booking Success");
                      //   Future.delayed(Duration(seconds: 3), () {
                      //     // toastSuccessMessage("CheckOut Successful ", Colors.green);
                      //
                      //     Navigator.push(context, MaterialPageRoute(
                      //         builder: (context) => TabBarPage()));
                      //     setState(() {
                      //       isInAsyncCall = false;
                      //     });
                      //     print("false: $isInAsyncCall");
                      //   });
                      // }
                      // // if (evCheckOutModelObject.status != "success") {
                      // //   setState(() {
                      // //     isInAsyncCall = false;
                      // //   });
                      // //   print("bookingErrorMessage: bookingError");
                      // //   toastFailedMessage("${evCheckOutModelObject.status}", kRed);
                      // // }


                        Future.delayed(Duration(seconds: 3), () {

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
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
