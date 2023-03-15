import 'package:auto_haus_rental_app/Model/get_rate_cars_model.dart';
import 'package:auto_haus_rental_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../../../../Model/BookingModels/Previous/Photo/photo_previous_model.dart';
import '../../../../../../Model/car_ratings_model.dart';
import '../../../MyAppBarHeader/app_bar_header.dart';

class UpcomingBookingDetailsPage extends StatefulWidget {
  final DatumPhotoPrevious? datumPreviousPhoto;
 final String? bookingId;

  UpcomingBookingDetailsPage({super.key, this.datumPreviousPhoto, this.bookingId /*this.carDesc, this.carMonths*/});

  @override
  State<UpcomingBookingDetailsPage> createState() => _UpcomingBookingDetailsPageState();
}

class _UpcomingBookingDetailsPageState extends State<UpcomingBookingDetailsPage> {
  double? ratingValue;
  var carRatingController = TextEditingController();
  final GlobalKey<FormState> ratingsFormKey = GlobalKey<FormState>();
  RateCarModel rateCarModelObject = RateCarModel();
  GetStatusRateCarsModel getRateCarsModel = GetStatusRateCarsModel();
  bool loadingP = true;

  @override
  void initState() {

    super.initState();
    print("bookingId ${widget.bookingId}");
  }


  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarSingleImage(
          backImage: "assets/car_bookings_images/back_arrow.png", title: "Bookings"),
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
                    url: Uri.parse("https://app.autohauscarrental.com/api/bookings_print/${widget.bookingId}"),
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
                    child: CircularProgressIndicator(color: borderColor,),
                  ),
              ],
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Container(
          //       height: 100,
          //       color: Colors.transparent,
          //     ),
          //   ),
          // ),

        ],
      ),
    );
  }
}
