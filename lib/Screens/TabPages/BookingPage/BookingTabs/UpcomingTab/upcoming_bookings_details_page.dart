
import 'package:flutter/material.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:auto_haus_rental_app/Utils/api_urls.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:auto_haus_rental_app/Screens/TabPages/MyAppBarHeader/app_bar_header.dart';

class UpcomingBookingDetailsPage extends StatefulWidget {
  final String? bookingId;

  UpcomingBookingDetailsPage({super.key, this.bookingId});

  @override
  State<UpcomingBookingDetailsPage> createState() => _UpcomingBookingDetailsPageState();
}

class _UpcomingBookingDetailsPageState extends State<UpcomingBookingDetailsPage> {

  @override
  void initState() {
    super.initState();
    print("bookingPrintApiUrl $bookingPrintApiUrl${widget.bookingId}");
  }


  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarSingleImage(
          backImage: "assets/car_bookings_images/back_arrow.png", title: "Booking Details"),
      backgroundColor: homeBgColor,
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            // flex: 5,
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
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
                    child: CircularProgressIndicator(color: borderColor),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
