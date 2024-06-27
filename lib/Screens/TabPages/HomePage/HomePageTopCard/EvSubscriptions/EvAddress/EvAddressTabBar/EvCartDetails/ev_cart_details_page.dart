import 'dart:io';
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/cookies_utils.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/tab_page.dart';
import 'package:auto_haus_rental_app/Model/CheckOutModels/ev_checkout_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class EvCartDetailsPage extends StatefulWidget {
  final String? mySelectedTabMonth,startDate, endDate,  mySelectedTabPrice;
  final String? totalAmount, setupCost;
  final String? carName, carImage, carYear, carPrice, carStatus,favouriteStatus,
      carColorName, carModelName, carMakesName, carMakesImage, carRating, carOwnerImage,
      carOwnerName, discountPercentage, evStartDate, evEndDate;

 final String? homeAddress1, homeAddress2, homeCity, homePostCode, homeState, homeCountry,
  billingAddress1, billingAddress2, billingCity, billingPostCode, billingState, billingCountry;
  final int? carId, carOwnerId, mileagePlanID;
  final String? carDiscountPrice;

  EvCartDetailsPage({Key? key, this.startDate, this.endDate, this.setupCost,  this.mileagePlanID, this.totalAmount, this.carName, this.evStartDate, this.evEndDate,
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
  String? base64img;

  final ImagePicker _picker = ImagePicker();
  Future pickCoverImage() async {
    try {
      final XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);
      if (xFile == null) return;

      Uint8List imageByte = await xFile.readAsBytes();
      base64img = base64.encode(imageByte);
      print("base64img $base64img");

      final imageTemporary = File(xFile.path);
      setState(() {
        image = imageTemporary;
        print("newImage $image");
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
    String? formattedTotalAmount = myTotalAmount?.replaceAll(',', '');
    String? formattedPerMonth = myDiscountedAmount?.replaceAll(',', '');
    print("Formatted total amount: $formattedTotalAmount");
    myTotalAmount = formattedTotalAmount;
    myDiscountedAmount = formattedPerMonth;
    print(myTotalAmount);

    Map<String, String> headers = {
      'Accept' : 'application/json',
      'Cookie': cookieCheckOutDrivingApi,
    };
    print("apiRequest: $request");
    request.fields['users_customers_id'] = '$userId';
    request.fields['cars_id'] = '$carID';
    request.fields['plan_start_date'] = widget.evStartDate!;
    request.fields['plans_mileage_id'] = widget.mileagePlanID.toString();
    request.fields['plan_end_date'] = widget.evEndDate!;
    request.fields['months'] = "$myMonth";
    request.fields['price_per_month'] = "$formattedPerMonth";
    request.fields['discount_percentage'] = "${widget.discountPercentage}";
    request.fields['total_cost'] = "$formattedTotalAmount";
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
    request.fields['driving_license'] =  base64img!;

    // request.files.add(
    //   http.MultipartFile(
    //     'driving_license',
    //     image!.readAsBytes().asStream(),
    //     image!.lengthSync(),
    //     filename: image!.path.split('/').last,
    //   ),
    // );

    request.headers.addAll(headers);
    print("request: $request");
    print('usersId: $userId');
    print('carsId: $carID');
    print('plan_start_date: ${widget.evStartDate}');
    print('plan_end_date: ${widget.evEndDate}');
    print('months: $myMonth');
    print('totalCost: $formattedTotalAmount');
    print('pricePerHour: $formattedPerMonth');
    print('discountPercentage: ${widget.discountPercentage}');
    print("homeAddress: ${widget.homeAddress1} ${widget.homeAddress2}");
    print("addressAvailableStatus $addressAvailableStatus");
    print("homePostCity: ${widget.homeCity} ${widget.homePostCode}");
    print("homeState: ${widget.homeState} ${widget.homeCountry}");
    print("billingAddress: ${widget.billingAddress1} ${widget.billingAddress2}");
    print("billingPostCity: ${widget.billingCity} ${widget.billingPostCode}");
    print("billingState: ${widget.billingState} ${widget.billingCountry}");
    print('licenseImage: ${base64img}');

    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
    final resJson = jsonDecode(response.body);
    print("jsonResponseCheckOutApi $resJson");
    setState(() {
      loader = false;
    });

  }
  String? myMonth, myDiscountedAmount;
  String? myTotalAmount;
  String? myHomeAddress1, myHomeAddress2, myHomeCity, myHomePostCode, myHomeState, myHomeCountry;

  String Keys = "";
  Future<Map<String, String>> fetchStripeKeys() async {
    final response = await http.get(Uri.parse('https://admin.autohauscarrental.com/api/get_stripe_keys'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        final List<dynamic> keys = data['data'];
        return {
          'publishableKey': keys.firstWhere((key) => key['keys_type'] == 'Publishable')['key'],
          'secretKey': keys.firstWhere((key) => key['keys_type'] == 'Secret')['key'],
        };
      } else {
        throw Exception('Failed to load Stripe keys');
      }
    } else {
      throw Exception('Failed to load Stripe keys');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("mileageID ${widget.mileagePlanID}");
    myMonth = widget.mySelectedTabMonth;
    myDiscountedAmount = widget.mySelectedTabPrice;
    myTotalAmount = widget.totalAmount;
    print("myTotalAmount $myTotalAmount");
    mySelectedData();
    initializeData();
  }

  Future<void> initializeData() async {
    final stripeKeys = await fetchStripeKeys();
    Keys =  stripeKeys['secretKey']!;
    print("stripeKeys $Keys");
  }
  String? formattedFeeService;
  mySelectedData(){
    print("userId carId: $userId $carID");
    print("selectedTabMonth123: $myMonth");
    print("evTotalPrice: $myTotalAmount");
    print('evStartEndDate: ${widget.evStartDate} ${widget.evEndDate}');
    print("pricePerMonth: $myDiscountedAmount");
    double serviceFeeAsDouble = double.parse(myServiceFee.toString());
    NumberFormat format = NumberFormat('#,##0.00', 'en_US');
    formattedFeeService = format.format(serviceFeeAsDouble);
    // myServiceFee = double.parse(formattedFeeService);
    print("myServiceFee $formattedFeeService");
    print("myServiceFee: $myServiceFee");
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
        inAsyncCall: loader,
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
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                height: MediaQuery.of(context).size.height * 0.83,
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
                          height: MediaQuery.of(context).size.height * 0.75,
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
                                // Row(
                                //   children: [
                                //
                                //     Text("${widget.carMakesName}, ", textAlign: TextAlign.left,
                                //       style: TextStyle(color: kBlack,
                                //         fontSize: 12, fontFamily: poppinRegular)),
                                //     Text("${widget.carModelName}, ", textAlign: TextAlign.left,
                                //         style: TextStyle(color: kBlack,
                                //             fontSize: 12, fontFamily: poppinSemiBold)),
                                //     Text("${widget.carYear} ", textAlign: TextAlign.left,
                                //         style: TextStyle(color: kBlack,
                                //             fontSize: 12, fontFamily: poppinRegular)),
                                //
                                //   ],
                                // ),
                                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    widget.discountPercentage != "0.00"
                                    ? Row(
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
                                      ],
                                    )
                                    : SizedBox(),
                                  ],
                                ),
                                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                    //     showRatingStars(double.parse("${widget.carRating}")),
                                    //     SizedBox(
                                    //       width: MediaQuery.of(context).size.height * 0.01),
                                    //
                                    //     widget.carRating == null?
                                    //     Text("0.0", textAlign: TextAlign.left,
                                    //       style: TextStyle(color: kBlack,
                                    //           fontSize: 12, fontFamily: poppinRegular)):
                                    //     Text("${widget.carRating}", textAlign: TextAlign.left,
                                    //         style: TextStyle(color: kBlack,
                                    //             fontSize: 12, fontFamily: poppinRegular))
                                    //   ],
                                    // ),
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
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.33),
                                      child: Text("Start Date", textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: kBlack,
                                            fontSize: 14,
                                            fontFamily: poppinSemiBold,
                                        ),
                                      ),
                                    ),
                                    Text("End Date", textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: kBlack,
                                          fontSize: 14,
                                          fontFamily: poppinSemiBold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: borderColor,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "${widget.evStartDate}",
                                          style: TextStyle(color: kWhite, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "to",
                                      style: TextStyle(color: kBlack, fontSize: 16),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: borderColor,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          "${widget.evEndDate}",
                                          style: TextStyle(color: kWhite, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 05),
                                  child: Divider(),
                                ),
                                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("End Date", textAlign: TextAlign.left,
                                //       style: TextStyle(color: textLabelColor,
                                //           fontSize: 14, fontFamily: poppinRegular)),
                                //     Text("${widget.endDate}", textAlign: TextAlign.right,
                                //       style: TextStyle(color: textLabelColor,
                                //           fontSize: 14, fontFamily: poppinRegular)),
                                //   ],
                                // ),
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
                                    Text("Service Fee (8%)",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: textLabelColor,
                                          fontSize: 14, fontFamily: poppinRegular)),
                                    Text("RM ${formattedFeeService}", textAlign: TextAlign.right,
                                      style: TextStyle(color: textLabelColor,
                                          fontSize: 14, fontFamily: poppinRegular)),
                                  ],
                                ),
                                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("Setup Cost",
                                //         textAlign: TextAlign.left,
                                //         style: TextStyle(color: textLabelColor,
                                //             fontSize: 14, fontFamily: poppinRegular)),
                                //     Text("RM ${widget.setupCost}", textAlign: TextAlign.right,
                                //         style: TextStyle(color: textLabelColor,
                                //             fontSize: 14, fontFamily: poppinRegular)),
                                //   ],
                                // ),
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
                                // Center(
                                //   child: GestureDetector(
                                //     onTap: (){
                                //       // Navigator.pushReplacement(context, MaterialPageRoute(
                                //       //     builder: (context) => BookForWeddingBookingDetails(
                                //       //       carName: widget.carName,
                                //       //       carYear: widget.carYear,
                                //       //       selectedStartTime: widget.selectedStartTime,
                                //       //       selectedEndTime: widget.selectedEndTime,
                                //       //       selectedHours: widget.selectedHours,
                                //       //       hours: widget.totalHoursInNumber,
                                //       //       selectedDate: widget.myDate,
                                //       //       selectedDay: widget.myDay,)));
                                //     },
                                //     child: Container(
                                //       height: MediaQuery.of(context).size.height*0.03,
                                //       width: MediaQuery.of(context).size.width *0.3,
                                //       decoration: BoxDecoration(
                                //           borderRadius: BorderRadius.circular(20),
                                //           border: Border.all(color: borderColor)),
                                //       child: Center(
                                //           child: Text("Edit", textAlign: TextAlign.center,
                                //               style: TextStyle(fontSize: 12,
                                //                   fontFamily: poppinRegular, color: borderColor))),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: 30, right: 20, top: 30,
                    //   child: Image.network("${widget.carImage}",
                    //     width: 350,
                    //     height: 130,),
                    // ),
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 0,
                      // top: widget.carImage!.endsWith('.jpg') || widget.carImage!.endsWith('.png') || widget.carImage!.endsWith('.jpeg')
                      //     ? 20
                      //     : -50,
                      child: widget.carImage!.endsWith('.jpg') || widget.carImage!.endsWith('.png') || widget.carImage!.endsWith('.jpeg')
                          ?  Image.network("${widget.carImage}",
                        // fit: BoxFit.contain,
                        // height: 200, width: 200,
                      ) :
                      Container(
                        height: 200,
                        child: ModelViewer(
                          backgroundColor: Colors.transparent,
                          // src: '$baseUrlImage${topRentedCarsModelObject.data?[index].image1}',
                          src: '${widget.carImage}',
                          alt: "A 3D model of car",
                          autoPlay: false,
                          autoRotate: false,
                          cameraControls: false,
                          disableTap: false,
                          ar: false,
                          disablePan: true,
                          arModes: ["quicklook", "scene-viewer"],
                          iosSrc: '${widget.carImage}',
                          disableZoom: true,
                        ),
                      ),
                    ),
                    widget.discountPercentage != "0.00"
                        ? Positioned(
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
                        ))
                    : Positioned( top: 0, left: 20, child: SizedBox()),
                    // Positioned(
                    //     top: 0, right: 20,
                    //     child: widget.favouriteStatus == 'like'?
                    //     Image.asset("assets/home_page/heart.png") :
                    //     Image.asset("assets/car_bookings_images/heart.png"),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                  onTap: () async {
                    if(formKeyCheckOut.currentState!.validate()){
                      // setState(() {
                      //   isInAsyncCall = true;
                      // });
                      if(image == null){
                        toastFailedMessage("Insert Your Driving License Photo", kRed);
                        // setState(() {
                        //   isInAsyncCall = false;
                        // });
                      } else{
                        print("stripeKeys $Keys");
                        await makePayment();

                      }
                    }
                  },
                  child: loginButton("Prebook Now", context)),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic>? paymentIntent;
  String? tokenStripe;
  int totalAmount = 1000;

  void showSuccessDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),),
              child: Container(
                decoration: BoxDecoration(
                    color: homeBgColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text("Payment Successful Check Your Email",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kBlack,
                              fontSize: 20, fontFamily: poppinMedium)),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => TabBarPage(),),);
                          },
                          child: dialogButtonGradientSmall("OK", context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      );
  }

  void showFailedDialog(String message,) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),),
              child: Container(
                decoration: BoxDecoration(
                    color: homeBgColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_alert,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text(message,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: kBlack,
                              fontSize: 20, fontFamily: poppinMedium,),),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => TabBarPage(),),);
                          },
                          child: dialogButtonGradientSmall("OK", context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
      );
  }

  Widget dialogButtonGradientSmall(buttonText, context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kWhite,
              fontSize: 16,
              fontFamily: 'Syne-Medium',
            ),
          ),
        ),
      ),
    );
  }

  String calculateAmount(String? amount) {
    int parsedAmount = int.parse(amount?.replaceAll(',', '') ?? "0");

    int parsedTotalAmount = totalAmount;

    int result = (parsedAmount * parsedTotalAmount).toInt();

    return result.toString();
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
          'Bearer $Keys',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      var decoded = json.decode(response.body);
      print('response api: ${decoded["id"]}');
      print('response api: ${decoded["amount"]}');

      tokenStripe = decoded["id"];
      print('tokenStripe $tokenStripe');


      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      var response1 = await Stripe.instance.presentPaymentSheet().then(
            (value) async {
              setState(() {
                loader = true;
              });
              var request = http.MultipartRequest('POST', Uri.parse(checkOutDrivingApiUrl));
              String? formattedTotalAmount = myTotalAmount?.replaceAll(',', '');
              String? formattedPerMonth = myDiscountedAmount?.replaceAll(',', '');
              print("Formatted total amount: $formattedTotalAmount");
              myTotalAmount = formattedTotalAmount;
              myDiscountedAmount = formattedPerMonth;
              print(myTotalAmount);

              Map<String, String> headers = {
                'Accept' : 'application/json',
                'Cookie': cookieCheckOutDrivingApi,
              };
              print("apiRequest: $request");
              request.fields['users_customers_id'] = '$userId';
              request.fields['cars_id'] = '$carID';
              request.fields['stripe_id'] = '$tokenStripe';
              request.fields['plan_start_date'] = widget.evStartDate!;
              request.fields['plans_mileage_id'] = widget.mileagePlanID.toString();
              request.fields['plan_end_date'] = widget.evEndDate!;
              request.fields['months'] = "$myMonth";
              request.fields['price_per_month'] = "$formattedPerMonth";
              request.fields['discount_percentage'] = "${widget.discountPercentage}";
              request.fields['total_cost'] = "$formattedTotalAmount";
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
              request.fields['driving_license'] =  base64img!;

              request.headers.addAll(headers);
              print("request: $request");
              print('usersId: $userId');
              print('usersId: $userId');
              print('tokenStripe: $tokenStripe');
              print('plan_start_date: ${widget.evStartDate}');
              print('plan_end_date: ${widget.evEndDate}');
              print('months: $myMonth');
              print('totalCost: $formattedTotalAmount');
              print('pricePerHour: $formattedPerMonth');
              print('discountPercentage: ${widget.discountPercentage}');
              print("homeAddress: ${widget.homeAddress1} ${widget.homeAddress2}");
              print("addressAvailableStatus $addressAvailableStatus");
              print("homePostCity: ${widget.homeCity} ${widget.homePostCode}");
              print("homeState: ${widget.homeState} ${widget.homeCountry}");
              print("billingAddress: ${widget.billingAddress1} ${widget.billingAddress2}");
              print("billingPostCity: ${widget.billingCity} ${widget.billingPostCode}");
              print("billingState: ${widget.billingState} ${widget.billingCountry}");
              print('licenseImage: ${base64img}');

              var res = await request.send();
              http.Response response = await http.Response.fromStream(res);
              final resJson = jsonDecode(response.body);
              print("jsonResponseCheckOutApi $resJson");
              if(resJson['status'] == "success"){
                showSuccessDialog();
                setState(() {
                  loader = false;
                });
              } else {
                showFailedDialog("Payment Unsuccessful Check Your Email");
                setState(() {
                  loader = false;
                });
              }
            }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('100', 'MYR');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "RM", currencyCode: "RM", testEnv: true);
      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: 'Hammad',
              googlePay: gpay))
          .then((value) {});
      displayPaymentSheet();
    } catch (stripeException) {
      print('Stripe Exception: $stripeException');
      // showFailedDialog("Stripe Exception: Payment Unsuccessful");
    }
  }

}
