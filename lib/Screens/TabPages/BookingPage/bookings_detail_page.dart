import 'package:flutter/material.dart';
import '../../../Widget/colors.dart';
import '../../../Widget/tabbar_bookings_detail_page.dart';
import '../MyAppBarHeader/app_bar_header.dart';
import 'BookingTabs/ProviousTab/bookings_detail_previous.dart';

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
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: const [
            BookingsDetailsPrevious(),
            TabbarBookingsDetails(),
          ],
        ),
      ),
    );
  }
}
