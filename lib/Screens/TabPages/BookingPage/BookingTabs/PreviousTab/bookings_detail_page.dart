import 'package:flutter/material.dart';
import '../../../../../Widget/button.dart';
import '../../../../../Utils/colors.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import '../tabbar_bookings_detail_page.dart';
import 'bookings_detail_previous.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({super.key});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
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
            const BookingsDetailsPrevious(),
            const TabbarBookingsDetails(),
            GestureDetector(
                onTap: () {
                  ratingsdialogbox(context);
                },
                child: loginButton('Give Ratings', context)),
          ],
        ),
      ),
    );
  }

  void ratingsdialogbox(BuildContext context) {
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
                      const Text(
                        "Give your Ratings \n   and Feedback",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffb0b0b0),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Image.asset(
                        "assets/car_bookings_images/rating.png",
                        height: 30,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      TextField(
                        cursorColor: borderColor,
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
                            Navigator.pop(context);
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
