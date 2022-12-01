import 'package:flutter/material.dart';

import '../../../Widget/colors.dart';
import '../../../Widget/tabbar_bookings_detail_page.dart';
import '../../../Widget/upcoming_page/bookings_details_upcoming.dart';

class BookingDetailPage2 extends StatefulWidget {
  const BookingDetailPage2({super.key});

  @override
  State<BookingDetailPage2> createState() => _BookingDetailPage2State();
}

class _BookingDetailPage2State extends State<BookingDetailPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homeBgColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                        'assets/car_bookings_images/back_arrow.png',
                        width: 18,
                        height: 15),
                  ),
                  const SizedBox(width: 100),
                  Text(
                    "Bookings",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: appBgColor),
                  ),
                ],
              ),
            ),
            const BookingsDetailsUpcoming(),
            const SizedBox(height: 20),
            const TabbarBookingsDetails(),
          ],
        ),
      ),
    );
  }
}
