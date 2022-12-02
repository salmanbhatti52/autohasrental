import 'package:flutter/material.dart';
import '../../../Widget/colors.dart';
import '../../../Widget/tabbar_bookings_detail_page.dart';
import '../../../Widget/upcoming_page/bookings_details_upcoming.dart';
import '../MyAppBarHeader/app_bar_header.dart';

class BookingDetailPage2 extends StatefulWidget {
  const BookingDetailPage2({super.key});

  @override
  State<BookingDetailPage2> createState() => _BookingDetailPage2State();
}

class _BookingDetailPage2State extends State<BookingDetailPage2> {
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
          children: const [
            BookingsDetailsUpcoming(),
            TabbarBookingsDetails(),
          ],
        ),
      ),
    );
  }
}
