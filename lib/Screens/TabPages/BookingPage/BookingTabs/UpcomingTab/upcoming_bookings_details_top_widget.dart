import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../Model/HomePageModels/BookingModels/booking_cancel_dialogbox_model.dart';
import '../../../../../Model/HomePageModels/BookingModels/cancelled_booking_model.dart';
import '../../../../../Utils/api_urls.dart';
import '../../../../../Utils/colors.dart';
import '../../../../../Utils/constants.dart';
import 'package:http/http.dart' as http;
import '../../../../../Utils/fontFamily.dart';
import '../../../../../Widget/toast_message.dart';

class UpcomingBookingsDetailsTopWidget extends StatefulWidget {
  const UpcomingBookingsDetailsTopWidget({super.key});

  @override
  State<UpcomingBookingsDetailsTopWidget> createState() =>
      _UpcomingBookingsDetailsTopWidgetState();
}

class _UpcomingBookingsDetailsTopWidgetState
    extends State<UpcomingBookingsDetailsTopWidget> {
  sharedPrefs() async {
    loadingP = true;
    setState(() {});
    print('in UpcomingBookingCarDetails sharedPrefs');
    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print("userId in UpcomingBookingCarDetails $userId");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();
  }

  CancelUpcomingBookingDetailsPageModel
      cancelUpcomingBookingDetailsPageModelObject =
      CancelUpcomingBookingDetailsPageModel();
  BookingCancelDialogModel bookingCancelDialogModelObject =
      BookingCancelDialogModel();

  cancelUpcomingBookingDetailsPageModelWidget() async {
    loadingP = true;
    setState(() {});

    prefs = await SharedPreferences.getInstance();
    userId = (prefs!.getString('userid'));
    print('in cancelUpcomingBookingDetailsPageModelApi');

    try {
      String apiUrl = cancelBookingUpcomingCarsApiUrl;
      print("cancelUpcomingBookingDetailsPageModelApi: $apiUrl");
      final response = await http.post(Uri.parse(apiUrl), headers: {
        'Accept': 'application/json'
      }, body: {
        // "users_customers_id": userId
        "users_customers_id": "1"
      });
      print('${response.statusCode}');
      print(response);
      if (response.statusCode == 200) {
        final responseString = response.body;
        print(
            "responseCancelUpcomingBookingDetailsPageModel: ${responseString.toString()}");
        cancelUpcomingBookingDetailsPageModelObject =
            cancelledBookingModelFromJson(responseString);
        print(
            "cancelUpcomingBookingDetailsPageModelStatus: ${cancelUpcomingBookingDetailsPageModelObject.status}");
      }
    } catch (e) {
      print('Error in cancelUpcomingBookingDetailsPageModel: ${e.toString()}');
    }
    loadingP = false;
    setState(() {});
  }

  bool progress = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: progress,
      opacity: 0.02,
      blur: 0.5,
      color: Colors.transparent,
      progressIndicator: CircularProgressIndicator(
        color: borderColor,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        color: Colors.transparent,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: previousItemsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
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
                        height: MediaQuery.of(context).size.height * 0.24,
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
                                const SizedBox(height: 93.6),
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
                                              0.12),
                                      Row(
                                        children: [
                                          Text(
                                            "${previousItemsList[index].carCompanyName} | ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: poppinBold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${previousItemsList[index].textModel} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 12,
                                              fontFamily: 'Poppins_Regular',
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "${previousItemsList[index].carModelYear} ",
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 14,
                                              fontFamily: poppinMedium,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            previousItemsList[index].range,
                                            style: TextStyle(
                                              color: kBlack,
                                              fontSize: 10,
                                              fontFamily: poppinRegular,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 04),
                                            child: Text(
                                              "RM",
                                              style: TextStyle(
                                                color: kRed,
                                                fontSize: 5,
                                                fontFamily: poppinRegular,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            previousItemsList[index].oldPrice,
                                            style: TextStyle(
                                                color: kRed,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: kRed,
                                                decorationThickness: 3,
                                                fontSize: 10,
                                                fontFamily: poppinLight,
                                                height: 2),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(width: 5),
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
                                              previousItemsList[index].newPrice,
                                              style: TextStyle(
                                                color: borderColor,
                                                fontSize: 20,
                                                fontFamily: poppinSemiBold,
                                              ),
                                              textAlign: TextAlign.left),
                                          Text(
                                            "/ Month",
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
                                          Image.asset(
                                              "assets/car_bookings_images/rating_stars.png"),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                          Text(
                                            "4.0",
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
                                              0.01),
                                      Row(
                                        children: [
                                          Image.asset(
                                              "assets/car_bookings_images/promoted.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Verified Dealer",
                                            style: TextStyle(
                                              color: textLabelColor,
                                              fontSize: 10,
                                              fontFamily: poppinRegular,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(
                                            width: 05,
                                          ),
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
                              previousItemsList[index].discountText,
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
                    left: 20,
                    child: Image.asset(
                      previousItemsList[index].carImage,
                      width: 325,
                      height: 175,
                    ),
                  ),
                  Positioned(
                      top: 10,
                      right: 15,
                      child: Image.asset(
                        "assets/car_bookings_images/heart.png",
                      )),
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
                              // setState(() {
                              //   progress = true;
                              // });
                              // await cancelUpcomingBookingDetailsPageModelWidget();
                              // if (cancelUpcomingBookingDetailsPageModelObject.status == "success") {
                              //   Future.delayed(const Duration(seconds: 3), () {
                              //     print("cancelUpcomingBookingDetailsPageModel Success");
                              //     toastSuccessMessage("${cancelUpcomingBookingDetailsPageModelObject.status}", colorGreen);
                              //     setState(() {
                              //       progress = false;
                              //     });
                              //     print("false: $progress");
                              //   });
                              // }
                              // if (cancelUpcomingBookingDetailsPageModelObject.status != "success") {
                              //   setState(() {
                              //     progress = false;
                              //   });
                              //   print("cancelUpcomingBookingDetailsPageModel");
                              //   toastFailedMessage("cancelUpcomingBookingDetailsPageModel", Colors.red);
                              // }

                              cancelDialogBox(context);
                            },
                            child: Container(
                              width: 102,
                              height: 25,
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
              );
            }),
      ),
    );
  }

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
                            if (bookingCancelDialogModelObject.status ==
                                "success") {
                              toastSuccessMessage(
                                  bookingCancelDialogModelObject.message,
                                  colorGreen);
                              Navigator.pop(context);
                            }
                            if (bookingCancelDialogModelObject.status !=
                                "success") {
                              toastFailedMessage(
                                  "booking not updated or its its already in cancelled status",
                                  kRed);
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

List previousItemsList = [
  PreviousItemsClass("assets/car_bookings_images/tesla_car_image.png", "5%",
      'TESLA', "MODEL", "Y LONG RANGE ", "2022", "9,000", "8,500"),
];

class PreviousItemsClass {
  final String carImage;
  final String discountText;
  final String carCompanyName;
  final String textModel;
  final String range;
  final String carModelYear;
  final String oldPrice;
  final String newPrice;

  PreviousItemsClass(
      this.carImage,
      this.discountText,
      this.carCompanyName,
      this.textModel,
      this.carModelYear,
      this.range,
      this.oldPrice,
      this.newPrice);
}
