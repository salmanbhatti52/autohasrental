import 'package:flutter/material.dart';
import '../../../../../Utils/colors.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';
import '../tabbar_bookings_detail_page.dart';
import 'upcoming_bookings_details_top_widget.dart';

class UpcomingBookingDetailPage extends StatefulWidget {
  const UpcomingBookingDetailPage({super.key});

  @override
  State<UpcomingBookingDetailPage> createState() => _UpcomingBookingDetailPageState();
}

class _UpcomingBookingDetailPageState extends State<UpcomingBookingDetailPage> {
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
            UpcomingBookingsDetailsTopWidget(),
            TabbarBookingsDetails(),
            // GestureDetector(
            //     onTap: () {
            //       ratingsdialogbox(context);
            //     },
            //     child: loginButton('Give Ratings', context)),
          ],
        ),
      ),
    );
  }
}
