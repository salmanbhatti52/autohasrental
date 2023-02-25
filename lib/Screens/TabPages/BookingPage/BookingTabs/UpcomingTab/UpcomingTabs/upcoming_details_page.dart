import 'package:auto_haus_rental_app/Model/car_ratings_model.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:auto_haus_rental_app/Utils/constants.dart';
import 'package:auto_haus_rental_app/Utils/fontFamily.dart';
import 'package:auto_haus_rental_app/Utils/rating_stars.dart';
import 'package:auto_haus_rental_app/Widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Model/BookingModels/booking_cancel_dialogbox_model.dart';
import '../../../../../../Utils/colors.dart';
import '../../../../MyAppBarHeader/app_bar_header.dart';
import 'package:http/http.dart'as http;
import 'DrivingUpcoming/DrivingTabs/driving_upcoming_tabbar.dart';

class UpcomingDetailsPage extends StatefulWidget {
  final String? carName, carModel, carPrice, carRating, carColors,
      carId, carYear, carMakes, carImage, discountPercentage, carDesc, carMonths,
      userRating, userComment;

  const UpcomingDetailsPage({super.key, this.carName, this.carModel, this.carId,
    this.carYear, this.carImage, this.carMakes, this.discountPercentage,
    this.carColors, this.carPrice, this.carRating, this.carDesc, this.carMonths,
    this.userRating, this.userComment});

  @override
  State<UpcomingDetailsPage> createState() => _UpcomingDetailsPageState();
}

class _UpcomingDetailsPageState extends State<UpcomingDetailsPage> {

  double? ratingValue;
  var carRatingController = TextEditingController();
  final GlobalKey<FormState> ratingsFormKey = GlobalKey<FormState>();
  RateCarModel rateCarModelObject = RateCarModel();
  bool loadingP = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("carImage ${widget.carImage}}");
    print("carImage1 ${widget.userComment}}");
    print("carImage2 ${widget.userRating}}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarSingleImage(
          backImage: "assets/car_bookings_images/back_arrow.png",
          title: "Bookings"),
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  Positioned(
                    top: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
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
                            Row(
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.1),
                                      Row(
                                        children: [
                                          Text(
                                            "${widget.carName} | ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: poppinBold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${widget.carColors} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: 'Poppins_Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [

                                          Text(
                                            "${widget.carModel} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: 'Poppins_Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),

                                          Text(
                                            "${widget.carMakes} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 10,
                                              fontFamily: poppinRegular,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${widget.carYear} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: poppinMedium,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height *
                                            0.005,
                                      ),
                                      Row(
                                        children: [

                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 06),
                                            child: Text(
                                              "RM",
                                              style: TextStyle(
                                                color: borderColor,
                                                fontSize: 7,
                                                fontFamily: poppinSemiBold,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                              "${widget.carPrice}",
                                              style: TextStyle(
                                                color: borderColor,
                                                fontSize: 20,
                                                fontFamily: poppinSemiBold,
                                              ),
                                              textAlign: TextAlign.left),
                                          Text(
                                            "/Slot",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 8,
                                              fontFamily: poppinRegular,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                          ),
                                          showRatingStars(double.parse("${widget.userRating}")),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.01,
                                          ),
                                          Text("${widget.userRating}",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: poppinRegular,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.005),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/car_bookings_images/promoted.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text("Verified Dealer", textAlign: TextAlign.left,
                                            style: TextStyle(color: textLabelColor, fontSize: 10, fontFamily: poppinRegular,
                                            ),

                                          ),
                                          const SizedBox(width: 05,),
                                          Container(
                                            height: 15,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                color: kBlack,
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                "New",
                                                style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: 8,
                                                  fontFamily: poppinRegular,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
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
                            Text(
                              "${widget.discountPercentage}",
                              style: TextStyle(
                                color: kWhite,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(" OFF ",
                                style: TextStyle(
                                  color: kWhite,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                )),
                          ],
                        ),
                      )),
                  Positioned(
                      top: 10,
                      right: 15,
                      child: Image.asset(
                        "assets/car_bookings_images/heart.png",
                      )),
                  Positioned(
                    left: 20,
                    child: Image.network(
                      "${widget.carImage}",
                      width: 300,
                      height: 130,
                    ),
                  ),

                  Positioned(
                    top: 90,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, right: 20),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              cancelDialogBox(context);
                            },
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                color: kRed,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: poppinRegular,
                                    color: kWhite,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            DrivingUpcomingTabBar(
              carDessc: widget.carDesc,
              userComment: widget.userComment,
              userRating: widget.userRating,
            ),
          ],
        ),
      ),
    );
  }

  bool progress = false;
  void cancelDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ModalProgressHUD(
            inAsyncCall: progress,
            opacity: 0.02,
            blur: 0.5,
            color: Colors.transparent,
            progressIndicator: CircularProgressIndicator(
              color: borderColor,
            ),
            child: Container(
              color: const Color(0xffb0b0b0),
              child: Container(
                color: const Color(0xff0f172a).withOpacity(0.5),
                child: AlertDialog(
                  scrollable: true,
                  backgroundColor: homeBgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  content: Column(
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
                        "Cancel?",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: borderColor),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        "Are you sure you want \n to cancel your booking?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: kBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      const Text(
                        "* Cancelling booking will result in \n 10% cut of your payment.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffff6666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      const Text(
                        "* Booking can not be cancelled if \n 24 hours are remaining in starting.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffff6666),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: GestureDetector(
                          onTap: () async {
                            await cancelBookingDialogBoxModelWidget();
                            if (bookingCancelDialogModelObject.status == "success") {
                              toastSuccessMessage(bookingCancelDialogModelObject.message, colorGreen);
                              Navigator.pop(context);
                            }
                            if (bookingCancelDialogModelObject.status != "success") {
                              toastFailedMessage("booking not updated or its its already in cancelled status", kRed);
                              Navigator.pop(context);
                            }
                            // Navigator.pop(context);
                          },
                          child: Container(
                            width: 186,
                            height: 44,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 186,
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: const Color(0xffff6666), width: 1)),
                            child: const Center(
                              child: Text('No',
                                  style: TextStyle(
                                      color: Color(0xffff6666),
                                      fontFamily: 'Poppins',
                                      fontSize: 16)),
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
  BookingCancelDialogModel bookingCancelDialogModelObject = BookingCancelDialogModel();
  cancelBookingDialogBoxModelWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in cancelBookingDialogModelApi');

    try {
      String apiUrl = cancelBookingDialogBoxApiUrl;
      print("cancelBookingDialogModelModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        // "users_customers_id": "1",
        "users_customers_id": userId,
        "bookings_id": "1",
        "status": "Cancelled",
      });
      print('statusCode ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseString = response.body;
        print("responseCancelBookingDialogModel: ${responseString.toString()}");
        bookingCancelDialogModelObject =
            bookingCancelDialogModelFromJson(responseString);
        print(
            "cancelBookingDialogModelStatus: ${bookingCancelDialogModelObject.status}");
      }
    } catch (e) {
      print('Error in cancelBookingDialogModel: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }
}
