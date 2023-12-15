import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:auto_haus_rental_app/Model/car_ratings_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:auto_haus_rental_app/Model/get_rate_cars_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';

import '../../../../../tab_page.dart';

class PreviousBookingDetailsPage extends StatefulWidget {
  final String? myStatus;
  final String? bookingId;

  PreviousBookingDetailsPage({super.key, this.bookingId, this.myStatus});

  @override
  State<PreviousBookingDetailsPage> createState() =>
      _PreviousBookingDetailsPageState();
}

class _PreviousBookingDetailsPageState
    extends State<PreviousBookingDetailsPage> {
  double? ratingValue;
  var carRatingController = TextEditingController();
  final GlobalKey<FormState> ratingsFormKey = GlobalKey<FormState>();
  RateCarModel rateCarModelObject = RateCarModel();
  GetStatusRateCarsModel getRateCarsModel = GetStatusRateCarsModel();
  bool loadingP = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRateCarWidget();
    print("bookingCompleteStatus ${widget.myStatus}");
    print("bookingCarId ${carID}");
    print("bookingPrintApiUrl $bookingPrintApiUrl${widget.bookingId}");
  }

  getRateCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    // print('in getRateCarApi');
    print('userId in getRateCarApi $userId ${carID}');

    // try {
    String apiUrl = getRateCarApiUrl;
    print("getRateCarApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "users_customers_id": userId,
      "cars_id": "${carID}",
    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responseGetRateCar: ${responseString.toString()}");
      loadingP = false;
      setState(() {});
      getRateCarsModel = getStatusRateCarsModelFromJson(responseString);
      print("getRateCarApiMessage: ${getRateCarsModel.message}");
    }
  }

  bool _isLoading = true;
  bool isInAsyncCall = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarSingleImage(
          backImage: "assets/car_bookings_images/back_arrow.png",
          title: "Bookings"),
      backgroundColor: homeBgColor,
      body: ModalProgressHUD(
        inAsyncCall: isInAsyncCall,
        opacity: 0.02,
        blur: 0.5,
        color: Colors.transparent,
        progressIndicator: CircularProgressIndicator(
          color: borderColor,
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(
                      // url: Uri.parse("https://app.autohauscarrental.com/api/bookings_print/${widget.bookingId}"),
                      url: Uri.parse("$bookingPrintApiUrl${widget.bookingId}"),
                    ),
                    onLoadStart: (controller, url) {
                      setState(() {
                        _isLoading = true;
                      });
                    },
                    onLoadStop: (controller, url) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
                  ),
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: borderColor,
                      ),
                    ),
                ],
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: widget.myStatus == "Completed" ?
            //     Container(
            //       height: 0,
            //       color: Colors.transparent,
            //       child: GestureDetector(
            //           onTap: () {
            //             if(getRateCarsModel.message == "Rating already given"){
            //               toastSuccessMessage("${getRateCarsModel.message}", kRed);
            //             }
            //             else{
            //               ratingsDialogBox(context);
            //             }
            //           },
            //           child: loginButton('Give Ratings', context)),
            //     ): GestureDetector(
            //         onTap: () {
            //             toastSuccessMessage("You can give rating once status is completed.", kRed);
            //         },
            //         child: loginButton('Give Ratings', context))
            //   ),
            // ),


            // Expanded(
            //   flex: 1,
            //   child: Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: widget.myStatus == "Completed"
            //           ? Container(
            //               height: 0,
            //               color: Colors.transparent,
            //               child: getRateCarsModel.message ==
            //                       "Rating already given"
            //                   ? loginButton('Rated', context)
            //                   : GestureDetector(
            //                       onTap: () {
            //                         ratingsDialogBox(context);
            //                       },
            //                       child: loginButton('Give Ratings', context)),
            //             )
            //           : GestureDetector(
            //               onTap: () {
            //                 toastSuccessMessage(
            //                     "You can give rating once status is completed.",
            //                     kRed);
            //               },
            //               child: loginButton('Give Ratings', context))),
            // ),
          ],
        ),
      ),
    );
  }

  carRatingsWidget() async {
    loadingP = true;
    setState(() {});
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in rateCarApi');
    // try {
    String apiUrl = carsRatingApiUrl;
    print("rateCarModelApi: $apiUrl");
    print("userId: $userId");
    print("carId: ${carID}");
    print("carRatingController: ${carRatingController.text}");
    print("ratingValue: $ratingValue");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "users_customers_id": userId,
      "cars_id": "${carID}",
      "comments": carRatingController.text,
      "rate_stars": "$ratingValue"
    });
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responseCarRatings: ${responseString.toString()}");
      loadingP = false;
      setState(() {});
      rateCarModelObject = rateCarModelFromJson(responseString);
    }
  }

  void ratingsDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xffb0b0b0),
            child: Container(
              color: Color(0xff0f172a).withOpacity(0.5),
              child: AlertDialog(
                backgroundColor: homeBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                              'assets/car_bookings_images/close.png'),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      Text(
                        "Ratings",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: borderColor),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        "Give your Ratings \n and Feedback",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffb0b0b0),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      RatingBar(
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          minRating: 1,
                          itemSize: 30.0,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: borderColor),
                            half: Icon(Icons.star_half, color: borderColor),
                            empty: Icon(Icons.star_outline, color: borderColor),
                          ),
                          onRatingUpdate: (value) {
                            setState(() {
                              ratingValue = value;
                              print("ratingValue $ratingValue");
                            });
                          }),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Form(
                        key: ratingsFormKey,
                        child: TextFormField(
                          cursorColor: borderColor,
                          controller: carRatingController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please add your feedback!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(150),
                          ],
                          decoration: InputDecoration(
                            hintText: "Add your feedback",
                            hintStyle: TextStyle(
                                fontSize: 16, color: Color(0xffb0b0b0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Color(0xffd4dce1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "* Maximum 150 characters",
                            style: TextStyle(
                              fontSize: 12,
                              color: borderColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: () async {
                            print("ratingValue $ratingValue");
                            if (ratingsFormKey.currentState!.validate()) {
                              // if(carRatingController.text.isEmpty){
                              //   toastFailedMessage("Please add your feedback", kRed);
                              // } else {
                              // setState(() {
                              //   isInAsyncCall = true;
                              // });
                              await carRatingsWidget();
                              if (rateCarModelObject.status == "success") {
                                // Future.delayed(Duration(seconds: 0), () {
                                  toastSuccessMessage(
                                      "${rateCarModelObject.message}",
                                      colorGreen);
                                  // Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => TabBarPage()));
                                  // setState(() {
                                  //   isInAsyncCall = false;
                                  // });
                                // });
                              }
                              if (rateCarModelObject.status != "success") {
                                Future.delayed(Duration(seconds: 2), () {
                                  toastFailedMessage(
                                      "${rateCarModelObject.message}", kRed);
                                  Navigator.pop(context);
                                  // setState(() {
                                  //   isInAsyncCall = false;
                                    print(
                                        "rateCarMessage: ${rateCarModelObject.message}");
                                  // });
                                });
                              }
                              // }
                            }
                          },
                          child: loadingP
                              ? Center(
                            child: Container(
                              height: 44,
                              width: 202,
                              decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: CircularProgressIndicator(color: Colors.blueAccent,)
                              ),
                            ),
                          )
                              :Center(
                            child: Container(
                              height: 44,
                              width: 202,
                              decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text('Okay',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 16)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
