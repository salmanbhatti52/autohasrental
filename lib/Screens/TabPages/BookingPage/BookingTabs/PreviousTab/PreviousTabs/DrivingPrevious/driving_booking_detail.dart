import 'package:auto_haus_rental_app/Model/car_ratings_model.dart';
import 'package:auto_haus_rental_app/Model/get_rate_cars_model.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/button.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'DrivingTabs/driving_booking_tabbar.dart';

class DrivingBookingDetail extends StatefulWidget {
  final String? carName, carModel, carPrice, carRating, carColors,
      carId, carYear, carMakes, carImage, discountPercentage, carDesc, carMonths,
      userRating, userComment;

  const DrivingBookingDetail({super.key, this.carName, this.carModel, this.carId,
    this.carYear, this.carImage, this.carMakes, this.discountPercentage,
    this.carColors, this.carPrice, this.carRating, this.carDesc, this.carMonths,
  this.userRating, this.userComment});

  @override
  State<DrivingBookingDetail> createState() => _DrivingBookingDetailState();
}

class _DrivingBookingDetailState extends State<DrivingBookingDetail> {
  double? ratingValue;
  var carRatingController = TextEditingController();
  final GlobalKey<FormState> ratingsFormKey = GlobalKey<FormState>();
  RateCarModel rateCarModelObject = RateCarModel();
  GetStatusRateCarsModel getRateCarsModel = GetStatusRateCarsModel();
  bool loadingP = true;

  @override
  void initState() {
    // TODO: implement initState
    getRateCarWidget();
    super.initState();
  }

  getRateCarWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    // print('in getRateCarApi');
    print('userId in getRateCarApi $userId ${widget.carId}');

    // try {
    String apiUrl = getRateCarApiUrl;
    print("getRateCarApi: $apiUrl");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    },
        body: {
      "users_customers_id": userId,
      "cars_id": widget.carId,
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
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarSingleImage(
          backImage: "assets/car_bookings_images/back_arrow.png",
          title: "Bookings"),
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
                Positioned(
                  top: 90,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: 343,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            color: Colors.transparent,
                            child: const Padding(
                              padding: EdgeInsets.only(top: 40, right: 20),
                              child: Align(
                                alignment: Alignment.centerRight,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${widget.carName} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 14, fontFamily: poppinBold)),
                                        Text("${widget.carColors}",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 10, fontFamily: poppinRegular)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Row(
                                      children: [

                                        Text("${widget.carModel} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                        Text("${widget.carMakes} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 14, fontFamily: poppinMedium)),
                                        Text("${widget.carYear} ",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 06),
                                          child: Text("RM", textAlign: TextAlign.left,
                                              style: TextStyle(color: borderColor,
                                                  fontSize: 7, fontFamily: poppinSemiBold)),
                                        ),
                                        Text("${widget.carPrice}",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: borderColor, fontSize: 20, fontFamily: poppinSemiBold)),
                                        Text("/Slot", textAlign: TextAlign.left, style: TextStyle(
                                            color: kBlack, fontSize: 8, fontFamily: poppinRegular)),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),
                                        showRatingStars(double.parse("${widget.userRating}")),
                                        SizedBox(width: MediaQuery.of(context).size.height * 0.01),

                                        widget.userRating == null?
                                        Text("0.0", textAlign: TextAlign.left,
                                            style: TextStyle(color: kBlack,
                                                fontSize: 12, fontFamily: poppinRegular)):
                                        Text("${widget.userRating}",
                                            textAlign: TextAlign.left, style: TextStyle(
                                                color: kBlack, fontSize: 12, fontFamily: poppinRegular)),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Row(
                                      children: [
                                        Image.asset("assets/car_bookings_images/promoted.png"),
                                        const SizedBox(width: 5,),
                                        Text("Verified Dealer", textAlign: TextAlign.left,
                                            style: TextStyle(color: textLabelColor,
                                              fontSize: 10, fontFamily: poppinRegular,)),
                                        const SizedBox(width: 05,),
                                        Container(
                                          height: 15, width: 35,
                                          decoration: BoxDecoration(color: kBlack,
                                              borderRadius: BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text("New", textAlign: TextAlign.left, style: TextStyle(
                                                color: kWhite, fontSize: 8, fontFamily: poppinRegular)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  child: CachedNetworkImage(
                      imageUrl: "${widget.carImage}",
                      // placeholder: (context, url) => CircularProgressIndicator(),
                      placeholder: (context, url) => Image.asset("assets/icon/fade_in_image.jpeg", height: 130,  width: 300),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      height: 130,  width: 300
                  ),

                  // Image.network("$baseUrlImage${widget.datumPrevious!.carsDetails!.image1}",
                  //     height: 130,  width: 300),
                ),
                Positioned(
                    top: 10,
                    left: 15,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.07,
                      width: MediaQuery.of(context).size.width * 0.16,
                      decoration: BoxDecoration(
                        color: kRed.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${widget.discountPercentage}",
                              style: TextStyle(color: kWhite, fontSize: 13,
                                  fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                          Text(" OFF ", style: TextStyle(color: kWhite,
                              fontSize: 8, fontWeight: FontWeight.w300, fontFamily: 'Poppins')),
                        ],
                      ),
                    )),

                Positioned(
                  top: 10,
                  right: 15,
                  child: Image.asset("assets/car_bookings_images/heart.png",),
                ),
                // Positioned(
                //   top: 135,
                //   right: 15,
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.push(context, MaterialPageRoute(
                //           builder: (context) => const DrivingExperiencePage()));
                //     },
                //     child: Container(
                //       width: 80,
                //       height: 35,
                //       decoration: BoxDecoration(
                //         color: borderColor,
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       child: Center(
                //         child: Text('Rebook', textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 fontSize: 12, fontFamily: poppinRegular, color: kWhite)),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            DrivingBookingTabbar(
              carDessc: widget.carDesc,
              userComment: widget.userComment,
              userRating: widget.userRating,

              // datumP: widget.datumP,

              // datumPrevious: widget.datumPrevious,
            ),
            GestureDetector(
                onTap: () {

                  if(getRateCarsModel.message == "Rating already given"){
                    toastSuccessMessage("${getRateCarsModel.message}", kRed);
                  }
                  else{
                    ratingsDialogBox(context);
                  }
                },
                child: loginButton('Give Ratings', context)),
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
    print("userId carId: $userId ${widget.carId}");
    print("rateCarMControllerApi: ${carRatingController.text}");
    print("ratingValue: $ratingValue");
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      "users_customers_id": userId,
      "cars_id" : "${widget.carId}",
      "comments": carRatingController.text,
      "rate_stars": "$ratingValue"

    });
    print('${response.statusCode}');
    print(response);
    if (response.statusCode == 200) {
      final responseString = response.body;
      print("responseCarRatings: ${responseString.toString()}");
      print("rateCarMessage: ${rateCarModelObject.message}");
      if(rateCarModelObject.status == "Success"){
        toastSuccessMessage("${rateCarModelObject.message}", colorGreen);
      }
      if(rateCarModelObject.status == "error"){
        toastFailedMessage("${rateCarModelObject.message}", kRed);
      }
      Navigator.pop(context);
      loadingP = false;
      setState(() {});
      rateCarModelObject = rateCarModelFromJson(responseString);

    }
    // } catch (e) {
    //   print('Error in upcomingBookingCar: ${e.toString()}');
    // }
    loadingP = false;
    setState(() {});
  }

  void ratingsDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            color: const Color(0xffb0b0b0),
            child: Container(
              color: const Color(0xff0f172a).withOpacity(0.5),
              child: AlertDialog(
                backgroundColor: homeBgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
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
                          child: Image.asset('assets/car_bookings_images/close.png'),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Text("Ratings",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: borderColor),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      const Text(
                        "Give your Ratings \n   and Feedback",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffb0b0b0),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      RatingBar(
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          minRating: 1,
                          itemSize: 30.0,
                          ratingWidget: RatingWidget(
                              full: Icon(Icons.star, color: borderColor),
                              half: Icon(
                                Icons.star_half,
                                color: borderColor,
                              ),
                              empty: Icon(
                                Icons.star_outline,
                                color: borderColor,
                              )),
                          onRatingUpdate: (value) {
                            setState(() {
                              ratingValue = value;
                              print("ratingValue $ratingValue");
                            });
                          }),

                      // Image.asset(
                      //   "assets/car_bookings_images/rating.png",
                      //   height: 30,
                      // ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Form(
                        key: ratingsFormKey,
                        child: TextField(
                          cursorColor: borderColor,
                          controller: carRatingController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Add your feedback",
                            hintStyle: const TextStyle(
                                fontSize: 16, color: Color(0xffb0b0b0)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xffd4dce1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 90),
                        child: Text(
                          "*Maximum 150 characters",
                          style: TextStyle(
                            fontSize: 12,
                            color: borderColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: GestureDetector(
                          onTap: () {

                            print("ratingValue $ratingValue");
                            if(ratingsFormKey.currentState!.validate()){
                              if(carRatingController.text.isEmpty){
                                toastFailedMessage("Please add your feedback", kRed);
                              } else {
                                 carRatingsWidget();
                                // if(rateCarModelObject.status == "Success"){
                                //   toastSuccessMessage("${rateCarModelObject.message}", colorGreen);
                                // }
                                // if(rateCarModelObject.status == "error"){
                                //   toastFailedMessage("${rateCarModelObject.message}", kRed);
                                // }
                              }
                            }
                          },
                          child: Center(
                            child: Container(
                              height: 44,
                              width: 202,
                              decoration: BoxDecoration(
                                  color: borderColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
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
