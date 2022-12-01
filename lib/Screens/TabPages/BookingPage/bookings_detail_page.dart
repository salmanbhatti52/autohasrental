
import 'package:flutter/material.dart';

import '../../../Widget/colors.dart';
import '../../../Widget/previous_page.dart/bookings_detail_previous.dart';
import '../../../Widget/tabbar_bookings_detail_page.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({super.key});

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
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
            const BookingsDetailsPrevious(),
            const SizedBox(height: 20),
            const TabbarBookingsDetails(),
          ],
        ),
      ),
    );
  }
}
